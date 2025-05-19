##01 01  * * 6 /db_adm/scripts/db2_reorg.sh -i db2inst1 -d LIST_DB -e 060000 -o inplace  -s ALL -r vary -y no > /tmp/db2_reorg.LIST_DB.INPLACE.STAR.VARY.log &
-----------------
#!/bin/sh
#*********************************************************************#
#*********************************************************************#
#######################################################################
# This script runs the reorgchk and then determines which tables to
# perform a reorg-on...you can have it perform inplace or standard classic
# reorgs followed by a runstats if you wish.
#
# ./db2_gatekeeper.sh 1 2 3 4 5 6 7 8 9
#
# Options:
# -i Instance name  (1):  <instance>                        [gets folded to lower-case]
# -d Database name  (2):  <db>                              [gets folded to lower-case]
# -e Stop at time   (3):  083000|NOENDTIME                  [gets folded to UPPER-case]
# -o RunType Option (4):  RUNSTATS|REORGS|REORGHWM|REORGUSETS|INPLACE|REORGINDEXES|LOAD [gets folded to UPPER-case]
# -s RunType Scope  (5):  ALL|STAR|LEFTRIGHTSTAR            [gets folded to UPPER-case]
# -r Sort Type      (6):  ASC|DESC|VARY|NONE                [gets folded to UPPER-case]
# -f Flush          (7):  YES|NO                            [gets folded to UPPER-case]
# -y System Scope   (8):  YES|NO|ONLY                       [gets folded to UPPER-case]
# -n Include Option (9):  YES|NO|FIRST|ONLY                 [gets folded to UPPER-case]
# -c Include File   (10):  ex: /usr/local/bin/FILENAME
#
# -e (3) endtime must be in 123056 format for 12:30:56
# -o (4) tells the script what you want it to do
#
# -s (5) is the scope (all tables, all tables with STAR in reorgchk, etc...
#
#    (5) LEFTRIGHTSTAR=egrep '( \*..| ..\*)' will reorg those files like '*_*'
#    (5) STAR= grep '*' will scan for and find all tables with '*'
#
# -r (6) is the SORT scope (ASC=Ascending, DESC=Descending,
#    VARY=Day 1-15=Ascending, Day 16-31=Descending
#    NONE=Don't do any sort
#
# -f (7) is the Flush behavior,
#    Yes=flush package cache dynamic
#    No=Don't flush
#
# -y (8) is the SYSTEM scope (Yes=Include System Catalog Tables, No, Only)
#
#     Yes to include SYSTEM tables like any other table,
#     No to not include any SYSTEM tables
#     ONLY to only do the SYSTEM tables
#
# -n (9) is the INCLUDE scope to use an external file for processing
#
#     No=Don't use an external file
#     Yes=Include a file and sort it with the rest of the tables
#     First=Include a file but process those first
#     Only=Include a file and only process that file
#
# -c (10) If (9) INCLUDE = Yes|ONLY|First then there needs to be a file name to process
#
#------------
# You can pause gatekeeper by running this statement
# in /tmp.
#
# touch db2_gatekeeper_pause.txt          <== will pause gatekeeper...
#--------
# You can restart gatekeeper by running this statement
# in /tmp.
#
# rm    db2_gatekeeper_pause.txt          <== will resume gatekeeper..
#------------
# You can stop gatekeeper by running this statement
# in /tmp.
#
# touch db2_gatekeeper_stop.txt           <== will stop gatekeeper..
# rm    db2_gatekeeper_stop.txt           <== will end ths stop of gatekeeper..
#------------
# Other Reorg Commands:
#
# db2 reorg table tivadsn.tiva_premrec inplace stop
# db2 reorg table tivadsn.tiva_premrec inplace start
# db2 reorg table tivadsn.tiva_premrec inplace pause
# db2 reorg table tivadsn.tiva_premrec inplace resume
#
# If the day-of-week is 16-31 then we list the tables in DESCENDING order
# just to make sure that we attack this problem from both-ends.
#
# reorgindexes will reorg just those indexes that the reorgchk tells it
# to reorg.  You should specify 'ALL' with this option but if you do it
# just means that all tables are considered for the reorgindex not that
# all tables necessarily get reorged.  Again, it just depends on what
# what reorgchk says to reorg.
#
# see also: db2_gatekeeper_mon
#
######################################################################
#
# Modified 5/18/2009 by Bruce
#
# Enhanced:
#
# Added FLUSH=Yes|No
#
# Modified 4/10/2009 by Bruce
#
# Enhanced:
#
# SYSTEM Catalog Tables can now be included SYSTEM=Yes, No, ONLY
# INCLUDE option (Yes, No, Only, First)
# INCLUDE FILE option (include a file of SCHEMA.TABLENAMES
#
######################################################################
##
## We parse the reorgchk output...
##
##
## Table statistics:
##
## F1: 100 * OVERFLOW / CARD < 5
## F2: 100 * (Effective Space Utilization of Data Pages) > 70
## F3: 100 * (Required Pages / Total Pages) > 80
##
## SCHEMA    NAME                  CARD    OV    NP    FP ACTBLK    TSIZE  F1  F2  F3 REORG
## ----------------------------------------------------------------------------------------
## Table: ADJUSTTS.CONTAINERS
## ADJUSTTS  CONTAINERS             312    0    13    13    -      -1  0  0 100 -*-
## Table: ADJUSTTS.TABLESPACES
## ADJUSTTS  TABLESPACES            117    0    3    3      -      -1  0  0 100 -*-
## Table: ADJUSTTS.TBSNAME
## ADJUSTTS  TBSNAME                107    0    5    5      -      -1  0  0 100 -*-
##
## Index statistics:
#######################################################################
set -x
. $HOME/sqllib/db2profile
DBLIST="LIST_DB"
script_dir="/db_adm/scripts"
log_dir="$HOME/logs"
curdow=$(date +%w)
curdate=$(date +%d)
curdowA=$(date +%a)
history_dir="$HOME/logs/history/${curdowA}"

EMAILADDRESSES="bfairchild@xtivia.com"

TMPDIR=$history_dir
rm /tmp/TABLIST.tmp
rm /tmp/IDXLIST.tmp
touch /tmp/TABLIST.tmp
touch /tmp/IDXLIST.tmp
RC=0

clear

STARTTIME=`date +%H%M%S`

SYSTEM=`uname -n`
################################################################

##############################################
# Get the Command Line Options.
##############################################

args=`getopt i:d:e:o:s:r:f:y:n:c:h $*`
rtn=$?

if [ $rtn != 0 ]; then
  echo "FAIL: getopt() returned error code $rtn since $1 is not a valid option"
  exit 1
fi

if [ -z "$1" ]; then
  echo "db2_gatekeeper.sh requires options (try -h)"
  echo " "
  exit 1
fi

for opt
do
  case "$opt" in
  -i)  shift;INSTANCE=`echo $1 | tr '[A-Z]' '[a-z]' `      ;shift;;     # Force lowercase
  -d)  shift;DB=`echo $1 | tr '[A-Z]' '[a-z]' `            ;shift;;     # Force lowercase
  -e)  shift;ENDTIME=`echo $1 | tr '[a-z]' '[A-Z]' `       ;shift;;     # Force lowercase
  -o)  shift;OPTION=`echo $1 | tr '[a-z]' '[A-Z]' `        ;shift;;     # Force UPPERCASE
  -s)  shift;SCOPE=`echo $1 | tr '[a-z]' '[A-Z]' `         ;shift;;     # Force UPPERCASE
  -r)  shift;SORT=`echo $1 | tr '[a-z]' '[A-Z]' `          ;shift;;     # Force UPPERCASE
  -f)  shift;FLUSH=`echo $1 | tr '[a-z]' '[A-Z]' `         ;shift;;     # Force UPPERCASE
  -y)  shift;SYSTEMSCOPE=`echo $1 | tr '[a-z]' '[A-Z]' `   ;shift;;     # Force UPPERCASE
  -n)  shift;INCLUDESCOPE=`echo $1 | tr '[a-z]' '[A-Z]' `  ;shift;;     # Force UPPERCASE
  -c)  shift;INCLUDEFILE=`echo $1`                         ;shift;;     # Left Untouched
  -h)  echo "db2_gatekeeper.sh "
       echo " "
       echo " -i = Instance"
       echo " -d = Database"
       echo " -e = Valid time such as 083000 or NOENDTIME"
       echo " -o = Run Option must be RUNSTATS|REORGS|REORGUSETS|REORGHWM|INPLACE|REORGINDEXES|LOAD"
       echo " -s = Run Scope must be ALL|STAR|LEFTRIGHTSTAR"
       echo " -r = Sort Scope must be ASC|DESC|VARY|NONE"
       echo " -f = Flush must be YES|NO"
       echo " -y = SYSTEM Scope must be YES|NO|ONLY"
       echo " -n = INCLUDE Scope must be YES|NO|FIRST|ONLY"
       echo " -c = INCLUDEFILE must be fully-qualified file /tmp/filename.txt when INCLUDE=YES|FIRST|ONLY"
       echo " -h = Got you here"
       exit 8
  esac
done

##############################################
# Default the option and scope for file-names...
##############################################

if [ ! -n "$OPTION" ]; then
  echo "WARNING: Run-time Option set to default RUNSTATS"
  OPTION="RUNSTATS"
fi

if [ ! -n "$SCOPE" ]; then
  echo "WARNING: Run-time Scope set to default ALL"
  SCOPE="ALL"
fi

TRIGGERFILE="/tmp/reorg.trigger.${DB}"

###if [ test -f $TRIGGERFILE ]; then
###  rm $TRIGGERFILE
###fi

THISRUN="$INSTANCE.$DB.$OPTION.$SCOPE"
LOGFILE=${TMPDIR}/db2_gatekeeper.batch.run.${THISRUN}.txt
ERRFILE=${TMPDIR}/db2_gatekeeper.message.${THISRUN}.out
REORGCHK=${TMPDIR}/db2_gatekeeper.reorgchk.${THISRUN}.out
TMPFILE=${TMPDIR}/db2_gatekeeper.output.${THISRUN}.tmp
SORTFILE=${TMPDIR}/db2_gatekeeper.output.sorted.${THISRUN}.out
DELETEFLAG=${TMPDIR}/db2_gatekeeper_deleteme.${THISRUN}.out
RELEASEFLAG=${TMPDIR}/db2_gatekeeper_deleteme_released.${THISRUN}.out
RUNLOG=${TMPDIR}/db2_gatekeeper_runstatlog.${THISRUN}.out
RCERRORLOG=${TMPDIR}/db2_gatekeeper_runstats.errors.${THISRUN}.out
PAUSEFLAG=${TMPDIR}/db2_gatekeeper_pause.txt
STOPFLAG=${TMPDIR}/db2_gatekeeper_stop.txt

MAXREORGSTORUN=3

if [ -f /home/$INSTANCE/sqllib/db2profile ]; then
      . /home/$INSTANCE/sqllib/db2profile
fi

echo "********************************************"
echo "********************************************"                 >> $LOGFILE
echo "Starting-up Gatekeeper Version 05/26/2009.9:00"
echo "Starting-up Gatekeeper Version 05/26/2009.9:00"               >> $LOGFILE

##############################################
# If DB2 isn't up...
##############################################

let OPERABLE=0
let NOTOPERABLE=0
OPERABLE=`db2gcf -s -i $INSTANCE | grep "DB2 State" | grep "Operable" | wc | awk '{print $1}'`
NOTOPERABLE=`db2gcf -s -i $INSTANCE | grep "DB2 State" | grep "Not operable" | wc | awk '{print $1}'`

if [ $OPERABLE -ne 0 ]; then
  echo "DB2 is not up"
  echo "DB2 is not up" >> $LOGFILE
  RC=8
fi

if [ $NOTOPERABLE -ne 0 ]; then
  echo "DB2 is not up"
  echo "DB2 is not up" >> $LOGFILE
  RC=8
fi

###
### Fold the lower-case to UC to see if the DB exists...
###
DBUC=`echo $DB | tr '[a-z]' '[A-Z]' `

DBCOUNT=`db2 list db directory | grep $DBUC | grep -v name | wc | awk '{print $1}'`

if [ $DBCOUNT -eq 0 ]; then
  echo "ERROR: Database $DBUC does not exist"
  echo "ERROR: Database $DBUC does not exist" >> $LOGFILE
  RC=8
fi

##############################################
# Set other defaults...
##############################################

if [ $OPTION == "REORGS" ]; then
  OPTION="REORG"
fi

if [ ! -n "$ENDTIME" ]; then
  echo "WARNING: EndTime Option set to default NOENDTIME"
  echo "WARNING: EndTime Option set to default NOENDTIME" >> $LOGFILE
  ENDTIME="NOENDTIME"
fi

if [ ! -n "$SORT" ]; then
  echo "WARNING: Sort Scope set to default VARY"
  echo "WARNING: Sort Scope set to default VARY" >> $LOGFILE
  SORT="VARY"
fi

##############################################
# if RUNSTATS then default to FLUSH=YES
##############################################

if [ $OPTION == "RUNSTATS" ]; then
  if [ ! -n "$FLUSH" ]; then
    echo "WARNING: Since Runoption=RUNSTATS then Flush default set to FLUSH=YES"
    echo "WARNING: Since Runoption=RUNSTATS then Flush default set to FLUSH=YES" >> $LOGFILE
    FLUSH="YES"
  fi
fi

##############################################
# if NOT RUNSTATS then default to FLUSH=NO
##############################################

if [ $OPTION != "RUNSTATS" ]; then
  if [ ! -n "$FLUSH" ]; then
    echo "WARNING: Since Runoption not=RUNSTATS then Flush default set to FLUSH=NO"
    echo "WARNING: Since Runoption not=RUNSTATS then Flush default set to FLUSH=NO" >> $LOGFILE
    FLUSH="NO"
  fi
fi

if [ ! -n "$SYSTEMSCOPE" ]; then
  echo "WARNING: SYSTEM Scope set to default SYSTEM=NO"
  echo "WARNING: SYSTEM Scope set to default SYSTEM=NO" >> $LOGFILE
  SYSTEMSCOPE="NO"
fi

if [ ! -n "$INCLUDESCOPE" ]; then
  echo "WARNING: Include Scope set to default INCLUDE=NO"
  echo "WARNING: Include Scope set to default INCLUDE=NO" >> $LOGFILE
  INCLUDESCOPE="NO"
fi

if [ $INCLUDESCOPE != "NO" ]; then
  if [ ! -n "$INCLUDEFILE" ]; then
     echo "WARNING: Include File is not specified"
     echo "WARNING: Include File is not specified" >> $LOGFILE
     RC=8
  fi
fi

if [ $INCLUDESCOPE == "NO" ]; then
     INCLUDEFILE="/dev/null"
fi

if [ $INCLUDESCOPE != "NO" ]; then
 if [ $INCLUDEFILE != "/dev/null" ]; then
  if [ $INCLUDEFILE != "" ]; then
   if [ ! -f "$INCLUDEFILE" ]; then
     echo "WARNING: Include File '$INCLUDEFILE' cannot be found"
     echo "WARNING: Include File '$INCLUDEFILE' cannot be found" >> $LOGFILE
     RC=8
   fi
  fi
 fi
fi

if [ $OPTION != "RUNSTATS" ]; then
 if [ $OPTION != "REORGS" ]; then
  if [ $OPTION != "INPLACE" ]; then
   if [ $OPTION != "LOAD" ]; then
    if [ $OPTION != "REORGINDEXES" ]; then
     if [ $OPTION != "REORGUSETS" ]; then
      if [ $OPTION != "REORGHWM" ]; then
       if [ $OPTION != "REORG" ]; then
         echo "ERROR: Run-time Option must be RUNSTATS, REORGS, REORGUSETS, REORGHWM, INPLACE, REORGINDEXES, LOAD only"
         echo "ERROR: Run-time Option must be RUNSTATS, REORGS, REORGUSETS, REORGHWM, INPLACE, REORGINDEXES, LOAD only" >> $LOGFILE
         RC=8
       fi
      fi
     fi
    fi
   fi
  fi
 fi
fi

if [ $SCOPE != "ALL" ]; then
 if [ $SCOPE != "STAR" ]; then
  if [ $SCOPE != "LEFTRIGHTSTAR" ]; then
      echo "ERROR: Run-time Scope must be ALL, STAR, LEFTRIGHTSTAR only"
      echo "ERROR: Run-time Scope must be ALL, STAR, LEFTRIGHTSTAR only" >> $LOGFILE
      RC=8
  fi
 fi
fi

if [ $SORT != "ASC" ]; then
 if [ $SORT != "DESC" ]; then
  if [ $SORT != "VARY" ]; then
   if [ $SORT != "NONE" ]; then
      echo "ERROR: Run-time Sort must be ASC, DESC, VARY, NONE only"
      echo "ERROR: Run-time Sort must be ASC, DESC, VARY, NONE only" >> $LOGFILE
      RC=8
   fi
  fi
 fi
fi

if [ $FLUSH != "NO" ]; then
 if [ $FLUSH != "YES" ]; then
      echo "ERROR: Flush must be Yes or No only"
      echo "ERROR: Flush must be Yes or No only" >> $LOGFILE
      RC=8
 fi
fi

if [ $SYSTEMSCOPE != "NO" ]; then
 if [ $SYSTEMSCOPE != "YES" ]; then
  if [ $SYSTEMSCOPE != "ONLY" ]; then
      echo "ERROR: System Scope must be Yes or No only (SYSTEM=NO or SYSTEM=YES or SYSTEM=ONLY)"
      echo "ERROR: System Scope must be Yes or No only (SYSTEM=NO or SYSTEM=YES or SYSTEM=ONLY)" >> $LOGFILE
      RC=8
  fi
 fi
fi

if [ $INCLUDESCOPE != "NO" ]; then
 if [ $INCLUDESCOPE != "YES" ]; then
  if [ $INCLUDESCOPE != "FIRST" ]; then
   if [ $INCLUDESCOPE != "ONLY" ]; then
      echo "ERROR: Include Scope must be INCLUDE=NO or INCLUDE=YES or INCLUDE=FIRST or INCLUDE=ONLY only"
      echo "ERROR: Include Scope must be INCLUDE=NO or INCLUDE=YES or INCLUDE=FIRST or INCLUDE=ONLY only" >> $LOGFILE
      RC=8
   fi
  fi
 fi
fi

if [ $INCLUDESCOPE == "FIRST" ]; then
    SORT="NONE"
    echo "WARNING: Include Scope set SORT=NONE"
    echo "WARNING: Include Scope set SORT=NONE" >> $LOGFILE
fi

HADR=`db2 get db cfg for $DB | grep "HADR database role" | egrep 'STANDBY' | wc | awk '{print $1}'`

if [ $HADR -ne 0 ];then
    echo "Database $DB is HADR STANDBY"
    echo "Database $DB is HADR STANDBY"  >> $LOGFILE
    RC=8
fi

if [ -f $STOPFLAG ]; then
    echo "Warning: STOP found in /tmp."
    echo "Warning: STOP found in /tmp."    >> $LOGFILE
    RC=8
fi

##############################################
# If we can't figure it out then exit early
##############################################

if [ $RC -eq 8 ]; then
    echo    "Gatekeeper errors found at time: $(date +%H%M%S)"
    echo    "Gatekeeper errors found at time: $(date +%H%M%S)" >> $ERRFILE
    mail -s "SEV 3 on $SYSTEM (db2_gatekeeper.sh) is reporting errors found at time: $(date +%H%M%S)"  $EMAILADDRESSES<$LOGFILE
    exit $RC
fi

##############################################
# Remove any prior files
##############################################

if [ -f $LOGFILE ]; then
     rm $LOGFILE
fi

if [ -f $REORGCHK ]; then
     rm $REORGCHK
fi

if [ -f $TMPFILE ]; then
     rm $TMPFILE
fi

if [ -f $SORTFILE ]; then
     rm $SORTFILE
fi

if [ -f $ERRFILE ]; then
     rm $ERRFILE
fi

if [ -f $DELETEFLAG ]; then
     rm $DELETEFLAG
fi

if [ -f $RELEASEFLAG ]; then
     rm $RELEASEFLAG
fi

if [ -f $RUNLOG ]; then
     rm $RUNLOG
fi

if [ -f $RCERRORLOG ]; then
     rm $RCERRORLOG
fi

let SLEEP=15

db2 connect to $DB;

echo "Processing Instance: " $INSTANCE
echo "Processing Database: " $DB
echo "End Time " $ENDTIME " end time set... "
echo "Runtime Option " $OPTION " found and will be used... "
echo "Scope " $SCOPE " found and will be used... "
echo "Sort " $SORT " found and will be used... "
echo "Cache Flush " $FLUSH " found and will be used... "
echo "System Tables " $SYSTEMSCOPE " found and will be used... "
echo "Include Tables " $INCLUDESCOPE " found and will be used... "

echo "Processing Instance: " $INSTANCE                              >> $LOGFILE
echo "Processing Database: " $DB                                    >> $LOGFILE
echo "End Time " $ENDTIME " end time set... "                       >> $LOGFILE
echo "Runtime Option " $OPTION " found and will be used... "        >> $LOGFILE
echo "Scope " $SCOPE " found and will be used... "                  >> $LOGFILE
echo "Sort " $SORT " found and will be used... "                    >> $LOGFILE
echo "Cache Flush " $FLUSH " found and will be used... "            >> $LOGFILE
echo "System Tables " $SYSTEMSCOPE " found and will be used... "    >> $LOGFILE
echo "Include Tables " $INCLUDESCOPE " found and will be used... "  >> $LOGFILE

if [ -f $INCLUDEFILE ]; then

    echo $INCLUDEFILE " found and will be used... "
    echo $INCLUDEFILE " found and will be used... " >> $LOGFILE

    INCLUDEFILECOUNT=`cat $INCLUDEFILE | grep "." | wc | awk '{print $1}'`

    echo "Include file contains " $INCLUDEFILECOUNT " table(s)"
    echo "Include file contains " $INCLUDEFILECOUNT " table(s)" >> $LOGFILE

fi

if [ -f $PAUSEFLAG ]; then
    echo "Warning: Pause found in /tmp.  Waiting for work"
    echo "Warning: Pause found in /tmp.  Waiting for work"    >> $LOGFILE
fi

touch $TMPFILE

################################################################
#
# If they want the include file =yes or =first then do that here...
#

if [ $INCLUDESCOPE == "YES" ]; then
   cat $INCLUDEFILE  | tr '[a-z]' '[A-Z]' >> $TMPFILE
fi
if [ $INCLUDESCOPE == "FIRST" ]; then
   cat $INCLUDEFILE  | tr '[a-z]' '[A-Z]' >> $TMPFILE
fi

#
#
#
################################################################
################################################################
##Build list of tables and indexes based on TB_STATS or IDX_STATS proc
##
db2 connect to $DBLIST
if [ $OPTION == "INPLACE" ]; then
  db2 -x "CALL SYSPROC.REORGCHK_TB_STATS('T', 'ALL')" | grep "\*" | awk '{print $1 "." $2 }'> /tmp/TABLIST.tmp

### EXCLUDE all Volatile Tables from TABLIST output
##
db2 -x "select tabname from syscat.tables where volatile='C' and tabschema='WSCOMUSR'" > /tmp/EXCEPTIONLIST
cat /tmp/EXCEPTIONLIST | while read TABNAME
do
sed "/$TABNAME/d" /tmp/TABLIST.tmp > /tmp/reorgtemp2
cp /tmp/reorgtemp2 /tmp/TABLIST.tmp
done

### Remove ATTRVALUE from reorg list
sed "/ATTRVALUE/d" /tmp/TABLIST.tmp > /tmp/remove_attrvalue.tmp
mv /tmp/remove_attrvalue.tmp /tmp/TABLIST.tmp
fi

## EXCLUDE all volatile tables from IDX list output
##
if [ $OPTION == "REORGINDEXES" ]; then
db2 -x "call sysproc.reorgchk_ix_stats('T','ALL')" | grep "\*" | awk '{print $1 "." $2 }' > /tmp/IDXLIST.tmp
cat /tmp/IDXLIST.tmp
### EXCLUDE all Volatile Tables from IDXLIST output
##
db2 -x "select tabname from syscat.tables where volatile='C' and tabschema='WSCOMUSR'" > /tmp/EXCEPTIONLIST
cat /tmp/EXCEPTIONLIST | while read TABNAME
do
sed "/$TABNAME/d" /tmp/IDXLIST.tmp > /tmp/reorgtemp2
cp /tmp/reorgtemp2 /tmp/IDXLIST.tmp
done

### Remove ATTRVALUE from reorg list
sed "/ATTRVALUE/d" /tmp/IDXLIST.tmp > /tmp/remove_attrvalue.tmp
mv /tmp/remove_attrvalue.tmp /tmp/IDXLIST.tmp
sed "/SYSUSERAUTH/d" /tmp/IDXLIST.tmp > /tmp/remove_sysuserauth.tmp
mv /tmp/remove_attrvalue.tmp /tmp/IDXLIST.tmp

cat /tmp/IDXLIST.tmp
##Remove any duplicate lines
uniq /tmp/IDXLIST.tmp /tmp/IDXLIST.tmp_temp
cp /tmp/IDXLIST.tmp_temp /tmp/IDXLIST.tmp

fi
createconnect="0"
reorgchk="0"
BUILT=0


################################################################
#
# If they ONLY want the include file then overlay the tmpfile here
#
if [ $INCLUDESCOPE == "ONLY" ]; then

   rm    $TMPFILE

   touch $TMPFILE

   cat $INCLUDEFILE  | tr '[a-z]' '[A-Z]' >> $TMPFILE
fi
#
#
#
################################################################

DAY=`date +%d`

#####
# Sorting depends on the SORT parm and which day it is, etc.
#####

## Assuming Ascending = "0"

sorting="0"

################################################################

if [ $SORT == "NONE" ]; then
        cat  $TMPFILE   > $SORTFILE
fi

if [ $SORT != "NONE" ]; then

        if [ $SORT == "VARY" ]; then
          if [ $DAY -gt 15 ]; then
            sorting="1"
          fi
        fi

        if [ $SORT == "DESC" ]; then
            sorting="1"
        fi

        if [ $sorting == "0" ]; then
            echo      "Gatekeeper sorting tables in ascending order."
            echo "\n" "Gatekeeper sorting tables in ascending order." >> $LOGFILE
            cat  $TMPFILE | sort  | uniq  > $SORTFILE
        fi


        if [ $sorting == "1" ]; then
            echo      "Gatekeeper sorting tables in descending order."
            echo "\n" "Gatekeeper sorting tables in descending order." >> $LOGFILE
            cat  $TMPFILE | sort -r | uniq > $SORTFILE
        fi

fi

################################################################

BUILT=`cat $SORTFILE | grep "." | wc | awk '{print $1}'`

#####
##
## Look through our output file counting-up the number of
## tables that we will be processing.
##
#####

##################################################################
########################### MAIN LOGIC ###########################
##################################################################

#####
##
## Main Logic...read through our files to process
## and do them all.
##
#####

echo "0" >> $RELEASEFLAG


ERRORCOUNT=0
ERRORCOUNTTOTAL=0

RELEASED=0
connect="0"

gatekeeper="0"
until [ $gatekeeper -eq "1" ]
do

cat $SORTFILE | while read

do

        if [ $connect == "0" ]; then

          db2 connect to $DB;
          connect="1"
        fi

#####
## Ignore any potential blank-lines in our file
#####

        BLANKLINECOUNT=`echo $REPLY | grep "." | wc | awk '{print $1}'`
        if [ $BLANKLINECOUNT -eq 0 ]; then
          continue
        fi

        #####
        ## Stop?
        ## if a file exists called '$STOPFLAG' then we will stop this utility now
        #####

        if [ -f $STOPFLAG ]; then

              echo ".....Stop Signal Received at $(date +%Y%m%d-%H%M%S)"
              echo ".....Stop Signal Received at $(date +%Y%m%d-%H%M%S)" >> $LOGFILE

          break

        fi

        #####
        ## Pause?
        ## if a file exists called '$PAUSEFLAG' then we will
        ## wait indefinitely for the file to go away...
        #####

        if [ -f $PAUSEFLAG ]; then

          finished="0"

          until [ $finished -eq "1" ]
          do

              echo ".....Pausing for 60 seconds at $(date +%Y%m%d-%H%M%S)"
              echo ".....Pausing for 60 seconds at $(date +%Y%m%d-%H%M%S)" >> $LOGFILE

              sleep 60

                if [ ! -f $PAUSEFLAG ]; then
                    finished="1"
                    echo ".....Resuming...at $(date +%Y%m%d-%H%M%S)"
                    echo ".....Resuming...at $(date +%Y%m%d-%H%M%S)" >> $LOGFILE

                fi

          done
        fi
#####
## END Pause
#####
        let COUNT=0

        COUNT=`db2pd -db $DB -reorgs | grep Started | wc | awk '{print $1}'`

        if [ $COUNT -ge $MAXREORGSTORUN ]; then

            sleep="0"
              until [ $sleep -eq "1" ]
                do

                  let SLEEP=15
                  echo "Snoozing for $SLEEP seconds...........Yawn...at "$(date +%Y%m%d-%H%M%S)
                  echo "Snoozing for $SLEEP seconds...........Yawn...at "$(date +%Y%m%d-%H%M%S) >> $LOGFILE
                  sleep $SLEEP

                  let COUNT=0
                  COUNT=`db2pd -db $DB -reorgs | grep Started | wc | awk '{print $1}'`

                  if [ $COUNT -lt $MAXREORGSTORUN ]; then
                      sleep="1"
                  fi

                #####
                ## Pause?
                ## if a file exists called '$PAUSEFLAG' then we will
                ## wait indefinitely for the file to go away...
                #####
                        if [ -f $PAUSEFLAG ]; then

                          FINISHED="0"

                          until [ $FINISHED -eq "1" ]
                          do

                            echo ".....Pausing for 60 seconds at $(date +%Y%m%d-%H%M%S)"
                            echo ".....Pausing for 60 seconds at $(date +%Y%m%d-%H%M%S)" >> $LOGFILE

                            sleep 60

                              if [ ! -f $PAUSEFLAG ]; then
                                  FINISHED="1"
                                  echo ".....Resuming...at $(date +%Y%m%d-%H%M%S)"
                                  echo ".....Resuming...at $(date +%Y%m%d-%H%M%S)" >> $LOGFILE

                              fi

                          done
                        fi
                done
        fi

    ###########################
    ## If INPLACE then release
    ## only if we should do so
    ## If NOT INPLACE then
    ## it doesn't matter and
    ## we'll release anyway
    ###########################

        if [ $COUNT -lt $MAXREORGSTORUN ]; then

            RELEASED=$(($RELEASED + 1))

            echo $RELEASED > $RELEASEFLAG

            echo      "*************************** " $RELEASED " of " $BUILT " ********************************"
            echo "\n" "*************************** " $RELEASED " of " $BUILT " ********************************" >> $LOGFILE

            echo      "Releasing a new Statement Right now...at "$(date +%Y%m%d-%H%M%S) " since $COUNT running"
            echo "\n" "Releasing a new Statement Right now...at "$(date +%Y%m%d-%H%M%S) " since $COUNT running" >> $LOGFILE

        fi

##
##  Build our reorg statement...remember INPLACE does logging...
##

######################
## Reorg using 4k work (REORGUSETS)
######################
        if [ $OPTION == "REORGUSETS" ]; then


            if [ -f $RUNLOG ]; then
                 rm $RUNLOG
            fi

            RUNSTATEMENT=`echo "db2 reorg table $REPLY use reorg4k "`

            $RUNSTATEMENT      >> $RUNLOG

            echo $RUNSTATEMENT
            echo $RUNSTATEMENT >> $LOGFILE

            cat $RUNLOG
            cat $RUNLOG   >> $LOGFILE

            ERRORCOUNT=`cat $RUNLOG | grep "DB20000I" | wc | awk '{print $1}'`

            if [ $ERRORCOUNT -eq 0 ]; then

               ERRORCOUNTTOTAL=$(($ERRORCOUNTTOTAL + 1))

               echo $RUNSTATEMENT    >> $RCERRORLOG
               cat  $RUNLOG     >> $RCERRORLOG
            fi

            let SLEEP=1
            sleep $SLEEP
        fi

######################
## Reorg (no TS)
######################
        if [ $OPTION == "REORG" ]; then

            if [ -f $RUNLOG ]; then
                 rm $RUNLOG
            fi

            RUNSTATEMENT=`echo "db2 reorg table $REPLY  "`
            $RUNSTATEMENT      >> $RUNLOG

            echo $RUNSTATEMENT
            echo $RUNSTATEMENT >> $LOGFILE

            cat $RUNLOG
            cat $RUNLOG   >> $LOGFILE

            ERRORCOUNT=`cat $RUNLOG | grep "DB20000I" | wc | awk '{print $1}'`

            if [ $ERRORCOUNT -eq 0 ]; then

               ERRORCOUNTTOTAL=$(($ERRORCOUNTTOTAL + 1))

               echo $RUNSTATEMENT    >> $RCERRORLOG
               cat  $RUNLOG     >> $RCERRORLOG
            fi

            let SLEEP=1
            sleep $SLEEP
        fi

######################
## Runstats
######################
        if [ $OPTION == "RUNSTATS" ]; then

            if [ -f $RUNLOG ]; then
                 rm $RUNLOG
            fi

            RUNSTATEMENT=`echo "db2 runstats on table $REPLY with distribution and detailed indexes all"`

            $RUNSTATEMENT      >> $RUNLOG

            echo $RUNSTATEMENT
            echo $RUNSTATEMENT >> $LOGFILE

            cat $RUNLOG
            cat $RUNLOG   >> $LOGFILE

            ######################
            ## Runstats Error Logic
            ######################

            ERRORCOUNT=`cat $RUNLOG | grep "DB20000I" | wc | awk '{print $1}'`

            if [ $ERRORCOUNT -eq 0 ]; then

               ERRORCOUNTTOTAL=$(($ERRORCOUNTTOTAL + 1))

               echo $RUNSTATEMENT    >> $RCERRORLOG
               cat  $RUNLOG          >> $RCERRORLOG

               ######################
               ## Runstats Retry Logic - first do indexes all then without indexes on the table
               ######################
               #
               # Just do Indexes
               #

               if [ -f $RUNLOG ]; then
                    rm $RUNLOG
               fi

               RUNSTATEMENT=`echo "db2 runstats on table $REPLY for indexes all "`

               $RUNSTATEMENT      >> $RUNLOG

               echo $RUNSTATEMENT
               echo $RUNSTATEMENT >> $LOGFILE

               cat $RUNLOG
               cat $RUNLOG        >> $LOGFILE

               echo $RUNSTATEMENT    >> $RCERRORLOG
               cat  $RUNLOG          >> $RCERRORLOG

               #
               # Just do Table
               #

               if [ -f $RUNLOG ]; then
                    rm $RUNLOG
               fi

               RUNSTATEMENT=`echo "db2 runstats on table $REPLY with distribution "`

               $RUNSTATEMENT      >> $RUNLOG

               echo $RUNSTATEMENT
               echo $RUNSTATEMENT >> $LOGFILE

               cat $RUNLOG
               cat $RUNLOG        >> $LOGFILE

               echo $RUNSTATEMENT    >> $RCERRORLOG
               cat  $RUNLOG          >> $RCERRORLOG

            fi

            let SLEEP=0
            sleep $SLEEP
        fi

######################
## INPLACE reorg
######################
        if [ $OPTION == "INPLACE" ]; then

            RUNSTATEMENT=`echo "db2 reorg table $REPLY inplace "`

            echo $RUNSTATEMENT
            echo $RUNSTATEMENT >> $LOGFILE

            $RUNSTATEMENT

            let SLEEP=1
            sleep $SLEEP

        fi
OPTION="RUNSTATS"
######################
## REORGHWM reorg
######################
        if [ $OPTION == "REORGHWM" ]; then

            if [ -f $RUNLOG ]; then
                 rm $RUNLOG
            fi

            RUNSTATEMENT=`echo "db2 reorg table $REPLY allow no access longlobdata "`

            $RUNSTATEMENT      >> $RUNLOG

            echo $RUNSTATEMENT
            echo $RUNSTATEMENT >> $LOGFILE

            cat $RUNLOG
            cat $RUNLOG   >> $LOGFILE

            ERRORCOUNT=`cat $RUNLOG | grep "DB20000I" | wc | awk '{print $1}'`

            if [ $ERRORCOUNT -eq 0 ]; then

               ERRORCOUNTTOTAL=$(($ERRORCOUNTTOTAL + 1))

               echo $RUNSTATEMENT    >> $RCERRORLOG
               cat  $RUNLOG     >> $RCERRORLOG
            fi

            let SLEEP=1
            sleep $SLEEP

        fi

######################
## Indexes reorg
######################
        if [ $OPTION == "REORGINDEXES" ]; then

            if [ -f $RUNLOG ]; then
                 rm $RUNLOG
            fi

            RUNSTATEMENT=`echo "db2 reorg indexes all for table $REPLY allow write access cleanup only pages "`

            $RUNSTATEMENT      >> $RUNLOG

            echo $RUNSTATEMENT
            echo $RUNSTATEMENT >> $LOGFILE

            cat $RUNLOG
            cat $RUNLOG   >> $LOGFILE

            ERRORCOUNT=`cat $RUNLOG | grep -E "DB20000I|SQL1146N" | wc | awk '{print $1}'`

            if [ $ERRORCOUNT -eq 0 ]; then

               ERRORCOUNTTOTAL=$(($ERRORCOUNTTOTAL + 1))

               echo $RUNSTATEMENT    >> $RCERRORLOG
               cat  $RUNLOG     >> $RCERRORLOG
            fi

            let SLEEP=1
            sleep $SLEEP
        fi

#####
## TOD Stop?
## If the user has input a time then we'll stop there
## else we'll keep on going
#####
        if [ $ENDTIME != "NOENDTIME" ]; then
          CURRTIME=`date +%H%M%S`
          echo       "*********** " $CURRTIME but will end at $ENDTIME " ***********"
          echo  "\n" "*********** " $CURRTIME but will end at $ENDTIME " ***********" >> $LOGFILE


            if [ $CURRTIME -gt $ENDTIME ]; then

              gatekeeper="1"
              echo ".....ENDING...at $(date +%Y%m%d-%H%M%S)"
              echo ".....ENDING...at $(date +%Y%m%d-%H%M%S)" >> $LOGFILE

              break

            fi
        fi

        echo       "Snoozing for $SLEEP seconds...........Yawn...at "$(date +%Y%m%d-%H%M%S)
        echo  "\n" "Snoozing for $SLEEP seconds...........Yawn...at "$(date +%Y%m%d-%H%M%S) >> $LOGFILE

        sleep $SLEEP

    done
gatekeeper="1"
done

##############################################
# Flush the package cache here if they wanted it
##############################################

if [ $FLUSH == "YES" ]; then
      db2 connect to $DB;
      db2 flush package cache dynamic;
      echo "The db2 flush package cache dynamic statement was issued"
      echo "The db2 flush package cache dynamic statement was issued" >> $LOGFILE
fi

##############################################
# We stored the number of released statements
# so now retrieve it and show it on the email
##############################################

RELEASEDCOUNT=`cat $RELEASEFLAG | awk '{print $1}'`

##############################################
# Send out the completion email
##############################################

echo    "Gatekeeper processed $RELEASEDCOUNT of $BUILT statements from $STARTTIME to $(date +%H%M%S)" >> $ERRFILE


if [ -f $STOPFLAG ]; then

      echo ".....Stop Signal Received"
      echo ".....Stop Signal Received"  >> $ERRFILE

fi

mail -s "ADVISORY on $SYSTEM (db2_gatekeeper.sh) is reporting $RELEASEDCOUNT statements processed of $BUILT from $STARTTIME to $(date +%H%M%S)"  $EMAILADDRESSES <$LOGFILE

##############################################
# If run-time errors then send this out too...
##############################################

if [ $ERRORCOUNTTOTAL -ne 0 ]; then
    mail -s "SEV 3 ALERT on $SYSTEM (db2_gatekeeper.sh) is reporting $ERRORCOUNTTOTAL error(s)"  $EMAILADDRESSES <$RCERRORLOG
fi

###if test "$TRIGGERFILE"
###then
###touch $TRIGGERFILE
###fi

cat $ERRFILE
##
## Clean up
##
rm $history_dir/db2_gatekeeper.output*
rm $history_dir/db2_gatekeeper.message*
rm $history_dir/db2_gatekeeper_runstatlog*
##############################################
# Exit the routine setting the RC as we go
##############################################

if [ -f $DELETEFLAG ]; then
     rm $DELETEFLAG
fi

if [ -f $RELEASEFLAG ]; then
     rm $RELEASEFLAG
fi

if [ $RC -ne 0 ]; then
  exit 8
else
  exit 0
fi
db2inst1@srvatldb04v:/db2home/db2inst1>
