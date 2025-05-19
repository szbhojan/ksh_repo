#!/bin/bash
##export DBALIST="MSCDBA@mscdirect.com,mscdirect.dbasupport@ltimindtree.com"
export DBALIST="Saravanan.Bhojan@LtiMindtree.com, sgueglil@mscdirect.com"
export PGPASSWORD=$(gcloud secrets versions access latest --secret=msc-ecomm-dbausr-password --project ecomm-api-qa-mscdirect)
HOSTNAME=`hostname`
export WD="/u01/dba/dbausrqa-home/certificates"
PSQL="/usr/lib/postgresql/15/bin/psql"
PORT=5432
HOST="10.128.48.238"
DB="ecomm"
USER="dbausr"
DATE2=`date +'%d%m%G'`
out_log="/u01/dba/dbausrqa-home/scripts/output/FORCE_ALL_IDLE_$DATE2.log"
touch $out_log
cd $WD

IDLECONNTIME2=`$PSQL -d $DB -U $USER -t -p $PORT -h $HOST -c "select now() ;"`
##IDLECONNTIME2=`$PSQL -d $DB -U $USER -t -p $PORT -h $HOST sslcert=client-cert.pem sslkey=client-key.pem sslrootcert=server-ca.pem sslmode=require -c "select now() ;" `
##CONN2=`$PSQL -t -c "select count(*) from pg_stat_activity ;"  "port=$PORT host=$HOST user=$USER dbname=$DB sslcert=client-cert.pem sslkey=client-key.pem sslrootcert=server-ca.pem sslmode=require"`
MAXCONN2=`$PSQL -d $DB -U $USER -t -p $PORT -h $HOST -c "SHOW max_connections ;"`
SESSTOUT2=`$PSQL -d $DB -U $USER -t -p $PORT -h $HOST -c "SHOW idle_in_transaction_session_timeout ;"`
CONN2=`$PSQL -t -c "select count(*) from pg_stat_activity WHERE datname='ecomm' ;"  "port=$PORT host=$HOST user=$USER dbname=$DB"`

echo "-----------------------------------------------------------------------------------------------------------" | tee -a $out_log
echo "ALL IDLE Connetions Start Time (script Start Time Before Forcing session) : $IDLECONNTIME2" | tee -a  $out_log
echo "-----------------------------------------------------------------------------------------------------------" | tee -a $out_log

echo "Maximum Connections Defined : $MAXCONN2" | tee -a  $out_log

echo "Idle in Transaction Session Timeout Defined : $SESSTOUT2" | tee -a  $out_log

echo "QA ECOMM Current Connection Count    : $CONN2"  | tee -a  $out_log

IDLECONN2=`$PSQL -d $DB -U $USER -t -p $PORT -h $HOST -c "select count(*) from pg_stat_activity WHERE  pid <> pg_backend_pid()
AND state in ('idle', 'idle in transaction', 'idle in transaction (aborted)', 'disabled')
AND datname='ecomm'
AND state_change < current_timestamp - INTERVAL '5' MINUTE ;"`

echo "QA ECOMM DB Count of ALL IDLE connections more than 5 minutes : $IDLECONN2" |tee -a  $out_log

echo "-----------------------------------------------------------------------------------------------------------" | tee -a $out_log
echo "QA ECOMM DB Connections ALL IDLE list for more than 5 minutes :" >> $out_log
echo "-----------------------------------------------------------------------------------------------------------" | tee -a $out_log

$PSQL -d $DB -U $USER -t -p $PORT -h $HOST -c " select datname, pid,now() - query_start as "runtime",state,state_change,query from pg_stat_activity WHERE  pid <> pg_backend_pid()
AND state in ('idle', 'idle in transaction', 'idle in transaction (aborted)', 'disabled')
AND datname='ecomm'
AND state_change < current_timestamp - INTERVAL '5' MINUTE ;" >> $out_log

$PSQL -d $DB -U $USER -t -p $PORT -h $HOST -c " SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE  pid <> pg_backend_pid()
AND state in ('idle', 'idle in transaction', 'idle in transaction (aborted)', 'disabled')
AND datname='ecomm'
AND state_change < current_timestamp - INTERVAL '5' MINUTE;" >> $out_log

echo "-----------------------------------------------------------------------------------------------------------" | tee -a $out_log
echo "ALL IDLE Connetions End Time (script End Time After Forcing session) : $IDLECONNTIME2" | tee -a  $out_log
echo "-----------------------------------------------------------------------------------------------------------" | tee -a $out_log

/bin/mailx -r postgresqa@mscdirect.com -s "ECOMM QA POSTGRESQL SERVER - Forcing connections which are Idle for more than 5 Minutes" $DBALIST < $out_log
exit 0 ;
