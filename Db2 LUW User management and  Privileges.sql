3.	MSC DB2 Soap Credential_srvatldb04v	[all orgs]	--	--	7	SOAP/XML Host	cloudxpz_db2	-- ECOMM QA Primary	
4.	MSC DB2 Soap Credential_srvatldb06v	[all orgs]	--	--	6	SOAP/XML Host	cloudxpz_db2	-- ECOMM QAStandby
5.	MSC DB2 Soap Credential_srvatldb15v	[all orgs]	--	--	8	SOAP/XML Host	cloudxpz_db2	-- MFT Dev
6.	MSC DB2 Soap Credential_srvatldb16v	[all orgs]	--	--	--	SOAP/XML Host	cloudxpz_db2    -- MFT QA Primary
7.	MSC DB2 Soap Credential_srvatldb70v	[all orgs]	--	--	5	SOAP/XML Host	cloudxpz_db2	-- MFT QA CTRACTDB
8.	MSC DB2 Soap Credential_srvstfdb16v	[all orgs]	--	--	5	SOAP/XML Host	cloudxpz_db2	-- MFT Prod Primary
9.	MSC DB2 Soap Credential_srvstfdb17v	[all orgs]	--	--	5	SOAP/XML Host	cloudxpz_db2	-- MFT Prod Standby

has context menu

id - cloudxpz_db2 (db read access)

id - cloudxpz 

DB2 - cloudxpz - djCR@1f#3P7XldV

Device Name	IP address		Device Category	Device Class		DID		Organization	State		CXP Status
srvatldb02v	172.19.4.72		Servers			IBM | AIX Power7	183394	MSCDirect		Healthy		AIX monitoring metrics are collecting fine / Some DB database Metrics are collecting. Need to check DB level permissions
srvatldb04v	172.19.4.43		Servers			IBM | AIX Power7	183414	MSCDirect		Major		AIX monitoring metrics are collecting fine / DB database and tablespace metrics are not collecting - Checking with Vendor
srvatldb06v	172.19.4.45		Servers			IBM | AIX Power7	183416	MSCDirect		Healthy		AIX monitoring metrics are collecting fine / DB database and tablespace metrics are not collecting - Checking with Vendor
srvatldb15v	172.19.4.116	Servers			IBM | AIX Power7	183408	MSCDirect		Healthy		AIX monitoring metrics are collecting fine / DB database and tablespace metrics are not collecting - Checking with Vendor
srvatldb16v	172.19.4.46		Servers			IBM | AIX Power7	183415	MSCDirect		Healthy		AIX monitoring metrics are collecting fine / DB database and tablespace metrics are not collecting - Checking with Vendor
srvatldb70v	172.19.4.115	Servers			IBM | AIX Power7	96533	MSCDirect		Healthy		AIX monitoring metrics are collecting fine / DB database and tablespace metrics are not collecting - Checking with Vendor
srvstfdb16v	172.25.9.68		Servers			IBM | AIX Power7	183402	MSCDirect		Major		AIX monitoring metrics are collecting fine / DB database and tablespace metrics are not collecting - Checking with Vendor
srvstfdb17v	172.25.9.69		Servers			IBM | AIX Power7	183401	MSCDirect		Major		AIX monitoring metrics are collecting fine / DB database and tablespace metrics are not collecting - Checking with Vendor



CONNECT Access - Y
DATA Access - Y 

db2 GRANT DBADM ON DATABASE TO USER USER1.

db2 "CONNECT TO WCQ02" ; db2 "GRANT CONNECT, DATAACCESS ON DATABASE TO USER YERRAMIS";
db2 "GRANT CONNECT, DATAACCESS ON DATABASE TO USER CLOUDXPZ";

db2 "grant connect, dataaccess on database to user cloudxpz"
db2 "GRANT CONNECT, DATAACCESS ON DATABASE TO USER CLOUDXPZ";

db2 "REVOKE CONNECT, DATAACCESS ON DATABASE FROM CLOUDXPZ_DB2" ;


db2 "select char(grantee,20) as grantee, char(granteetype,1) as type, \
char(dbadmauth,1) as dbadm,  char(createtabauth,1) as createtab,  \
char(bindaddauth,1) as bindadd,  char(connectauth,1) as connect,  \
char(nofenceauth,1) as nofence,  char(implschemaauth,1) as implschema,  \
char(loadauth,1) as load,  char(externalroutineauth,1) as extroutine,  \
char(quiesceconnectauth,1) as quiesceconn,  \
char(dataaccessauth,1) as dataaccess, \
char(libraryadmauth,1) as libadm, char(securityadmauth,1) \
as securityadm from  syscat.dbauth order by grantee" ;



db2 "select char(grantee,20) as grantee, char(granteetype,1) as granteetype, \
char(grantor,20) as grantor, char(grantortype,1) as grantortype, \
char(TABSCHEMA,20) as TABSCHEMA,  \
char(TABNAME,40) as TABNAME, \
char(CONTROLAUTH,1) as CONTROLAUTH,  char(ALTERAUTH,1) as ALTERAUTH,  \
char(DELETEAUTH,1) as DELETEAUTH,  char(INDEXAUTH,1) as INDEXAUTH,  \
char(INSERTAUTH,1) as INSERTAUTH,  char(REFAUTH,1) as REFAUTH,  \
char(SELECTAUTH,1) as SELECTAUTH,  char(UPDATEAUTH,1) as UPDATEAUTH  \
from  syscat.tabauth order by grantee" ;



db2 "REVOKE SELECT ON TABLE WSCOMUSR.XEXCLUDED_ITEMS FROM USER YERRAMIS";
*******************************************************************************************************

**********************************************************************************************
--db2 "SELECT * FROM SYSCAT.DBAUTH WHERE GRANTEE like 'S%'" ;

db2 "select char(grantee,20) as grantee, char(granteetype,1) as type, \
char(dbadmauth,1) as dbadm,  char(createtabauth,1) as createtab,  \
char(bindaddauth,1) as bindadd,  char(connectauth,1) as connect,  \
char(nofenceauth,1) as nofence,  char(implschemaauth,1) as implschema,  \
char(loadauth,1) as load,  char(externalroutineauth,1) as extroutine,  \
char(quiesceconnectauth,1) as quiesceconn,  \
char(dataaccessauth,1) as dataaccess, \
char(libraryadmauth,1) as libadm, char(securityadmauth,1) \
as securityadm from  syscat.dbauth order by grantee" ;

------------------------

--db2 "SELECT * FROM SYSCAT.TABAUTH WHERE GRANTEE like 'S%'" ;

db2 "select char(grantee,20) as grantee, char(granteetype,1) as granteetype, \
--char(grantor,20) as grantor, char(grantortype,1) as grantortype, \
char(TABSCHEMA,20) as TABSCHEMA,  \
char(TABNAME,40) as TABNAME, \
char(CONTROLAUTH,1) as CONTROLAUTH,  char(ALTERAUTH,1) as ALTERAUTH,  \
char(DELETEAUTH,1) as DELETEAUTH,  char(INDEXAUTH,1) as INDEXAUTH,  \
char(INSERTAUTH,1) as INSERTAUTH,  char(REFAUTH,1) as REFAUTH,  \
char(SELECTAUTH,1) as SELECTAUTH,  char(UPDATEAUTH,1) as UPDATEAUTH  \
from  syscat.tabauth order by grantee" ;

------------------------------

--db2 "SELECT * FROM SYSIBMADM.PRIVILEGES WHERE AUTHID like 'S%' ORDER BY AUTHID";

db2 "select char(AUTHID,20) as AUTHID, char(AUTHIDTYPE,1) as AUTHIDTYPE, \
char(OBJECTSCHEMA,20) as OBJECTSCHEMA, char(OBJECTNAME,40) as OBJECTNAME, \
char(OBJECTTYPE,40) as OBJECTTYPE, char(GRANTABLE,1) as GRANTABLE, \
char(PRIVILEGE,40) as PRIVILEGE \
from sysibmadm.privileges \
where AUTHIDTYPE = 'R' \
order by authid" ;

----------------------------

--db2 "SELECT * FROM SYSCAT.ROLEAUTH WHERE GRANTEE like 'S%' ORDER BY GRANTEE" ;


db2 "select char(grantee,20) as grantee, char(granteetype,1) as granteetype, \
char(grantor,20) as grantor, char(grantortype,1) as grantortype, \
char(ROLENAME,20) as ROLENAME, ROLEID, char(ADMIN,1) as ADMIN \
from syscat.roleauth \
order by ROLENAME" ;

---------------------------

db2 "SELECT * FROM SYSCAT.SCHEMAAUTH" ;
db2 "SELECT * FROM SYSCAT.COLAUTH " ;

------------------------

-- List groups associated with a user (as recognized by Db2)
db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('ROYA'))" ;


********************************************************************************************************

usermod -G db2mongp cloudxpz
usermod -G db2read yerramis

db2 "CONNECT TO DB WCD01" ;
--db2 "GRANT CONNECT ON DATABASE TO USER CLOUDXPZ";
db2 "REVOKE CONNECT ON DATABASE FROM USER CLOUDXPZ" ;
db2 "REVOKE DATAACCESS ON DATABASE FROM GROUP DB2MONGP" ;
db2 "GRANT DATAACCESS ON DATABASE TO USER CLOUDXPZ" ;
db2 "GRANT CONNECT ON DATABASE TO GROUP DB2MONGP" ;
db2 "GRANT DATAACCESS ON DATABASE TO GROUP DB2MONGP" ;
--db2 "GRANT SYSMON ON DATABASE TO GROUP DB2MONGP" ;


db2 "GRANT CONNECT, BINDADD, CREATETAB, IMPLICIT_SCHEMA ON DATABASE TO PUBLIC";

--db2 "GRANT ROLE DB2READ TO USER CLOUDXPZ"
--db2 "REVOKE ROLE DB2READ FROM USER CLOUDXPZ";

db2 "GRANT SELECT ON SYSIBMADM.LOG_UTILIZATION TO GROUP DB2MONGP" ;
db2 "GRANT SELECT ON SYSIBMADM.SNAPDB TO GROUP DB2MONGP" ;
db2 "GRANT SELECT ON SYSIBMADM.MON_BP_UTILIZATION TO GROUP DB2MONGP" ;
db2 "GRANT SELECT ON SYSIBMADM.ADMINTABINFO TO GROUP DB2MONGP" ;
db2 "GRANT SELECT ON SYSIBMADM.SNAPTAB TO GROUP DB2MONGP" ;
db2 "GRANT SELECT ON SYSCAT.TABLES TO GROUP DB2MONGP";
db2 GRANT SELECT ON TABLE "SYSIBMADM"."*" TO GROUP DB2MONGP ;

db2 "GRANT SELECT ON sysibmadm.mon_db_summary TO USER CLOUDXPZ"


db2 GRANT EXECUTE ON FUNCTION SYSPROC.* TO GROUP DB2MONGP ;
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.SNAP_GET_APPL(VARCHAR(),INTEGER) TO GROUP DB2MONGP";
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.MON_GET_TABLESPACE(VARCHAR(),INTEGER) TO GROUP DB2MONGP";
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.ENV_GET_DB2_SYSTEM_RESOURCES(INTEGER) TO GROUP DB2MONGP";
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.ENV_GET_SYSTEM_RESOURCES() TO GROUP DB2MONGP";
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.ADMIN_GET_DBP_MEM_USAGE() TO GROUP DB2MONGP";
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.MON_GET_BUFFERPOOL(VARCHAR(),INTEGER) TO GROUP DB2MONGP";
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.MON_GET_PKG_CACHE_STMT(CHAR(),VARCHAR(), CLOB(),INTEGER) TO GROUP DB2MONGP";
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.MON_GET_TABLESPACE(VARCHAR(),INTEGER) TO GROUP DB2MONGP";
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.MON_GET_DATABASE TO GROUP DB2MONGP";
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.MON_SAMPLE_WORKLOAD_METRICS TO GROUP DB2MONGP";
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.MON_GET_ACTIVITY TO GROUP DB2MONGP";
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.MON_GET_BUFFERPOOL TO GROUP DB2MONGP";
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.MON_GET_TABLESPACE TO GROUP DB2MONGP";
db2 "GRANT EXECUTE ON FUNCTION SYSPROC.MON_GET_TRANSACTION_LOG TO GROUP DB2MONGP";

db2 "GRANT EXECUTE ON FUNCTION sysproc.mon_get_tablespace TO CLOUDXPZ" ;
db2 "GRANT EXECUTE ON FUNCTION sysproc.mon_get_workload TO CLOUDXPZ" ;
db2 "GRANT EXECUTE ON FUNCTION sysproc.mon_get_service_subclass TO CLOUDXPZ" ;
db2 "GRANT EXECUTE ON FUNCTION sysproc.mon_get_table TO CLOUDXPZ" ;
db2 "GRANT EXECUTE ON FUNCTION sysproc.mon_get_bufferpool TO CLOUDXPZ" ;
db2 "GRANT EXECUTE ON FUNCTION sysproc.env_get_system_resources TO CLOUDXPZ" ;
db2 "GRANT EXECUTE ON FUNCTION sysproc.mon_get_container TO CLOUDXPZ" ;
db2 "GRANT EXECUTE ON FUNCTION sysproc.mon_get_index TO CLOUDXPZ" ;

*****************************************************************************************************************************************
No: of Tables in SYSCAT.TABAUTH under schema SYSIBMADM
-------------------------------------------------------

db2 "select count(*) as no_of_tables from syscat.tabauth where tabschema='SYSIBMADM'";

NO_OF_TABLES
------------
          78

  1 record(s) selected.


db2 "select substr(TABNAME,1,40) as TABNAME from syscat.tabauth where tabschema='SYSIBMADM'";

TABNAME
----------------------------------------
ADMINTABINFO
ADMINTABINFO
ADMINTABINFO
ADMINTEMPCOLUMNS
ADMINTEMPTABLES
APPLICATIONS
APPL_PERFORMANCE
AUTHORIZATIONIDS
BP_HITRATIO
BP_READ_IO
BP_WRITE_IO
CONTACTGROUPS
CONTACTS
CONTAINER_UTILIZATION
DB2_INSTANCE_ALERTS
DBCFG
DBMCFG
DBPATHS
DB_HISTORY
ENV_CF_SYS_RESOURCES
ENV_FEATURE_INFO
ENV_INST_INFO
ENV_PROD_INFO
ENV_SYS_INFO
ENV_SYS_RESOURCES
INGEST_USER_CONNECTIONS
LOCKS_HELD
LOCKWAITS
LOG_UTILIZATION
LOG_UTILIZATION
LOG_UTILIZATION
LONG_RUNNING_SQL
MON_BP_UTILIZATION
MON_BP_UTILIZATION
MON_DB_SUMMARY
MON_TRANSACTION_LOG_UTILIZATION
NOTIFICATIONLIST
OBJECTOWNERS
PDLOGMSGS_LAST24HOURS
PRIVILEGES
QUERY_PREP_COST
REG_VARIABLES
SNAPAGENT
SNAPAGENT_MEMORY_POOL
SNAPAPPL
SNAPAPPL_INFO
SNAPBP
SNAPBP_PART
SNAPCONTAINER
SNAPDB
SNAPDB
SNAPDB
SNAPDBM
SNAPDBM_MEMORY_POOL
SNAPDB_MEMORY_POOL
SNAPDETAILLOG
SNAPDYN_SQL
SNAPFCM
SNAPFCM_PART
SNAPHADR
SNAPLOCK
SNAPLOCKWAIT
SNAPSTMT
SNAPSTORAGE_PATHS
SNAPSUBSECTION
SNAPSWITCHES
SNAPTAB
SNAPTAB
SNAPTAB
SNAPTAB_REORG
SNAPTBSP
SNAPTBSP_PART
SNAPTBSP_QUIESCER
SNAPTBSP_RANGE
SNAPUTIL
SNAPUTIL_PROGRESS
TBSP_UTILIZATION
TOP_DYNAMIC_SQL

  78 record(s) selected.



*****************************************************************************************************************************************

List of Authid:
----------------
db2 "SELECT * FROM SYSIBMADM.AUTHORIZATIONIDS ORDER BY AUTHIDTYPE" ;

AUTHID                                                                                                                           AUTHIDTYPE
-------------------------------------------------------------------------------------------------------------------------------- ----------
DB2MONGP                                                                                                                         G
DB2READ                                                                                                                          G
PUBLIC                                                                                                                           G
DBACCESS                                                                                                                         R
SYSDEBUG                                                                                                                         R
SYSDEBUGPRIVATE                                                                                                                  R
SYSTS_ADM                                                                                                                        R
SYSTS_MGR                                                                                                                        R
AMBUPEJ                                                                                                                          U
AN                                                                                                                               U
BANNERJK                                                                                                                         U
BHATS01                                                                                                                          U
CLOUDXPZ                                                                                                                         U
CLOUDXPZ_DB2                                                                                                                     U
CROSSITUSR                                                                                                                       U
DAMANIAR                                                                                                                         U
DB2INST1                                                                                                                         U


List of Authid with WHERE Clause:
------------------------------------

db2 "SELECT * FROM SYSIBMADM.AUTHORIZATIONIDS WHERE AUTHID = 'DB2READ' ORDER BY AUTHIDTYPE" ;

AUTHID                                                                                                                           AUTHIDTYPE
-------------------------------------------------------------------------------------------------------------------------------- ----------
DB2READ                                                                                                                          G
DB2READ                                                                                                                          U

  2 record(s) selected.

git-bash password
--------------------
ATBBQ8DjE28faxcmXP9f7UjPVtjg0BD47D67 

Clone Dir
---------
git clone https://saravananbhojan1@bitbucket.org/mscdirect/ecomm-dso-dbs.git

List of Authorities for a Authid: Eg. Authid is 'CLOUDXPZ'
------------------------------------------------------------

db2 "SELECT SUBSTR(AUTHORITY,1,30) AS AUTHORITY, D_USER, D_GROUP, D_PUBLIC, ROLE_USER, ROLE_GROUP, ROLE_PUBLIC, D_ROLE   FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('CLOUDXPZ', 'U') ) AS T  ORDER BY AUTHORITY" ;

AUTHORITY                      D_USER D_GROUP D_PUBLIC ROLE_USER ROLE_GROUP ROLE_PUBLIC D_ROLE
------------------------------ ------ ------- -------- --------- ---------- ----------- ------
ACCESSCTRL                     N      N       N        N         N          N           *
BINDADD                        N      N       Y        N         N          N           *
CONNECT                        N      Y       Y        N         N          N           *
CREATETAB                      N      N       Y        N         N          N           *
CREATE_EXTERNAL_ROUTINE        N      N       N        N         N          N           *
CREATE_NOT_FENCED_ROUTINE      N      N       N        N         N          N           *
CREATE_SECURE_OBJECT           N      N       N        N         N          N           *
DATAACCESS                     Y      N       N        N         N          N           *
DBADM                          N      N       N        N         N          N           *
EXPLAIN                        N      N       N        N         N          N           *
IMPLICIT_SCHEMA                N      N       Y        N         N          N           *
LOAD                           N      N       N        N         N          N           *
QUIESCE_CONNECT                N      N       N        N         N          N           *
SECADM                         N      N       N        N         N          N           *
SQLADM                         N      N       N        N         N          N           *
SYSADM                         *      N       *        *         *          *           *
SYSCTRL                        *      N       *        *         *          *           *
SYSMAINT                       *      N       *        *         *          *           *
SYSMON                         *      Y       *        *         *          *           *
WLMADM                         N      N       N        N         N          N           *

  20 record(s) selected.




Retrieve All the Groups where the User Belongs:
------------------------------------------------
db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('CLOUDXPZ')) AS T" ;


GROUP
--------------------------------------------------------------------------------------------------------------------------------
DB2MONGP
STAFF

  2 record(s) selected.



List of Roles:
--------------
db2 "SELECT SUBSTR(GRANTOR,1,10) as GRANTOR, GRANTEETYPE, SUBSTR(GRANTEE,1,10) as GRANTEE, GRANTORTYPE, SUBSTR(ROLENAME,1,15) as ROLENAME, CREATE_TIME, ADMIN FROM TABLE (SYSPROC.AUTH_LIST_ROLES_FOR_AUTHID ('CLOUDXPZ', 'U') ) AS T" ;


GRANTOR    GRANTEETYPE GRANTEE    GRANTORTYPE ROLENAME        CREATE_TIME                ADMIN
---------- ----------- ---------- ----------- --------------- -------------------------- -----

  0 record(s) selected.



Retrieve List of ROLES:
----------------------------

db2 "SELECT SUBSTR(GRANTOR,1,30) as GRANTOR, GRANTORTYPE, GRANTORROLEID,  SUBSTR(GRANTEE,1,30) as GRANTEE, GRANTEETYPE, GRANTEEROLEID, \
SUBSTR(ROLENAME,1,30) as ROLENAME, ROLEID, ADMIN FROM SYSIBM.SYSROLEAUTH ORDER BY ROLENAME";

GRANTOR                        GRANTORTYPE GRANTORROLEID GRANTEE                        GRANTEETYPE GRANTEEROLEID ROLENAME                       ROLEID      ADMIN
------------------------------ ----------- ------------- ------------------------------ ----------- ------------- ------------------------------ ----------- -----
DB2INST1                       U                       - SG                             U                       - DB2READ                               1003 N
DB2INST1                       U                       - NM                             U                       - DB2READ                               1003 N
DB2INST1                       U                       - URSC                           U                       - DB2READ                               1003 N
DB2INST1                       U                       - FEIR                           U                       - DB2READ                               1003 N
DB2INST1                       U                       - RAHMANM                        U                       - DB2READ                               1003 N
DB2INST1                       U                       - MSCREAD1                       U                       - DB2READ                               1003 N
DB2INST1                       U                       - CHANDRAC                       U                       - DB2READ                               1003 N
DB2INST1                       U                       - ROYA                           U                       - DB2READ                               1003 N
DB2INST1                       U                       - HEIMS                          U                       - DB2READ                               1003 N
DB2INST1                       U                       - SELVARAS                       U                       - DB2READ                               1003 N
DB2INST1                       U                       - DAUBL                          U                       - DB2READ                               1003 N
DB2INST1                       U                       - GALLMEIT                       U                       - DB2READ                               1003 N
DB2INST1                       U                       - LOFASOJ                        U                       - DB2READ                               1003 N




List of Authid having Database Authorization: 
----------------------------------------------

SYSCAT.DBAUTH
--------------

db2 "select \
char(grantee,20) as grantee, \
char(granteetype,1) as granteetype, \
char(grantor,20) as grantor, \
char(grantortype,1) as grantortype, \
char(dbadmauth,1) as dbadm,  \
char(createtabauth,1) as createtab,  \
char(bindaddauth,1) as bindadd,  \
char(connectauth,1) as connect,  \
char(nofenceauth,1) as nofence,  \
char(implschemaauth,1) as implschema,  \
char(loadauth,1) as load,  \
char(externalroutineauth,1) as extroutine,  \
char(quiesceconnectauth,1) as quiesceconn,  \
char(dataaccessauth,1) as dataaccess, \
char(libraryadmauth,1) as libadm, \
char(securityadmauth,1) as securityadm, \
char(sqladmauth,1) as sqladm, \
char(wlmadmauth,1) as wlmadm, \
char(explainauth,1) as explain, \
char(accessctrlauth,1) as accessctrl, \
char(createsecureauth,1) as createsecure \
from  syscat.dbauth order by grantee";
--where grantee='cloudxpz' \

GRANTEE              GRANTEETYPE GRANTOR              GRANTORTYPE DBADM CREATETAB BINDADD CONNECT NOFENCE IMPLSCHEMA LOAD EXTROUTINE QUIESCECONN DATAACCESS LIBADM SECURITYADM SQLADM WLMADM EXPLAIN ACCESSCTRL CREATESECURE
-------------------- ----------- -------------------- ----------- ----- --------- ------- ------- ------- ---------- ---- ---------- ----------- ---------- ------ ----------- ------ ------ ------- ---------- ------------
BHATV                U           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
CLOUDXPZ             U           DB2INST1             U           N     N         N       N       N       N          N    N          N           Y          N      N           N      N      N       N          N
CLOUDXPZ_DB2         U           DB2INST1             U           N     N         N       Y       N       N          N    N          N           Y          N      N           N      N      N       N          N
DASS                 U           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      Y           N      N      N       Y          N
DB2INST1             U           SYSIBM               S           Y     N         N       N       N       N          N    N          N           Y          N      Y           N      N      N       Y          N
DB2MONGP             G           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
DB2READ              R           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
DBACCESS             R           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
KRISHNAA             U           DB2INST1             U           N     N         N       N       N       N          N    N          N           Y          N      N           N      N      Y       Y          N
MUMESH               U           DB2INST1             U           N     N         N       N       N       N          N    N          N           Y          N      N           N      N      N       Y          N
POUTREAD             R           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
PUBLIC               G           DB2INST1             U           N     Y         Y       Y       N       Y          N    N          N           N          N      N           N      N      N       N          N
ROYA                 U           DB2INST1             U           N     N         Y       Y       N       Y          N    Y          N           N          N      N           N      N      N       N          N
SANKARAV             U           DB2INST1             U           N     N         Y       N       N       N          N    N          N           Y          N      N           N      N      N       Y          N
THIMMAPA             U           DB2INST1             U           N     Y         Y       Y       N       Y          N    Y          N           N          N      N           N      N      N       N          N
WCSGCPUSR            U           DB2INST1             U           N     N         N       Y       N       N          N    N          N           Y          N      N           N      N      N       N          N
WSCOMUSR             U           DB2INST1             U           N     N         N       Y       N       N          N    N          N           Y          N      N           N      N      N       Y          N
WSPOUT               U           DB2INST1             U           N     N         N       N       N       N          N    N          N           Y          N      N           N      N      N       N          N

  18 record(s) selected.



To check what users have access in a specific table/schema
-------------------------------------------------------------

SYSCAT.TABAUTH
----------------
db2 "select substr(grantor,1,20) as grantor, substr(grantee,1,20) as grantee, substr(tabname,1,40) as tabname, substr(tabschema,1,40) as tabschema, selectauth from syscat.tabauth where tabschema='SYSIBMADM' order by 1, 2, 3 with ur" ;


GRANTOR              GRANTEE              TABNAME                                  SELECTAUTH
-------------------- -------------------- ---------------------------------------- ----------
DB2INST1             BHATV                ADMINTABCOMPRESSINFO                     Y
DB2INST1             BHATV                ADMINTABINFO                             Y
DB2INST1             BHATV                ADMINTEMPCOLUMNS                         Y
DB2INST1             BHATV                ADMINTEMPTABLES                          Y
DB2INST1             BHATV                SNAPSWITCHES                             Y
DB2INST1             BHATV                SNAPTAB                                  Y
DB2INST1             BHATV                SNAPTAB_REORG                            Y
DB2INST1             BHATV                SNAPTBSP                                 Y
DB2INST1             BHATV                SNAPTBSP_PART                            Y
DB2INST1             BHATV                SNAPTBSP_QUIESCER                        Y
DB2INST1             BHATV                SNAPTBSP_RANGE                           Y
DB2INST1             BHATV                SNAPUTIL                                 Y
DB2INST1             BHATV                SNAPUTIL_PROGRESS                        Y
DB2INST1             BHATV                TBSP_UTILIZATION                         Y
DB2INST1             BHATV                TOP_DYNAMIC_SQL                          Y
DB2INST1             DB2MONGP             ADMINTABCOMPRESSINFO                     Y
DB2INST1             DB2MONGP             ADMINTABINFO                             Y
DB2INST1             DB2MONGP             ADMINTEMPCOLUMNS                         Y
DB2INST1             DB2MONGP             ADMINTEMPTABLES                          Y
DB2INST1             DB2MONGP             APPLICATIONS                             Y
DB2INST1             DB2MONGP             APPL_PERFORMANCE                         Y
DB2INST1             DB2MONGP             AUTHORIZATIONIDS                         Y
DB2INST1             DB2MONGP             BP_HITRATIO                              Y
DB2INST1             DB2MONGP             BP_READ_IO                               Y
DB2INST1             DB2MONGP             BP_WRITE_IO                              Y
DB2INST1             DB2MONGP             CONTACTGROUPS                            Y
DB2INST1             DB2MONGP             CONTACTS                                 Y
DB2INST1             DB2MONGP             CONTAINER_UTILIZATION                    Y
DB2INST1             DB2MONGP             DBCFG                                    Y
DB2INST1             DB2MONGP             DBMCFG                                   Y


To check which priviledges are granted to a ROLE
-------------------------------------------------

db2 "SELECT
       char(authid,15) AS AUTHID,
       authidtype,
       char(privilege, 10) privilege, 
       grantable,
       char(objectschema,10) AS OBJECTSCHEMA ,
       char(objectname,65) OBJECTNAME,
       objecttype
FROM sysibmadm.privileges
WHERE authid='POUTREAD'
  AND authidtype='R' 
ORDER BY 1,2,3 WITH UR" ;  

  
--

To check which priviledges are granted to a USER
-------------------------------------------------

db2 "SELECT
       char(authid,15) AS AUTHID,
       authidtype,
       char(privilege, 10) privilege, 
       grantable,
       char(objectschema,10) AS OBJECTSCHEMA ,
       char(objectname,65) OBJECTNAME,
       objecttype
FROM sysibmadm.privileges
WHERE authid='YERRAMIS'
  AND authidtype='U' 
ORDER BY 1,2,3 WITH UR" ;  


To check which priviledges are granted to a GROUP
-------------------------------------------------

db2 "SELECT
       char(authid,15) AS AUTHID,
       authidtype,
       char(privilege, 10) privilege, 
       grantable,
       char(objectschema,10) AS OBJECTSCHEMA ,
       char(objectname,65) OBJECTNAME,
       objecttype
FROM sysibmadm.privileges
WHERE authid='DB2READ'
  AND authidtype='G' 
ORDER BY 1,2,3 WITH UR" ;  
  
  

db2 "SELECT SUBSTR(GRANTOR,1,15) as GRANTOR, GRANTORTYPE, SUBSTR(GRANTEE,1,15) as GRANTEE, GRANTEETYPE, \
SUBSTR(TABSCHEMA,1,15) as TABSCHEMA, SUBSTR(TABNAME,1,30)as TABNAME, CHAR(CONTROLAUTH,1) as CONTROLAUTH, \
CHAR(ALTERAUTH,1) as ALTERAUTH, CHAR(DELETEAUTH,1) as DELETEAUTH, CHAR(INDEXAUTH,1) as INDEXAUTH, \
CHAR(INSERTAUTH,1) as INSERTAUTH, CHAR(REFAUTH,1) as REFAUTH, CHAR(SELECTAUTH,1) as SELECTAUTH, \
CHAR(UPDATEAUTH,1) as UPDATEAUTH FROM SYSCAT.TABAUTH WHERE TABSCHEMA='SYSIBMADM' ORDER BY 1, 2, 3 WITH UR" ;


GRANTOR         GRANTORTYPE GRANTEE         GRANTEETYPE TABSCHEMA       TABNAME                        CONTROLAUTH ALTERAUTH DELETEAUTH INDEXAUTH INSERTAUTH REFAUTH SELECTAUTH UPDATEAUTH
--------------- ----------- --------------- ----------- --------------- ------------------------------ ----------- --------- ---------- --------- ---------- ------- ---------- ----------
DB2INST1        U           BHATV           U           SYSIBMADM       SNAPTBSP                       N           N         N          N         N          N       Y          N
DB2INST1        U           BHATV           U           SYSIBMADM       SNAPTBSP_PART                  N           N         N          N         N          N       Y          N
DB2INST1        U           BHATV           U           SYSIBMADM       SNAPTBSP_QUIESCER              N           N         N          N         N          N       Y          N
DB2INST1        U           BHATV           U           SYSIBMADM       SNAPTBSP_RANGE                 N           N         N          N         N          N       Y          N
DB2INST1        U           BHATV           U           SYSIBMADM       SNAPUTIL                       N           N         N          N         N          N       Y          N
DB2INST1        U           BHATV           U           SYSIBMADM       SNAPUTIL_PROGRESS              N           N         N          N         N          N       Y          N
DB2INST1        U           BHATV           U           SYSIBMADM       TBSP_UTILIZATION               N           N         N          N         N          N       Y          N
DB2INST1        U           BHATV           U           SYSIBMADM       TOP_DYNAMIC_SQL                N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       ADMINTABCOMPRESSINFO           N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       ADMINTABINFO                   N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       ADMINTEMPCOLUMNS               N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       ADMINTEMPTABLES                N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       APPLICATIONS                   N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       APPL_PERFORMANCE               N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       AUTHORIZATIONIDS               N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       BP_HITRATIO                    N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       BP_READ_IO                     N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       BP_WRITE_IO                    N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       CONTACTGROUPS                  N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       CONTACTS                       N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       CONTAINER_UTILIZATION          N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       DBCFG                          N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       DBMCFG                         N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       DBPATHS                        N           N         N          N         N          N       Y          N
DB2INST1        U           DB2MONGP        G           SYSIBMADM       DB_HISTORY                     N           N         N          N         N          N       Y          N


SYSIBM.SYSUSERAUTH
-------------------

db2 "SELECT SUBSTR(GRANTEE,1,15) as GRANTEE, GRANTEETYPE, SUBSTR(TABSCHEMA,1,15) as TABSCHEMA, SUBSTR(TABNAME,1,30)as TABNAME, \
SUBSTR(AUTH_DESC,1,40) as AUTH_DESC, GRANTEEROLEID FROM SYSIBM.SYSUSERAUTH ORDER BY 1, 2, 3, 4" ;


GRANTEE         GRANTEETYPE TABSCHEMA       TABNAME                        AUTH_DESC                                                                           GRANTEEROLEID
--------------- ----------- --------------- ------------------------------ ----------------------------------------------------------------------------------- -------------
AKTHARZ         U           WSCOMUSR        ORDERS                         x'10000060000000000000000000000000000000000000000000000000000000000000000000000000'             -
AKTHARZ         U           WSCOMUSR        XCAUPLD                        x'10000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
ANDREWJ         U           DB2INST1        XORGATTRTMP                    x'10000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
ANDREWJ         U           WSCOMUSR        XGUESTAUTHDETAILS              x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
ANDREWJ         U           WSCOMUSR        XNPATBL                        x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           DB2INST1        TEMP_USERS                     x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           DB2INST1        TEMP_USERS_SQL                 x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           SYSCAT          ATTRIBUTES                     x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           SYSCAT          AUDITPOLICIES                  x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           SYSCAT          AUDITUSE                       x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           SYSCAT          BUFFERPOOLDBPARTITIONS         x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           SYSCAT          BUFFERPOOLEXCEPTIONS           x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           SYSCAT          BUFFERPOOLNODES                x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           SYSCAT          BUFFERPOOLS                    x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           SYSCAT          CASTFUNCTIONS                  x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             
BHATV           U           SYSTOOLS        POLICY                         x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           SYSTOOLS        STMG_DBSIZE_INFO               x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           WCAUDIT         MESSAGE                        x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           WCAUDIT         MESSAGE_CP                     x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           WCAUDIT         MSGPROPERTY                    x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           WSCOMUSR        MESSAGE                        x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           WSCOMUSR        XCAMPAIGN                      x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           WSCOMUSR        XMEMBER_TEMP                   x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           WSCOMUSR        XNOTIFICATION                  x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           WSCOMUSR        XORDDLTTMP                     x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           WSCOMUSR        XSEARCH                        x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           WSCOMUSR        XSEARCHRESULTS                 x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
BHATV           U           WSCOMUSR        XWEBLOG                        x'14000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
DB2DEVGRP       G           DB2INST1        TEMP_USERS_SQL                 x'10000020000000000000000000000000000000000000000000000000000000000000000000000000'             -
DB2INST1        U           ASN             IBMQREP_COLVERSION             x'1000FEFF000000000000000000000000000000000000000000000000000000000000000000000000'             -
DB2INST1        U           ASN             IBMQREP_IGNTRAN                x'1000FEFF000000000000000000000000000000000000000000000000000000000000000000000000'             -
DB2INST1        U           ASN             IBMQREP_IGNTRANTRC             x'1000FEFF000000000000000000000000000000000000000000000000000000000000000000000000'             -
DB2INST1        U           ASN             IBMQREP_PART_HIST              x'1000FEFF000000000000000000000000000000000000000000000000000000000000000000000000'             -
DB2INST1        U           ASN             IBMQREP_TABVERSION             x'1000FEFF000000000000000000000000000000000000000000000000000000000000000000000000'             -
DB2INST1        U           ASN             IBMSNAP_CAPENQ                 x'1000FEFF000000000000000000000000000000000000000000000000000000000000000000000000'             -
DB2INST1        U           ASN             IBMSNAP_CAPMON                 x'1000FEFF000000000000000000000000000000000000000000000000000000000000000000000000'             -



db2 "select substr(authid,1,20) as authid \
    , authidtype \
    , privilege \
    , grantable \
    , substr(objectschema,1,12) as objectschema \
    , substr(objectname,1,30) as objectname \
    , objecttype \
from sysibmadm.privileges \
where objectschema ='SYSPROC' AND AUTHID='DB2MONGP'";


AUTHID               AUTHIDTYPE PRIVILEGE   GRANTABLE OBJECTSCHEMA OBJECTNAME                     OBJECTTYPE
-------------------- ---------- ----------- --------- ------------ ------------------------------ ------------------------
DB2MONGP             G          EXECUTE     N         SYSPROC      ADMIN_GET_DBP_MEM_USAGE_AP     FUNCTION
DB2MONGP             G          EXECUTE     N         SYSPROC      ENV_GET_DB2_SYSTEM_RESOURCES   FUNCTION
DB2MONGP             G          EXECUTE     N         SYSPROC      ENV_GET_SYSTEM_RESOURCES       FUNCTION
DB2MONGP             G          EXECUTE     N         SYSPROC      MON_GET_ACTIVITY               FUNCTION
DB2MONGP             G          EXECUTE     N         SYSPROC      MON_GET_BUFFERPOOL             FUNCTION
DB2MONGP             G          EXECUTE     N         SYSPROC      MON_GET_DATABASE               FUNCTION
DB2MONGP             G          EXECUTE     N         SYSPROC      MON_GET_PKG_CACHE_STMT         FUNCTION
DB2MONGP             G          EXECUTE     N         SYSPROC      MON_GET_TABLESPACE             FUNCTION
DB2MONGP             G          EXECUTE     N         SYSPROC      MON_GET_TRANSACTION_LOG        FUNCTION
DB2MONGP             G          EXECUTE     N         SYSPROC      MON_SAMPLE_WORKLOAD_METRICS    FUNCTION
DB2MONGP             G          EXECUTE     N         SYSPROC      SNAP_GET_APPL                  FUNCTION
DB2MONGP             G          EXECUTE     N         SYSPROC      -                              FUNCTION

  12 record(s) selected.


db2 "SELECT * FROM SYSIBMADM.PRIVILEGES WHERE AUTHID = 'CLOUDXPZ' AND  AUTHIDTYPE = 'U'";
db2 "SELECT * FROM SYSCAT.DBAUTH WHERE GRANTEE = 'CLOUDXPZ' AND GRANTEETYPE = 'U' ";
db2 "SELECT * FROM SYSCAT.TABAUTH WHERE GRANTEE = 'CLOUDXPZ'";



****************************************************************************************************************************************

List the Privileges: For User Belongs to a Group
--------------------
Checking Direct Privileges For Authorization ID of Type Role: DB2MONGP
------------------------------------------------------

db2 "SELECT SUBSTR(AUTHID,1,30) as AUTHID, AUTHIDTYPE, PRIVILEGE, GRANTABLE, SUBSTR(OBJECTNAME,1,30) as OBJECTNAME, SUBSTR(OBJECTSCHEMA,1,30) as OBJECTSCHEMA, OBJECTTYPE \
FROM SYSIBMADM.PRIVILEGES WHERE AUTHID='DB2MONGP'";

AUTHID                         AUTHIDTYPE PRIVILEGE   GRANTABLE OBJECTNAME                     OBJECTSCHEMA                   OBJECTTYPE
------------------------------ ---------- ----------- --------- ------------------------------ ------------------------------ ------------------------
DB2MONGP                       G          SELECT      N         SQLCOLPRIVILEGES               SYSIBM                         VIEW
DB2MONGP                       G          SELECT      N         SYSVIEWDEP                     SYSIBM                         TABLE
DB2MONGP                       G          SELECT      N         SYSPLANDEP                     SYSIBM                         TABLE
DB2MONGP                       G          SELECT      N         SYSSECTION                     SYSIBM                         TABLE
DB2MONGP                       G          SELECT      N         SYSSTMT                        SYSIBM                         TABLE
DB2MONGP                       G          SELECT      N         SYSPLANAUTH                    SYSIBM                         TABLE
DB2MONGP                       G          SELECT      N         SYSTABAUTH                     SYSIBM                         TABLE


Privileges For User 'CLOUDXPZ belongs to Group 'DB2MONGP'
------------------------------------------------------------

db2 "SELECT DISTINCT SUBSTR(P.AUTHID,1,10) as AUTHID, P.AUTHIDTYPE, P.PRIVILEGE, SUBSTR(P.OBJECTNAME,1,40) as OBJECTNAME , SUBSTR(P.OBJECTSCHEMA,1,40) as OBJECTSCHEMA, P.OBJECTTYPE \
FROM SYSIBMADM.PRIVILEGES P,  \
     SYSIBMADM.AUTHORIZATIONIDS A, \
     TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('CLOUDXPZ')) as U  \
WHERE A.AUTHIDTYPE='G' AND A.AUTHID=P.AUTHID AND (U.GROUP=A.AUTHID)" ;

AUTHID     AUTHIDTYPE PRIVILEGE   OBJECTNAME                               OBJECTSCHEMA                             OBJECTTYPE
---------- ---------- ----------- ---------------------------------------- ---------------------------------------- ------------------------
DB2MONGP   G          SELECT      ACACGPDESC                               WSCOMUSR                                 TABLE
DB2MONGP   G          SELECT      ACACTACTGP                               WSCOMUSR                                 TABLE
DB2MONGP   G          SELECT      ACACTDESC                                WSCOMUSR                                 TABLE
DB2MONGP   G          SELECT      ACACTGRP                                 WSCOMUSR                                 TABLE
DB2MONGP   G          SELECT      ACACTION                                 WSCOMUSR                                 TABLE
DB2MONGP   G          SELECT      ACATTR                                   WSCOMUSR                                 TABLE
DB2MONGP   G          SELECT      ACATTRDESC                               WSCOMUSR                                 TABLE



To Check Direct/In-Direct Privileges, Including thru PUBLIC:
------------------------------------------------------------
db2 "SELECT DISTINCT SUBSTR(P.AUTHID,1,10) as AUTHID, P.AUTHIDTYPE, P.PRIVILEGE, SUBSTR(P.OBJECTNAME,1,40) as OBJECTNAME , SUBSTR(P.OBJECTSCHEMA,1,40) as OBJECTSCHEMA, P.OBJECTTYPE \
FROM SYSIBMADM.PRIVILEGES P,  \
     SYSIBMADM.AUTHORIZATIONIDS A, \
     TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('CLOUDXPZ')) as U  \
WHERE P.PRIVILEGE='EXECUTE' AND A.AUTHIDTYPE='G' AND A.AUTHID=P.AUTHID AND (U.GROUP=A.AUTHID OR A.AUTHID='PUBLIC')  AND P.OBJECTSCHEMA IN ('SYSPROC', 'SYSIBMADM', 'SYSIBM') \
UNION \
SELECT DISTINCT SUBSTR(P.AUTHID,1,10) as AUTHID, P.AUTHIDTYPE, P.PRIVILEGE, SUBSTR(P.OBJECTNAME,1,30) as OBJECTNAME, SUBSTR(P.OBJECTSCHEMA,1,30) as OBJECTSCHEMA, P.OBJECTTYPE \
FROM SYSIBMADM.PRIVILEGES P WHERE P.AUTHID='CLOUDXPZ' ORDER BY AUTHID" ;

AUTHID     AUTHIDTYPE PRIVILEGE   OBJECTNAME                               OBJECTSCHEMA                             OBJECTTYPE
---------- ---------- ----------- ---------------------------------------- ---------------------------------------- ------------------------
DB2MONGP   G          EXECUTE     ADMIN_GET_DBP_MEM_USAGE_AP               SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     ENV_GET_DB2_SYSTEM_RESOURCES             SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     ENV_GET_SYSTEM_RESOURCES                 SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_GET_ACTIVITY                         SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_GET_BUFFERPOOL                       SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_GET_DATABASE                         SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_GET_PKG_CACHE_STMT                   SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_GET_TABLESPACE                       SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_GET_TRANSACTION_LOG                  SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_SAMPLE_WORKLOAD_METRICS              SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     SNAP_GET_APPL                            SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     -                                        SYSPROC                                  FUNCTION
PUBLIC     G          EXECUTE     ADMIN_GET_CONTACTGROUPS                  SYSPROC                                  FUNCTION
PUBLIC     G          EXECUTE     ADMIN_GET_CONTACTS                       SYSPROC                                  FUNCTION
PUBLIC     G          EXECUTE     ADMIN_GET_DBP_MEM_USAGE                  SYSPROC                                  FUNCTION
PUBLIC     G          EXECUTE     ADMIN_GET_DBP_MEM_USAGE_AP               SYSPROC                                  FUNCTION


To Check Direct/In-Direct Privileges, Excluding PUBLIC:
------------------------------------------------------------

db2 "SELECT DISTINCT SUBSTR(P.AUTHID,1,10) as AUTHID, P.AUTHIDTYPE, P.PRIVILEGE, SUBSTR(P.OBJECTNAME,1,40) as OBJECTNAME , SUBSTR(P.OBJECTSCHEMA,1,40) as OBJECTSCHEMA, P.OBJECTTYPE \
FROM SYSIBMADM.PRIVILEGES P,  \
     SYSIBMADM.AUTHORIZATIONIDS A, \
     TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('CLOUDXPZ')) as U  \
WHERE P.PRIVILEGE='EXECUTE' AND A.AUTHIDTYPE='G' AND A.AUTHID=P.AUTHID AND (U.GROUP=A.AUTHID)  AND P.OBJECTSCHEMA IN ('SYSPROC', 'SYSIBMADM', 'SYSIBM') \
UNION \
SELECT DISTINCT SUBSTR(P.AUTHID,1,10) as AUTHID, P.AUTHIDTYPE, P.PRIVILEGE, SUBSTR(P.OBJECTNAME,1,30) as OBJECTNAME, SUBSTR(P.OBJECTSCHEMA,1,30) as OBJECTSCHEMA, P.OBJECTTYPE \
FROM SYSIBMADM.PRIVILEGES P WHERE P.AUTHID='CLOUDXPZ' ORDER BY AUTHID" ;


AUTHID     AUTHIDTYPE PRIVILEGE   OBJECTNAME                               OBJECTSCHEMA                             OBJECTTYPE
---------- ---------- ----------- ---------------------------------------- ---------------------------------------- ------------------------
DB2MONGP   G          EXECUTE     ADMIN_GET_DBP_MEM_USAGE_AP               SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     ENV_GET_DB2_SYSTEM_RESOURCES             SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     ENV_GET_SYSTEM_RESOURCES                 SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_GET_ACTIVITY                         SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_GET_BUFFERPOOL                       SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_GET_DATABASE                         SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_GET_PKG_CACHE_STMT                   SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_GET_TABLESPACE                       SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_GET_TRANSACTION_LOG                  SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     MON_SAMPLE_WORKLOAD_METRICS              SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     SNAP_GET_APPL                            SYSPROC                                  FUNCTION
DB2MONGP   G          EXECUTE     -                                        SYSPROC                                  FUNCTION

  12 record(s) selected.


*************************************************************************************************************************

db2 describe table sysibmadm.privileges

                                Data type                     Column
Column name                     schema    Data type name      Length     Scale Nulls
------------------------------- --------- ------------------- ---------- ----- ------
AUTHID                          SYSIBM    VARCHAR                    128     0 No
AUTHIDTYPE                      SYSIBM    CHARACTER                    1     0 No
PRIVILEGE                       SYSIBM    VARCHAR                     11     0 Yes
GRANTABLE                       SYSIBM    VARCHAR                      1     0 Yes
OBJECTNAME                      SYSIBM    VARCHAR                    128     0 Yes
OBJECTSCHEMA                    SYSIBM    VARCHAR                    128     0 No
OBJECTTYPE                      SYSIBM    VARCHAR                     24     0 Yes
PARENTOBJECTNAME                SYSIBM    VARCHAR                    128     0 No
PARENTOBJECTTYPE                SYSIBM    VARCHAR                      5     0 No

  9 record(s) selected.


SYSIBMADM.PRIVILEGES has privilege information about the following different types of database objects.
-------------------------------------------------------------------------------------------------------------
db2 "select distinct(objecttype) from sysibmadm.privileges"

OBJECTTYPE
------------------------
DB2 PACKAGE
FUNCTION
GLOBAL VARIABLE
INDEX
MODULE
NICKNAME
PROCEDURE
SCHEMA
SEQUENCE
TABLE
TABLESPACE
VIEW
WORKLOAD
XML OBJECT

  14 record(s) selected.


What privileges have been granted to this object? Eg. OBJECTNAME is APPLICATIONS, OBJECTSCHEMA is SYSIBMADM
-----------------------------------------------------------------------------

db2 "SELECT char(authid, 20) AS auth_id, \
       CASE authidtype \
           WHEN 'U' THEN 'USER' \
           WHEN 'G' THEN 'GROUP' \
           WHEN 'R' THEN 'ROLE' \
       END authidtype , \
       privilege \
FROM sysibmadm.privileges \
WHERE objectname = 'APPLICATIONS' \
  AND objectschema = 'SYSIBMADM' \
 ORDER BY authid, \
         authidtype, \
         privilege WITH ur" ;


AUTH_ID              AUTHIDTYPE PRIVILEGE
-------------------- ---------- -----------
BHATV                USER       SELECT
DB2MONGP             GROUP      SELECT
DEVDBGRP             GROUP      DELETE
DEVDBGRP             GROUP      INSERT
DEVDBGRP             GROUP      SELECT
DEVDBGRP             GROUP      UPDATE
DEVDBUSR             USER       DELETE
DEVDBUSR             USER       INSERT
DEVDBUSR             USER       SELECT
DEVDBUSR             USER       UPDATE
PUBLIC               GROUP      SELECT
ROYA                 USER       SELECT
THIMMAPA             USER       SELECT

  13 record(s) selected.



Which privileges have been granted to a role? Eg. here Role is DBACCESS
-------------------------------------------------------

db2 "SELECT char(objectschema,10) as OBJECTSCHEMA , \
       char(objectname,65) as OBJECTNAME, \
       char(privilege, 10) as privilege, \
       char(authid,30) as AUTHID, \
       char(authidtype,1) as AUTHIDTYPE, \
       objecttype \
FROM sysibmadm.privileges \
WHERE authid='DB2READ'  \
  AND authidtype='R' ORDER BY 1,2,3 WITH UR";


OBJECTSCHEMA OBJECTNAME                                                        PRIVILEGE  AUTHID                         AUTHIDTYPE OBJECTTYPE
------------ ----------------------------------------------------------------- ---------- ------------------------------ ---------- ------------------------
DB2INST1     TAB_LOCKING                                                       ALTER      DBACCESS                       R          TABLE
DB2INST1     TAB_LOCKING                                                       DELETE     DBACCESS                       R          TABLE
DB2INST1     TAB_LOCKING                                                       INSERT     DBACCESS                       R          TABLE
DB2INST1     TAB_LOCKING                                                       SELECT     DBACCESS                       R          TABLE
DB2INST1     TAB_LOCKING                                                       UPDATE     DBACCESS                       R          TABLE
DBA          EVMI_LOCKS                                                        ALTER      DBACCESS                       R          TABLE
DBA          EVMI_LOCKS                                                        DELETE     DBACCESS                       R          TABLE
DBA          EVMI_LOCKS                                                        INSERT     DBACCESS                       R          TABLE
DBA          EVMI_LOCKS                                                        SELECT     DBACCESS                       R          TABLE
DBA          EVMI_LOCKS                                                        UPDATE     DBACCESS                       R          TABLE
EVMIDB       ADVISE_INSTANCE                                                   ALTER      DBACCESS                       R          TABLE
EVMIDB       ADVISE_INSTANCE                                                   DELETE     DBACCESS                       R          TABLE
EVMIDB       ADVISE_INSTANCE                                                   INSERT     DBACCESS                       R          TABLE
EVMIDB       ADVISE_INSTANCE                                                   SELECT     DBACCESS                       R          TABLE
EVMIDB       ADVISE_INSTANCE                                                   UPDATE     DBACCESS                       R          TABLE
EVMIDB       AUDIT                                                             ALTER      DBACCESS                       R          TABLE
EVMIDB       AUDIT                                                             DELETE     DBACCESS                       R          TABLE
EVMIDB       AUDIT                                                             INSERT     DBACCESS                       R          TABLE
EVMIDB       AUDIT                                                             SELECT     DBACCESS                       R          TABLE
EVMIDB       AUDIT                                                             UPDATE     DBACCESS                       R          TABLE


Which privileges have been granted to a user? Eg. User is 'CLOUDXPZ'
----------------------------------------------------

db2 "SELECT char(objectschema,10) AS OBJECTSCHEMA , \
       char(objectname,65) as OBJECTNAME, \
       char(privilege, 15) as privilege, \
       char(authid,30) as AUTHID, \
       char(authidtype,1) as AUTHIDTYPE, \
       objecttype \
FROM sysibmadm.privileges \
WHERE authid='CLOUDXPZ' \
  AND authidtype='U' \
ORDER BY 1,2,3 WITH UR" ; 

OBJECTSCHEMA OBJECTNAME                                                        PRIVILEGE       AUTHID                         AUTHIDTYPE OBJECTTYPE
------------ ----------------------------------------------------------------- --------------- ------------------------------ ---------- ------------------------

  0 record(s) selected.

