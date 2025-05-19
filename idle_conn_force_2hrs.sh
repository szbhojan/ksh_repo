#!/bin/sh
DBALIST="MSCDBA@mscdirect.com,Marc.DiFilippo@mscdirect.com,Michael.Arnold@mscdirect.com,SguegliL@mscdirect.com,roya@mscdirect.com,mscdirect.dbasupport@mindtree.com";export DBALIST
#DBALIST="Arpit.Phasalkar@mscdirect.com";export DBALIST
export PGPASSWORD=$(gcloud secrets versions access latest --secret=msc-ecomm-dbausr-password --project ecomm-api-prd-mscdirect)
echo $date

cd /u01/dba/dbausrprd-home


                count=0;
                count=`psql -t -c "select count(pid) from pg_stat_activity where datname='ecomm' and extract(epoch from now() - state_change) / 60 > 120 " "port=5432 host=10.126.7.3 user=dbausr dbname=ecomm sslcert=client-cert.pem sslkey=client-key.pem sslrootcert=server-ca.pem sslmode=require"`

                if [ $count -gt 0 ]
                then

                        #display connections which are idle for more than 2 hours
                        echo "Below are the connections which are idle for more than 2 hours:" > /u01/dba/dbausrprd-home/scripts/output/idle_conn_force_2hrs.out
                        psql -c "select pid as process_id,usename as username,client_addr as client_IP_address,application_name,backend_start,state,state_change as STATUS_CHANGE_TIME, round (extract(epoch from now() - state_change) / 60) as idle_time_in_mins from pg_stat_activity where datname='ecomm' and extract(epoch from now() - state_change) / 60 > 120 " >> /u01/dba/dbausrprd-home/scripts/output/idle_conn_force_2hrs.out "port=5432 host=10.126.7.3 user=dbausr dbname=ecomm sslcert=client-cert.pem sslkey=client-key.pem sslrootcert=server-ca.pem sslmode=require";

                        echo "---------------------------------------------------------------------------------------------------------------------------------" >> /u01/dba/dbausrprd-home/scripts/output/idle_conn_force_2hrs.out
                        echo "***Forcing connections which are idle for more than 2 hours in Postgres PROD environment***" >> /u01/dba/dbausrprd-home/scripts/output/idle_conn_force_2hrs.out
                        echo "---------------------------------------------------------------------------------------------------------------------------------" >> /u01/dba/dbausrprd-home/scripts/output/idle_conn_force_2hrs.out

                        psql -c "SELECT pg_cancel_backend(pid), pg_terminate_backend(pid) from pg_stat_activity where datname='ecomm' and extract(epoch from now() - state_change) / 60 > 120" "port=5432 host=10.126.7.3 user=dbausr dbname=ecomm sslcert=client-cert.pem sslkey=client-key.pem sslrootcert=server-ca.pem sslmode=require";


                        echo "After forcing connections, below are the connections which are idle for more than 2 hours:" >> /u01/dba/dbausrprd-home/scripts/output/idle_conn_force_2hrs.out
                        psql -c "select pid as process_id,usename as username,client_addr as client_IP_address,application_name,backend_start,state,state_change as STATUS_CHANGE_TIME, round (extract(epoch from now() - state_change) / 60) as idle_time_in_mins from pg_stat_activity where datname='ecomm' and extract(epoch from now() - state_change) / 60 > 120 " >> /u01/dba/dbausrprd-home/scripts/output/idle_conn_force_2hrs.out "port=5432 host=10.126.7.3 user=dbausr dbname=ecomm sslcert=client-cert.pem sslkey=client-key.pem sslrootcert=server-ca.pem sslmode=require";


                        /bin/mailx -r postgresprod@mscdirect.com -s "ECOMM PROD POSTGRESQL SERVER - Forcing connections which are Idle for more than 2 hours" $DBALIST < /u01/dba/dbausrprd-home/scripts/output/idle_conn_force_2hrs.out

                else

                        echo "There are no connections which are idle for more than 2 hours"

                fi
##----------------------------------------------------------------------------------------------------------------------------------


--IDLE Connection Report:
---------------------------
ecomm=> \x
Expanded display is on.
ecomm=> select * from pg_stat_activity where datname='ecomm' and extract(epoch from now() - state_change) / 60 > 5 ;
-[ RECORD 1 ]----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
datid            | 16467
datname          | ecomm
pid              | 2261953
usesysid         | 17163
usename          | atish.roy@mscdirect.com
application_name | PostgreSQL JDBC Driver
client_addr      |
client_hostname  |
client_port      | -1
backend_start    | 2024-09-11 04:42:30.760189+00
xact_start       |
query_start      | 2024-09-11 04:44:39.685434+00
state_change     | 2024-09-11 04:44:39.690345+00
wait_event_type  | Client
wait_event       | ClientRead
state            | idle
backend_xid      |
backend_xmin     |
query            | select count(*) from ecomm.contact where lower(user_name) in ('ordertracking','anchezvelosoc@coned.com','allin@coned.com','arrangeon@coned.com','bicknell@oru.com','crilld@coned.com','accettullic@coned.com','lanzami@con
ed.com','evanstr@coned.com','rammj@coned.com','perezmar@coned.com','pirrelloj@coned.com','filogamob@coned.com','codoganv@coned.com','weissr@coned.com','salima@coned.com','forsbergm','austinc@coned.com','turianog@coned.com','mavrovicd','p
ineirob@coned.com','eric.ellis@coned.com','bennettru@coned.com','busaccajo@coned.com','harricharanr@coned.com','ippolitos@coned.com','montalvoo@coned.com','dodaros@coned.com','henryda@coned.com','henriquezra@coned.com','lagarrat@coned.co
m','braked@coned.com','wrightc@coned.com','ianninov@oru.com','aguirrem@coned.com','prescodb@coned.com','ciullar@coned.com','fereancest@coned.com','cayod@coned.com','correntemi@coned.com','dimaggios@coned.com','vidar@coned.com','ariasje@c
oned.com','mcclymontt@coned.com','gonzalezm@coned.com','barthp@oru.com','cullellj@coned.com','
backend_type     | client backend


ecomm=> \x
Expanded display is off.
ecomm=> select pid as process_id,usename as username,client_addr as client_IP_address,application_name,backend_start,state,state_change as STATUS_CHANGE_TIME, round (extract(epoch from now() - state_change) / 60) as idle_time_in_mins fro
m pg_stat_activity where datname='ecomm' and extract(epoch from now() - state_change) / 60 > 5 order by client_addr ;
 process_id |        username         | client_ip_address |    application_name    |         backend_start         | state |      status_change_time       | idle_time_in_mins
------------+-------------------------+-------------------+------------------------+-------------------------------+-------+-------------------------------+-------------------
    2261953 | atish.roy@mscdirect.com |                   | PostgreSQL JDBC Driver | 2024-09-11 04:42:30.760189+00 | idle  | 2024-09-11 04:44:39.690345+00 |               103
(1 row)

--IDLE Connections more than 10 Mins:
-----------------------------------------

ecomm=> select count(pid) from pg_stat_activity where datname='ecomm' and extract(epoch from now() - state_change) / 60 > 10 ;
 count
-------
     1
(1 row)

--IDLE Connections more than 5 Mins:
-----------------------------------------
ecomm=>
ecomm=> select count(pid) from pg_stat_activity where datname='ecomm' and extract(epoch from now() - state_change) / 60 > 5 ;
 count
-------
     1
(1 row)

--IDLE Connections more than 2 Hrs:
-----------------------------------------
ecomm=> select pid as process_id,usename as username,client_addr as client_IP_address,application_name,backend_start,state,state_change as STATUS_CHANGE_TIME, round (extract(epoch from now() - state_change) / 60) as idle_time_in_mins fro
m pg_stat_activity where datname='ecomm' and extract(epoch from now() - state_change) / 60 > 120 ;
(0 rows)

-- To Force or Terminate the IDLE Connections:
-----------------------------------------------

ecomm=> SELECT pg_cancel_backend(pid), pg_terminate_backend(pid) from pg_stat_activity where datname='ecomm' and extract(epoch from now() - state_change) / 60 > 120


-- VACUUM table query

SELECT relname FROM pg_stat_all_tables WHERE schemaname = 'public' AND ((last_analyze is NULL AND last_autoanalyze is NULL) OR ((last_analyze < last_autoanalyze OR last_analyze is null) AND last_autoanalyze < now() - interval %s) OR ((last_autoanalyze < last_analyze OR last_autoanalyze is null) AND last_analyze < now() - interval %s));", [days + ' day', days + ' day']


SELECT
        relname AS TableName
FROM
        pg_stat_user_tables
where
        n_dead_tup > 10
and     schemaname ='ecomm'



SELECT
        relname AS TableName
FROM
        pg_stat_user_tables
where
        schemaname='ecomm'
