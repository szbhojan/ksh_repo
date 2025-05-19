# REORG Database using resuts of REORGCHK stored procedure
#
#        Logs will be written to /$HOME/logs/hisotry/<dow>/reorg.out
#
#-------------------------------------------------------------------
#Change History:
# Date       Person        Change
# --------   ------------- -----------------------------------------
# MM/DD/YY   your.name     Change descriptions
# 05/10/11   Brian F.----- Initialized script
# 05/11/11   Brian F.----- Added commentary-------------------------
# 01/27/12   Brian F.      Added runstats to the just reorged tables and indexes
# 01/30/12   Brian F.      Added tables ATTRVALUE and ATTRIBUTE to exception list
# 02/02/12   Brian F.      Removed table ATTRIBUTE from exception list
# 07/16/12   Brian F.      Changed hisotrydir to use curdate and took $runtime out of output file
# --------   ------------- -----------------------------------------
#-------------------------------------------------------------------
#set -x
. $HOME/sqllib/db2profile
#DBLIST="EVD01"
DBNAME=EVQ01
#history_dir="/db_adm/scripts"
log_dir="$HOME/logs"
curdow=$(date +%w)
curdate=$(date +%d)
curdowA=$(date +%a)
runtime=$(date +%Y%m%d)
history_dir="$HOME/logs/history/${curdate}"

##Build a list of tables to be reorged based on output of reorgchk stored proc
#for DBNAME in $DBLIST; do
echo "CONNECT TO $DBNAME;" > $history_dir/reorgscript_"$DBNAME".sql
db2 "CONNECT TO $DBNAME"
db2 -x "CALL SYSPROC.REORGCHK_TB_STATS('T', 'ALL')" | grep "\*" | awk '{print "REORG TABLE " $1 "." $2 " INPLACE;"}' >> $history_dir/reorgscript_"$DBNAME".sql
echo "!sleep 300;" >> $history_dir/reorgscript_"$DBNAME".sql
db2 -x "call sysproc.reorgchk_ix_stats('T','ALL')" | grep "\*" | awk '{print "REORG INDEXES all for table " $1 "." $2 " allow write access;"}' >> $history_dir/reorgscript_"$DBNAME".sql
db2 -x "CALL SYSPROC.REORGCHK_TB_STATS('T', 'ALL')" | grep "\*" | awk '{print "runstats on table " $1 "." $2 " with distribution and detailed indexes all;"}' >> $history_dir/reorgscript_"$DBNAME".sql
db2 -x "call sysproc.reorgchk_ix_stats('T','ALL')" | grep "\*" | awk '{print "runstats on table " $1 "." $2 " with distribution and detailed indexes all;"}' >> $history_dir/reorgscript_"$DBNAME".sql
#done

##Remove any duplicate lines
uniq $history_dir/reorgscript_"$DBNAME".sql $history_dir/reorgscript_"$DBNAME".sql_temp
mv $history_dir/reorgscript_"$DBNAME".sql_temp $history_dir/reorgscript_"$DBNAME".sql

##Build exception list of tables marked volatile and remove them from the script
db2 -x "select tabname from syscat.tables where volatile='C' and tabschema='EVMIDB'" > $history_dir/EXCEPTIONLIST_"$DBNAME"

#### Adding tables ATTRVALUE and ATTRIBUTE to Exception list
#echo "ATTRVALUE" >> $history_dir/EXCEPTIONLIST
echo "SYSUSERAUTH" >> $history_dir/EXCEPTIONLIST_"$DBNAME"

cat $history_dir/EXCEPTIONLIST_"$DBNAME" | while read TABNAME
do
sed "/$TABNAME/d" $history_dir/reorgscript_"$DBNAME".sql > $history_dir/reorgscript_"$DBNAME".sql_temp
mv $history_dir/reorgscript_"$DBNAME".sql_temp $history_dir/reorgscript_"$DBNAME".sql
done
#rm $history_dir/EXCEPTIONLIST
echo "CONNECT RESET;" >> $history_dir/reorgscript_"$DBNAME".sql

## run the prepared reorg script.  Comment this out if it shouldn't run
db2 -tvf $history_dir/reorgscript_"$DBNAME".sql > $history_dir/reorg_"$DBNAME".out
#db2rbind $DBLIST -l $history_dir/rebind.out



db2 connect reset
