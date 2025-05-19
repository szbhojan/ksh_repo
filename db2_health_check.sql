connect to wcq01;
set schema WSCOMUSR;
ECHO ==-- TOP 20 Dynamic SQL based on AVG_EXEC TIME;
SELECT
        SECTION_TYPE  ,
        NUM_EXECUTIONS,
        TOTAL_CPU_TIME,
        STMT_EXEC_TIME,
        STMT_TEXT     ,
        STMT_EXEC_TIME/NUM_EXECUTIONS AS TOTAL_EXEC_TIME
FROM
        TABLE(MON_GET_PKG_CACHE_STMT ( NULL, NULL, NULL, -2)) as T
WHERE
        TOTAL_EXEC_TIME > 180000
ORDER BY
        TOTAL_EXEC_TIME DESC with ur;
--		
SELECT
        NUM_EXECUTIONS          ,
        AVERAGE_EXECUTION_TIME_S,
        STMT_TEXT
FROM
        SYSIBMADM.TOP_DYNAMIC_SQL
ORDER BY
        AVERAGE_EXECUTION_TIME_S DESC
FETCH   FIRST 50 ROWS ONLY with ur;
ECHO ==-- MOST FREQUENTLY RUN DYNAMIC/STATIC SQL --==;
SELECT
        SECTION_TYPE                                        ,
        TOTAL_CPU_TIME/NUM_EXEC_WITH_METRICS as AVG_CPU_TIME,
        NUM_EXECUTIONS                                      ,
        STMT_TEXT
FROM
        TABLE(MON_GET_PKG_CACHE_STMT ( NULL, NULL, NULL, -1)) as T
ORDER BY
        NUM_EXECUTIONS DESC
FETCH   FIRST 20 rows ONLY;
ECHO ##--HIGH CPU IN Microseconds;
SELECT
        SECTION_TYPE  ,
        NUM_EXECUTIONS,
        --     SUBSTR(STMT_TEXT,1,50) AS STMT_TEXT,
        TOTAL_CPU_TIME                                      ,
        TOTAL_CPU_TIME/NUM_EXEC_WITH_METRICS as AVG_CPU_TIME,
        STMT_TEXT
FROM
        TABLE(MON_GET_PKG_CACHE_STMT ( NULL, NULL, NULL, -1)) as T
ORDER BY
        TOTAL_CPU_TIME DESC
FETCH   FIRST 50 rows ONLY;
ECHO ##--HIGH QUERY COST;
SELECT
        SECTION_TYPE                                        ,
        NUM_EXECUTIONS                                      ,
        TOTAL_CPU_TIME                                      ,
        QUERY_COST_ESTIMATE                                 ,
        TOTAL_CPU_TIME/NUM_EXEC_WITH_METRICS as AVG_CPU_TIME,
        STMT_TEXT
FROM
        TABLE(MON_GET_PKG_CACHE_STMT ( NULL, NULL, NULL, -1)) as T
ORDER BY
        QUERY_COST_ESTIMATE DESC
FETCH   FIRST 200 rows ONLY;
ECHO ##--DIRECT READS FROM DB;
SELECT
        SECTION_TYPE     ,
        NUM_EXECUTIONS   ,
        DIRECT_READS     ,
        DIRECT_READ_REQS ,
        DIRECT_WRITES    ,
        DIRECT_WRITE_REQS,
        STMT_TEXT
FROM
        TABLE(MON_GET_PKG_CACHE_STMT ( NULL, NULL, NULL, -1)) as T
ORDER BY
        DIRECT_READS DESC
FETCH   FIRST 10 rows ONLY;
