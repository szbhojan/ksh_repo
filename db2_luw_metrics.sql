--db2inst1@srvhqdb04v:/db2home/db2inst1>cat /db_adm/scripts/mindtree/healthcheck/metrics.sql
-- metrics.sql


ECHO ==-- VALUES CURRENT TIMESTAMP --== Start;
VALUES CURRENT TIMESTAMP;

-- Transactions per second (TPS)
-- Database level
ECHO ==-- TRANSACTIONS PER SECOND - TPS --== Database level;
SELECT char(db_name,30) as db_name,
        COALESCE(
                DECIMAL (commit_sql_stmts + rollback_sql_stmts) /
                NULLIF(
                TIMESTAMPDIFF(4, CHAR(snapshot_timestamp - COALESCE(last_reset, db_conn_time ) )) * 60
                ,0)
        ,0)
        AS trans_per_second
        ,DECIMAL (commit_sql_stmts + rollback_sql_stmts) AS TOTAL_TRANSACTION
        ,(TIMESTAMPDIFF(4, CHAR(snapshot_timestamp - COALESCE(last_reset, db_conn_time ) )) * 60) as collection_interval_sec
        ,COALESCE(last_reset, db_conn_time ) as interval_start_time
        FROM SYSIBMADM.SNAPDB AS dbsnap with ur;

---
ECHO ==-- DATABASE SIZE--==;
select (CAST(db_size as decimal(28,3))/CAST(1073741824 as decimal(28,3))) as total_space_in_GB FROM systools.stmg_dbsize_info;

ECHO ==-- DATABASE CAPACITY--== ;
select (CAST(DB_CAPACITY as decimal(28,3))/CAST(1073741824 as decimal(28,3))) as total_space_in_GB FROM systools.stmg_dbsize_info;

ECHO ==-- DEADLOCKS, LOCKTIMEOUTS, LOCKWAIT --== ;
select event_type,count(distinct event_id) as event_count from TAB_LOCKING where event_timestamp>=current_timestamp - 144 hours group by event_type;

ECHO ==-- LOG READ and LOG WRITE --==;
select log_reads, log_writes from sysibmadm.snapdb with ur;

ECHO ==-- hit ratio tablespace level --== ;
SELECT char(current_server,10) as db_name,char(TBSP_NAME,15) as TBSP_NAME, (100 - COALESCE( DECIMAL(DECIMAL(100) * pool_index_p_reads / NULLIF(pool_index_l_reads,0),5,2),0)) as index_hit_ratio,(100 - COALESCE( DECIMAL(DECIMAL(100) * pool_data_p_reads / NULLIF(pool_data_l_reads,0),5,2) ,0)) as data_hit_ratio,(100 - COALESCE(DECIMAL(DECIMAL(100) *(pool_index_p_reads + pool_data_p_reads)/NULLIF((pool_index_l_reads + pool_data_l_reads),0),5,2),0)) as overall_hit_ratio FROM SYSIBMADM.SNAPTBSP AS tbssnap with ur;


ECHO ==-- hit ratio buffer pool level --== ;
select substr(DB_NAME,1,10) as DBNAME,substr(BP_NAME,1,20) as BP_NAME, TOTAL_HIT_RATIO_PERCENT,DATA_HIT_RATIO_PERCENT,INDEX_HIT_RATIO_PERCENT from SYSIBMADM.BP_HITRATIO;

ECHO ==-- hit ratio database level --== ;
SELECT char(db_name,10) as db_name,(100 - COALESCE( DECIMAL(DECIMAL(100) * pool_index_p_reads / NULLIF(pool_index_l_reads,0),5,2),0)) as index_hit_ratio,(100 - COALESCE( DECIMAL(DECIMAL(100) * pool_data_p_reads / NULLIF(pool_data_l_reads,0),5,2) ,0)) as data_hit_ratio,(100 - COALESCE(DECIMAL(DECIMAL(100) *(pool_index_p_reads + pool_data_p_reads)/NULLIF((pool_index_l_reads + pool_data_l_reads),0),5,2),0)) as overall_hit_ratio FROM SYSIBMADM.SNAPDB  AS tbssnap with ur;

ECHO ==-- collect the info for table space --== ;
select substr(tbsp_name,1,30) as Tablespace_Name, tbsp_type as Type, substr(tbsp_state,1,20) as Status, (tbsp_total_size_kb / 1024 ) as Size_Meg, decimal((float(tbsp_total_size_kb - tbsp_free_size_kb)/ float(tbsp_total_size_kb))*100,3,1)as Percent_used_Space, int((tbsp_free_size_kb) / 1024 )as Meg_Free_Space from sysibmadm.tbsp_utilization where tbsp_type='DMS';

ECHO ==- NUMBER OF EXECUTION --== ;
select  num_executions ,stmt_text from sysibmadm.snapdyn_sql order by num_executions desc fetch first 20 rows only with ur;

-- DATABASE CONNECTION POOL INFO
ECHO ==-- DATABASE CONNECTION POOL INFO --==;
select char(DB_NAME,20) as DB_NAME
,CONNECTIONS_TOP
,APPLS_CUR_CONS
,TOTAL_CONS
,TOTAL_SEC_CONS
,SNAPSHOT_TIMESTAMP
FROM SYSIBMADM.SNAPDB as dbsnap with ur
;

-- DBM CONNECTION INFO
--ECHO ==-- DBM CONNECTION INFO --==;
--select REM_CONS_IN
--,REM_CONS_IN_EXEC
--,LOCAL_CONS
--,LOCAL_CONS_IN_EXEC
--,CON_LOCAL_DBASES
--,SNAPSHOT_TIMESTAMP
--FROM SYSIBMADM.SNAPDBM as dbmsnap with ur
--;

----
-- CONNECTED APPLICATION DETAILS
ECHO ==--  IDLE APPLICATION DETAILS --==;
SELECT AGENT_ID, SUBSTR(APPL_NAME,1,10) AS APPL_NAME, SUBSTR(AUTHID,1,10) as AUTHID, APPL_STATUS,STATUS_CHANGE_TIME
 FROM SYSIBMADM.APPLICATIONS ORDER BY STATUS_CHANGE_TIME Fetch first 20 rows only with ur;


ECHO ==-- CURRENTLY LONG RUNNING SQL (More than 2 min)--;
SELECT ELAPSED_TIME_MIN,
SUBSTR(AUTHID,1,10) AS AUTH_ID,
AGENT_ID,
APPL_STATUS,
STMT_TEXT
--SUBSTR(STMT_TEXT,1,20) AS SQL_TEXT
FROM SYSIBMADM.LONG_RUNNING_SQL
WHERE ELAPSED_TIME_MIN > 3
ORDER BY ELAPSED_TIME_MIN DESC with ur;

ECHO ==-- TOP 20 Dynamic SQL based on AVG_EXEC TIME;

--SELECT SECTION_TYPE, NUM_EXECUTIONS, TOTAL_CPU_TIME, STMT_EXEC_TIME, STMT_TEXT,
--STMT_EXEC_TIME/NUM_EXECUTIONS AS TOTAL_EXEC_TIME FROM TABLE(MON_GET_PKG_CACHE_STMT ( NULL, NULL, NULL, -2)) as T WHERE TOTAL_EXEC_TIME > 180000 ORDER BY TOTAL_EXEC_TIME DESC with ur;
SELECT NUM_EXECUTIONS, AVERAGE_EXECUTION_TIME_S,STMT_TEXT
 FROM SYSIBMADM.TOP_DYNAMIC_SQL
 ORDER BY AVERAGE_EXECUTION_TIME_S DESC
 FETCH FIRST 20 ROWS ONLY with ur;


ECHO ==-- DATABASE LOG SPACE;
SELECT  SUBSTR(DB_NAME,1,10) DB_NAME,
                LOG_UTILIZATION_PERCENT,
                TOTAL_LOG_AVAILABLE_KB,
                TOTAL_LOG_USED_KB,
                TOTAL_LOG_USED_TOP_KB
        FROM SYSIBMADM.LOG_UTILIZATION with ur;

--ECHO ==-- MOST FREQUENTLY RUN DYNAMIC SQL --==;

--SELECT NUM_EXECUTIONS, AVERAGE_EXECUTION_TIME_S, STMT_SORTS,
--   SORTS_PER_EXECUTION, SUBSTR(STMT_TEXT,1,60) AS STMT_TEXT
--   FROM SYSIBMADM.TOP_DYNAMIC_SQL
--   ORDER BY NUM_EXECUTIONS DESC FETCH FIRST 10 ROWS ONLY WITH UR;



ECHO ==-- MOST FREQUENTLY RUN DYNAMIC/STATIC SQL --==;

SELECT SECTION_TYPE , TOTAL_CPU_TIME/NUM_EXEC_WITH_METRICS as AVG_CPU_TIME,
      NUM_EXECUTIONS,
      STMT_TEXT
      FROM TABLE(MON_GET_PKG_CACHE_STMT ( NULL, NULL, NULL, -1)) as T
        ORDER BY NUM_EXECUTIONS DESC FETCH FIRST 10 rows ONLY;

ECHO ##--HIGH CPU IN Microseconds;

SELECT SECTION_TYPE ,
      NUM_EXECUTIONS,
--     SUBSTR(STMT_TEXT,1,50) AS STMT_TEXT,
      TOTAL_CPU_TIME,
      TOTAL_CPU_TIME/NUM_EXEC_WITH_METRICS as
      AVG_CPU_TIME,STMT_TEXT
      FROM TABLE(MON_GET_PKG_CACHE_STMT ( NULL, NULL, NULL, -1)) as T
        ORDER BY TOTAL_CPU_TIME DESC FETCH FIRST 10 rows ONLY;

ECHO ##--HIGH QUERY COST;

SELECT SECTION_TYPE ,
      NUM_EXECUTIONS,
      TOTAL_CPU_TIME,
      QUERY_COST_ESTIMATE,
      TOTAL_CPU_TIME/NUM_EXEC_WITH_METRICS as
      AVG_CPU_TIME,STMT_TEXT
      FROM TABLE(MON_GET_PKG_CACHE_STMT ( NULL, NULL, NULL, -1)) as T
        ORDER BY QUERY_COST_ESTIMATE DESC FETCH FIRST 10 rows ONLY;

ECHO ##--DIRECT READS FROM DB;

SELECT SECTION_TYPE,
      NUM_EXECUTIONS,
      DIRECT_READS,
      DIRECT_READ_REQS,
      DIRECT_WRITES,
      DIRECT_WRITE_REQS,
      STMT_TEXT
            FROM TABLE(MON_GET_PKG_CACHE_STMT ( NULL, NULL, NULL, -1)) as T
        ORDER BY DIRECT_READS DESC FETCH FIRST 10 rows ONLY;

ECHO ##--ROWS READ/ ROWS RETURNED;

WITH SUM_TAB (SUM_RR, SUM_CPU, SUM_EXEC, SUM_SORT, SUM_NUM_EXEC) AS (
        SELECT  FLOAT(SUM(ROWS_READ)),
                FLOAT(SUM(TOTAL_CPU_TIME)),
                FLOAT(SUM(STMT_EXEC_TIME)),
                FLOAT(SUM(TOTAL_SECTION_SORT_TIME)),
                FLOAT(SUM(NUM_EXECUTIONS))
            FROM TABLE(MON_GET_PKG_CACHE_STMT ( 'D', NULL, NULL, -2)) AS T
        )
      SELECT SECTION_TYPE,
      ROWS_READ,
      ROWS_RETURNED,
          NUM_EXECUTIONS,
          DECIMAL(100*(FLOAT(ROWS_READ)/SUM_TAB.SUM_RR),5,2) AS PCT_TOT_RR,
      STMT_TEXT
      FROM TABLE(MON_GET_PKG_CACHE_STMT ( NULL, NULL, NULL, -1)) as T,SUM_TAB
        ORDER BY PCT_TOT_RR DESC FETCH FIRST 10 rows ONLY with ur;

ECHO ==-- APPLICATION HOLDING OLDEST LOG;

SELECT AI.APPL_STATUS as Status,AI.AGENT_ID as Agent_id, SUBSTR(AI.PRIMARY_AUTH_ID,1,10) AS "Authid",
SUBSTR(AI.APPL_NAME,1,15) AS
"Appl_Name", AP.UOW_LOG_SPACE_USED AS "Log_Used_MB",
INT(AP.APPL_IDLE_TIME/60) AS "Idle_for_min", AP.APPL_CON_TIME AS "Connected_Since"
FROM SYSIBMADM.SNAPDB DB, SYSIBMADM.SNAPAPPL  AP,SYSIBMADM.SNAPAPPL_INFO AI
WHERE   AI.AGENT_ID = DB.APPL_ID_OLDEST_XACT AND   AI.AGENT_ID = AP.AGENT_ID with ur;


ECHO ==-- OVERALL BP HIT RATIOS;
select substr(DB_NAME,1,10) as DBNAME,substr(BP_NAME,1,20) as BP_NAME, TOTAL_PHYSICAL_READS,
TOTAL_HIT_RATIO_PERCENT,DATA_PHYSICAL_READS,DATA_HIT_RATIO_PERCENT,INDEX_HIT_RATIO_PERCENT
from SYSIBMADM.BP_HITRATIO where BP_NAME = 'IBMDEFAULTBP' with ur;

ECHO == BUFFERPOOL SNAPSHOTS;
SELECT substr(BP_NAME,1,15) as BP_NAME, DIRECT_READS, DIRECT_WRITES, POOL_DATA_P_READS, POOL_DATA_WRITES,POOL_INDEX_P_READS, POOL_INDEX_WRITES, POOL_DRTY_PG_THRSH_CLNS,
POOL_ASYNC_DATA_READS, POOL_ASYNC_DATA_WRITES, POOL_ASYNC_INDEX_READS, POOL_ASYNC_INDEX_WRITES , POOL_WRITE_TIME, DIRECT_WRITE_TIME,
POOL_INDEX_P_READS, POOL_LSN_GAP_CLNS, POOL_DRTY_PG_STEAL_CLNS, POOL_DRTY_PG_THRSH_CLNS
FROM
 TABLE(MON_GET_BUFFERPOOL('IBMDEFAULTBP',-2)) with ur;

echo --TABLE SCANS / MOST ACTIVE TABLES ;

SELECT
SUBSTR(TABSCHEMA,1,10) AS SCHEMA,
SUBSTR(TABNAME,1,20) AS NAME,
TABLE_SCANS,
ROWS_READ,
ROWS_INSERTED,
ROWS_DELETED
FROM TABLE(
MON_GET_TABLE
('','',-1))
ORDER BY TABLE_SCANS DESC
FETCH FIRST 10 ROWS ONLY WITH UR;



echo ================= ORDER BY SORT_OVERFLOWS FROM PKG_CACHE=================;

WITH SUM_TAB (SUM_RR, SUM_CPU, SUM_EXEC, SUM_SORT, SUM_NUM_EXEC) AS (
        SELECT  FLOAT(SUM(ROWS_READ)),
                FLOAT(SUM(TOTAL_CPU_TIME)),
                FLOAT(SUM(STMT_EXEC_TIME)),
                FLOAT(SUM(TOTAL_SECTION_SORT_TIME)),
                FLOAT(SUM(NUM_EXECUTIONS))
            FROM TABLE(MON_GET_PKG_CACHE_STMT ( 'D', NULL, NULL, -2)) AS T
        )
                SELECT NUM_EXECUTIONS,
       TOTAL_SORTS,
       POST_THRESHOLD_SORTS,
       SORT_OVERFLOWS,
           DECIMAL(100*(FLOAT(SORT_OVERFLOWS)/SUM_TAB.SUM_SORT),5,2) AS PCT_TOT_SORT,
       STMT_TEXT
       FROM TABLE(MON_GET_PKG_CACHE_STMT ( NULL, NULL, NULL, -1)) as T,SUM_TAB
        ORDER BY SORT_OVERFLOWS DESC FETCH FIRST 10 rows ONLY WITH UR;

echo ==--LOCK WAITS;

SELECT CURRENT TIMESTAMP,SUBSTR(TABNAME,1,30)TABLE,LOCK_WAIT_ELAPSED_TIME,
REQ_AGENT_TID,SUBSTR(REQ_APPLICATION_NAME,1,40)REQ_APPLICATION_NAME,HLD_APPLICATION_HANDLE,SUBSTR(HLD_APPLICATION_NAME,1,40)HLD_APPLICATION_NAME,SUBSTR(REQ_STMT_TEXT,1,200),SUBSTR(HLD_CURRENT_STMT_TEXT,1,200)
FROM SYSIBMADM.MON_LOCKWAITS WHERE LOCK_WAIT_ELAPSED_TIME > 180 with ur;
--SELECT AGENT_ID, LOCK_MODE, LOCK_OBJECT_TYPE, AGENT_ID_HOLDING_LK,
--LOCK_MODE_REQUESTED FROM TABLE(SNAP_GET_LOCKWAIT('',-1)) AS T WITH UR;

-- DMS TABLESPACE FREE AND USED SPACE
-- Remaining DMS space for DB2 UDB V8
-- Tablespace level
ECHO ==-- DMS TABLESPACE FREE AND USED SPACE --==;
SELECT char(current_server,20) as db_name,SMALLINT(TP.TBSP_ID) as id
,CHAR(TP.TBSP_NAME,20) as tbsp_name
,DECIMAL(ROUND(TP.TBSP_USABLE_PAGES*TS.TBSP_PAGE_SIZE/DECIMAL(1048576),2),9,2) AS totalmb
,DECIMAL(ROUND(TP.TBSP_FREE_PAGES *TS.TBSP_PAGE_SIZE/DECIMAL(1048576),2),9,2) AS freemb
,DECIMAL(100 * ROUND(DECIMAL(TP.TBSP_FREE_PAGES)/NULLIF(TP.TBSP_USABLE_PAGES,0),4),5,2) AS pctfree
,DECIMAL(100 * ROUND(DECIMAL(TP.TBSP_USED_PAGES)/NULLIF(TP.TBSP_USABLE_PAGES,0),4),5,2) AS pctused
,DECIMAL(ROUND((TP.TBSP_PAGE_TOP - TP.TBSP_USED_PAGES) * TS.TBSP_PAGE_SIZE/DECIMAL(1048576),2),9,2) AS mb_under_hwm
FROM SYSIBMADM.SNAPTBSP_PART TP
inner join SYSIBMADM.SNAPTBSP TS
ON TP.TBSP_ID = TS.TBSP_ID
WHERE TS.TBSP_TYPE = 'DMS'
order by pctused desc with ur
;

-- Index Hit Ratio (IHR)
-- Database level
ECHO ==-- INDEX HIT RATIO - IHR --== Database level;
SELECT char(dbsnap.db_name,20) as db_name, 100 -
        COALESCE(                DECIMAL(DECIMAL(100) *
                                                                pool_index_p_reads /
                                                                NULLIF(pool_index_l_reads,0)
                                                                ,5,2),0) AS index_hit_ratio
                 ,pool_index_p_reads as pool_index_p_reads
                 ,pool_index_l_reads as pool_index_l_reads
                 ,(pool_index_p_reads + pool_index_l_reads) as total_pool_index_reads
FROM SYSIBMADM.SNAPDB AS dbsnap with ur
;

-- Index Hit Ratio (IHR)
-- Tablespace level
ECHO ==-- INDEX HIT RATIO - IHR --== Tablespace level;
SELECT char(current_server,20) as db_name,char(TBSP_NAME,30) as TBSP_NAME, 100 -
COALESCE(                DECIMAL(DECIMAL(100) *
                                                                pool_index_p_reads /
                                                                NULLIF(pool_index_l_reads,0)
                                                                ,5,2)

                                                                ,0)
                 AS index_hit_ratio
                 ,pool_index_p_reads as pool_index_p_reads
                 ,pool_index_l_reads as pool_index_l_reads
                 ,(pool_index_p_reads + pool_index_l_reads) as total_pool_index_reads
FROM SYSIBMADM.SNAPTBSP AS tbssnap with ur
;

-- DATA HIT RATIO - DHR : The percentage of data page reads that were
-- satisfied by the buffer pool (RAM cache) without requiring a physical read
--
-- Note that an exceptionally high buffer pool hit ratio, especially in OLTP
-- environments, may be an indicator of queries that scan excessively.

-- data Hit Ratio (DHR)
-- Database level
ECHO ==-- DATA HIT RATIO - DHR --== Database level;
SELECT char(dbsnap.db_name,20) as db_name, 100 -
        COALESCE(                DECIMAL(DECIMAL(100) *
                                                                pool_data_p_reads /
                                                                NULLIF(pool_data_l_reads,0)
                                                                ,5,2)

                                                                ,0)
                 AS data_hit_ratio
                 ,pool_data_p_reads as pool_data_p_reads
                 ,pool_data_l_reads as pool_data_l_reads
                 ,(pool_data_p_reads + pool_data_l_reads) as total_pool_data_reads
FROM SYSIBMADM.SNAPDB AS dbsnap with ur
;

-- data Hit Ratio (DHR)
-- Bufferpool level
ECHO ==-- DATA HIT RATIO - DHR --== Bufferpool level;
SELECT char(db_name,20) as db_name,char(bp_name,30) as bp_name, 100 -
        COALESCE(                DECIMAL(DECIMAL(100) *
                                                                pool_data_p_reads /
                                                                NULLIF(pool_data_l_reads,0)
                                                                ,5,2)

                                                                ,0)
                 AS data_hit_ratio
                 ,pool_data_p_reads as pool_data_p_reads
                 ,pool_data_l_reads as pool_data_l_reads
                 ,(pool_data_p_reads + pool_data_l_reads) as total_pool_data_reads
FROM SYSIBMADM.SNAPBP AS bpsnap with ur
;

-- data Hit Ratio (DHR)
-- Tablespace level
ECHO ==-- DATA HIT RATIO - DHR --== Tablespace level;
SELECT char(current_server,20) as db_name,char(tbsp_name,30) as tbsp_name, 100 -
COALESCE(                DECIMAL(DECIMAL(100) *
                                                                pool_data_p_reads /
                                                                NULLIF(pool_data_l_reads,0)
                                                                ,5,2)

                                                                ,0)
                 AS data_hit_ratio
                 ,pool_data_p_reads as pool_data_p_reads
                 ,pool_data_l_reads as pool_data_l_reads
                 ,(pool_data_p_reads + pool_data_l_reads) as total_pool_data_reads
FROM SYSIBMADM.SNAPTBSP AS tbssnap with ur
;

-- Overall Hit Ratio (OHR)
-- Database level
ECHO ==-- OVERALL HIT RATIO - OHR --== Database level;
SELECT char(db_name,20) as db_name, 100 -
        COALESCE(                DECIMAL(DECIMAL(100) *
                                                                (pool_index_p_reads + pool_data_p_reads)  /
                                                                NULLIF((pool_index_l_reads + pool_data_l_reads),0)
                                                                ,5,2)

                                                                ,0)
                 AS overall_hit_ratio
                 ,(pool_index_p_reads + pool_data_p_reads) as pool_p_reads
                 ,(pool_index_l_reads + pool_data_l_reads) as pool_l_reads
                 ,((pool_index_p_reads + pool_data_p_reads) + (pool_index_l_reads + pool_data_l_reads)) as total_pool_reads
FROM SYSIBMADM.SNAPDB AS dbsnap with ur
;

-- Overall Hit Ratio (OHR)
-- Bufferpool level
ECHO ==-- OVERALL HIT RATIO - OHR --== Bufferpool level;
SELECT char(db_name,20) as db_name,char(bp_name,30) as bp_name, 100 -
        COALESCE(                DECIMAL(DECIMAL(100) *
                                                                (pool_index_p_reads + pool_data_p_reads)  /
                                                                NULLIF((pool_index_l_reads + pool_data_l_reads),0)
                                                                ,5,2)

                                                                ,0)
                         AS overall_hit_ratio
                 ,(pool_index_p_reads + pool_data_p_reads) as pool_p_reads
                 ,(pool_index_l_reads + pool_data_l_reads) as pool_l_reads
                 ,((pool_index_p_reads + pool_data_p_reads) + (pool_index_l_reads + pool_data_l_reads)) as total_pool_reads
FROM SYSIBMADM.SNAPBP AS bpsnap with ur
;

-- Overall Hit Ratio (OHR)
-- Tablespace level
ECHO ==-- OVERALL HIT RATIO - OHR --== Tablespace level;
SELECT char(current_server,20) as db_name,char(tbsp_name,30) as tbsp_name, 100 -
        COALESCE(                DECIMAL(DECIMAL(100) *
                                                                (pool_index_p_reads + pool_data_p_reads)  /
                                                                NULLIF((pool_index_l_reads + pool_data_l_reads),0)
                                                                ,5,2)

                                                                ,0)
                 AS overall_hit_ratio
                 ,(pool_index_p_reads + pool_data_p_reads) as pool_p_reads
                 ,(pool_index_l_reads + pool_data_l_reads) as pool_l_reads
                 ,((pool_index_p_reads + pool_data_p_reads) + (pool_index_l_reads + pool_data_l_reads)) as total_pool_reads
FROM SYSIBMADM.SNAPTBSP AS tbssnap with ur
;

-- PREFETCH RATIO
----
ECHO ==-- PREFETCH RATIO;

select substr(BP_NAME,1,20) as BP_NAME,PREFETCH_RATIO_PERCENT,SYNC_WRITES_PERCENT
from SYSIBMADM.MON_BP_UTILIZATION with ur;


ECHO ==-- PHYSICAL READS PER MINUTE - PRPM --== Database level;
SELECT char(db_name,20) as db_name,
        COALESCE(
                DECIMAL (pool_index_p_reads + pool_data_p_reads) /
                NULLIF(
                TIMESTAMPDIFF(4, CHAR(snapshot_timestamp - COALESCE(last_reset, db_conn_time)))
                ,0)
        ,0)
        AS p_reads_per_min
FROM SYSIBMADM.SNAPDB AS dbsnap with ur
;

-- Physical Reads Per Minute (PRPM)
-- Bufferpool level
ECHO ==-- PHYSICAL READS PER MINUTE - PRPM --== Bufferpool level;
SELECT char(bpsnap.db_name,20) as db_name,char(bpsnap.bp_name,30) as bp_name,
        COALESCE(
                DECIMAL (bpsnap.pool_index_p_reads + bpsnap.pool_data_p_reads) /
                NULLIF(
                TIMESTAMPDIFF(4, CHAR(bpsnap.snapshot_timestamp -
                COALESCE(dbsnap.last_reset, dbsnap.db_conn_time)))
                ,0)
        ,0) AS p_reads_per_min
FROM SYSIBMADM.SNAPDB AS dbsnap,
SYSIBMADM.SNAPBP AS bpsnap with ur
;

--
ECHO == TOTAL PHYSICAL READS;
select substr(DB_NAME,1,10) as DBNAME,substr(BP_NAME,1,20) as BP_NAME, TOTAL_PHYSICAL_READS,
TOTAL_HIT_RATIO_PERCENT,DATA_PHYSICAL_READS,DATA_HIT_RATIO_PERCENT,INDEX_HIT_RATIO_PERCENT,
XDA_HIT_RATIO_PERCENT from SYSIBMADM.BP_HITRATIO where BP_NAME = 'IBMDEFAULTBP' with ur;


-- Physical Reads Per Minute (PRPM)
-- Tablespace level
ECHO ==-- PHYSICAL READS PER MINUTE - PRPM --== Tablespace level;
SELECT char(current_server,20) as db_name,char(tbssnap.tbsp_name,30) as tbsp_name,
        COALESCE(
                DECIMAL (tbssnap.pool_index_p_reads + tbssnap.pool_data_p_reads) /
                NULLIF(
                TIMESTAMPDIFF(4, CHAR(tbssnap.snapshot_timestamp -
                COALESCE(dbsnap.last_reset, dbsnap.db_conn_time)))
                ,0)
        ,0) AS p_reads_per_min
FROM SYSIBMADM.SNAPDB AS dbsnap,
SYSIBMADM.SNAPTBSP AS tbssnap with ur
;


----
----
----
-- ASYNCHRONOUS WRITE PERCENTAGE - AWP
-- Percentage of writes that occur as a result of async page cleaning
-- Higher is better, since applications generally don't wait during async writes

-- Asynchronous Write Percentage (AWP)
-- Database level
ECHO ==-- ASYNCHRONOUS WRITE PERCENTAGE - AWP --== Database level;
SELECT char(db_name,20) as db_name,
COALESCE(
        DECIMAL((DECIMAL(pool_async_data_writes + pool_async_index_writes) * 100
        / NULLIF(pool_data_writes + pool_index_writes, 0)),5,2)
,0) AS async_write_pct
FROM SYSIBMADM.SNAPDB AS dbsnap with ur
;

-- Asynchronous Write Percentage (AWP)
-- Bufferpool level
ECHO ==-- ASYNCHRONOUS WRITE PERCENTAGE - AWP --== Bufferpool level;
SELECT char(db_name,20) as db_name,char(bp_name,30) as bp_name,
COALESCE(
        DECIMAL((DECIMAL(pool_async_data_writes + pool_async_index_writes) * 100
        / NULLIF(pool_data_writes + pool_index_writes, 0)),5,2)
,0) AS async_write_pct
FROM SYSIBMADM.SNAPBP AS bpsnap with ur
;

-- Asynchronous Write Percentage (AWP)
-- Tablespace level
ECHO ==-- ASYNCHRONOUS WRITE PERCENTAGE - AWP --== Tablespace level;
SELECT char(current_server,20) as db_name,char(tbsp_name,30) as tbsp_name,
COALESCE(
        DECIMAL((DECIMAL(pool_async_data_writes + pool_async_index_writes) * 100
        / NULLIF(pool_data_writes + pool_index_writes, 0)),5,2)
,0) AS async_write_pct
FROM SYSIBMADM.SNAPTBSP AS tbssnap with ur
;

----
-- SYNCHRONOUS WRITE PERCENTAGE - SWP
-- Percentage of page writes that had to occur synchronously
-- High percentage indicates a problem with async page cleaning

----
-- PHYSICAL READS PER TRANSACTION - PRTX

-- Physical Reads per Transaction (PRTX)
-- Database level
ECHO ==-- PHYSICAL READS PER TRANSACTION - PRTX --== Database level;
SELECT char(db_name,20) as db_name,
        COALESCE(
         DECIMAL(pool_index_p_reads + pool_data_p_reads)
        / NULLIF(commit_sql_stmts + rollback_sql_stmts, 0)
        ,0) AS p_reads_per_tx
FROM SYSIBMADM.SNAPDB AS dbsnap with ur
;

-- Physical Reads per Transaction (PRTX)
-- Bufferpool level
ECHO ==-- PHYSICAL READS PER TRANSACTION - PRTX --== Bufferpool level;
SELECT char(bpsnap.db_name,20) as db_name,char(bp_name,30) as bp_name,
        COALESCE(
        DECIMAL(bpsnap.pool_index_p_reads + bpsnap.pool_data_p_reads)
         / NULLIF(dbsnap.commit_sql_stmts + dbsnap.rollback_sql_stmts, 0)
        ,0) AS p_reads_per_tx
FROM SYSIBMADM.SNAPDB AS dbsnap,
SYSIBMADM.SNAPBP AS bpsnap with ur
;

-- Physical Reads per Transaction (PRTX)
-- Tablespace level
ECHO ==-- PHYSICAL READS PER TRANSACTION - PRTX --== Tablespace level;
SELECT char(current_server,20) as db_name,char(tbsp_name,30) as tbsp_name,
        COALESCE(
        DECIMAL(tbssnap.pool_index_p_reads + tbssnap.pool_data_p_reads)
         / NULLIF(dbsnap.commit_sql_stmts + dbsnap.rollback_sql_stmts, 0)
        ,0) AS p_reads_per_tx
FROM SYSIBMADM.SNAPDB AS dbsnap,
SYSIBMADM.SNAPTBSP AS tbssnap with ur
;

----
-- PHYSICAL WRITES PER TRANSACTION - PWTX

-- Physical Writes per Transaction (PWTX)
-- Database level
ECHO ==-- PHYSICAL WRITES PER TRANSACTION - PWTX --== Database level;
SELECT char(db_name,20) as db_name,
        COALESCE(
        DECIMAL(pool_index_writes + pool_data_writes)
        / NULLIF(commit_sql_stmts + rollback_sql_stmts,0)
        ,0) AS p_writes_per_tx
FROM SYSIBMADM.SNAPDB AS dbsnap with ur
;

-- Physical Writes per Transaction (PWTX)
-- Bufferpool level
ECHO ==-- PHYSICAL WRITES PER TRANSACTION - PWTX --== Bufferpool level;
SELECT char(bpsnap.db_name,20) as db_name,char(bp_name,30) as bp_name,
        COALESCE(
        DECIMAL(bpsnap.pool_index_writes + bpsnap.pool_data_writes)
        / NULLIF(dbsnap.commit_sql_stmts + dbsnap.rollback_sql_stmts, 0)
        ,0) AS p_writes_per_tx
FROM SYSIBMADM.SNAPDB AS dbsnap,
SYSIBMADM.SNAPBP AS bpsnap with ur
;

-- Physical Writes per Transaction (PWTX)
-- Tablespace level
ECHO ==-- PHYSICAL WRITES PER TRANSACTION - PWTX --== Tablespace level;
SELECT char(current_server,20) as db_name,char(tbsp_name,30) as tbsp_name,
        COALESCE(
        DECIMAL(tbssnap.pool_index_writes + tbssnap.pool_data_writes)
        / NULLIF(dbsnap.commit_sql_stmts + dbsnap.rollback_sql_stmts,0)
        ,0) AS p_writes_per_tx
FROM SYSIBMADM.SNAPDB AS dbsnap,
SYSIBMADM.SNAPTBSP AS tbssnap with ur
;

----
----
-- I/O MILLISECONDS PER TRANSACTION - MSTX

-- I/O Milliseconds per Transaction (MSTX)
-- Database level
ECHO ==-- I/O MILLISECONDS PER TRANSACTION - MSTX --== Database level;
SELECT char(db_name,20) as db_name,
        COALESCE(
        DECIMAL(pool_read_time + pool_write_time)
        / NULLIF(commit_sql_stmts + rollback_sql_stmts,0)
        ,0) AS io_msec_per_tx
FROM SYSIBMADM.SNAPDB AS dbsnap with ur
;

-- I/O Milliseconds per Transaction (MSTX)
-- Bufferpool level
ECHO ==-- I/O MILLISECONDS PER TRANSACTION - MSTX --== Bufferpool level;
SELECT char(bpsnap.db_name,20) as db_name,char(bp_name,30) as bp_name,
        COALESCE(
        DECIMAL(bpsnap.pool_read_time + bpsnap.pool_write_time)
        / NULLIF(dbsnap.commit_sql_stmts + dbsnap.rollback_sql_stmts,0)
        ,0) AS io_msec_per_tx
FROM SYSIBMADM.SNAPDB AS dbsnap,
SYSIBMADM.SNAPBP AS bpsnap with ur
;

-- I/O Milliseconds per Transaction (MSTX)
-- Tablespace level
ECHO ==-- I/O MILLISECONDS PER TRANSACTION - MSTX --== Tablespace level;
SELECT char(current_server,20) as db_name,char(tbsp_name,30) as tbsp_name,
        COALESCE(
        DECIMAL(tbssnap.pool_read_time + tbssnap.pool_write_time)
        / NULLIF(dbsnap.commit_sql_stmts + dbsnap.rollback_sql_stmts,0)
        ,0) AS io_msec_per_tx
FROM SYSIBMADM.SNAPDB AS dbsnap,
SYSIBMADM.SNAPTBSP AS tbssnap with ur
;

----
-- DIRECT READS PER TRANSACTION - DRTX
-- Direct Reads per Transaction (DRTX)
-- Database level
ECHO ==-- DIRECT READS PER TRANSACTION - DRTX --== Database level;
SELECT char(db_name,20) as db_name,
        COALESCE(
        DECIMAL(direct_reads)
        / NULLIF(commit_sql_stmts + rollback_sql_stmts,0)
        ,0) AS direct_reads_per_tx
FROM SYSIBMADM.SNAPDB AS dbsnap with ur
;

-- Direct Reads per Transaction (DRTX)
-- Bufferpool level
ECHO ==-- DIRECT READS PER TRANSACTION - DRTX --== Bufferpool level;
SELECT char(bpsnap.db_name,20) as db_name,char(bp_name,30) as bp_name,
        COALESCE(
        DECIMAL(bpsnap.direct_reads)
        / NULLIF(dbsnap.commit_sql_stmts + dbsnap.rollback_sql_stmts,0)
        ,0) AS direct_reads_per_tx
FROM SYSIBMADM.SNAPDB AS dbsnap,
SYSIBMADM.SNAPBP AS bpsnap with ur
;

-- Direct Reads per Transaction (DRTX)
-- Tablespace level
ECHO ==-- DIRECT READS PER TRANSACTION - DRTX --== Tablespace level;
SELECT char(current_server,20) as db_name,char(tbsp_name,30) as tbsp_name,
        COALESCE(
        DECIMAL(tbssnap.direct_reads)
        / NULLIF(dbsnap.commit_sql_stmts + dbsnap.rollback_sql_stmts,0)
        ,0) AS direct_reads_per_tx
FROM SYSIBMADM.SNAPDB AS dbsnap,
SYSIBMADM.SNAPTBSP AS tbssnap with ur
;

ECHO ==-- TABLE REORGS;


select substr(tabname,1,15)as TABNAME, reorg_status,reorg_completion,reorg_start, reorg_end
from sysibmadm.snaptab_reorg where reorg_end > (CURRENT TIMESTAMP - 10 days)
order by reorg_end desc fetch first 20 rows only with ur ;

ECHO ==-- APPLICATIOn COMMITS/ROLLBACKS;

select total_app_commits, total_app_rollbacks,avg_rqst_cpu_time,act_wait_time_percent,io_wait_time_percent,
lock_wait_time_percent,network_wait_time_percent,section_sort_proc_time_percent,
rows_read_per_rows_returned,total_bp_hit_ratio_percent from sysibmadm.mon_db_summary with ur;

ECHO ==-- Lock manager and Bufferpool: --==;

SELECT substr(application_handle,1,5) as application_handle ,varchar(db_name, 20) AS dbname, varchar(memory_set_type, 20) AS set_type, varchar(memory_pool_type,20) AS pool_type, memory_pool_used, memory_pool_used_hwm FROM TABLE(MON_GET_MEMORY_POOL(NULL, CURRENT_SERVER, -2)) where memory_set_type IN ('DBMS','DATABASE') with ur;

ECHO ==-- VALUES CURRENT TIMESTAMP --== Finish;
VALUES CURRENT TIMESTAMP;

--db2inst1@srvhqdb04v:/db2home/db2inst1>
