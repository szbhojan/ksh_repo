while IFS= read -r line       \
do \
if [[ - a $line ]] then  \
   echo "The Script file $line exists in this server `hostname`"  \
else \
   echo "\nMissing script file $line, in this server `hostname`"  
fi;
done < cron_script_files_list_from_server_SRVATLDB04V.txt \

while IFS= read -r line; do if [[ - a $line ]] then echo "True\n" else echo "Missing $line \n" fi; done < cron_script_files_list_from_server_SRVATLDB04V.txt
cat trig.list |while read t; do db2 connect to dbname; db2 -v "drop trigger schema.$t"; db2 connect reset; done >trig_drops.out

/bin/mailx -r db2inst1.srvhqdb04v@mscdirect.com -s "WSCOMUSR.XORDER_STATUS_XCP_DELETE_JOB_SP PreValidation Count : ${preResult}"  ${mailList} < /tmp/deleteXCPorderJob.out


AUDIT
BLNKTPO
CI_AISLE
CI_BATCH
CI_BATCH_ITEMS
CI_BATCH_UPLOAD
CI_BIN_TEMPLATE
CI_CABINET
CI_CIMLBATCHHDR
CI_FAVOURITE_BATCHES
CI_PAITEMS
CI_PREDEFINEDLIST
CI_PREDEFINEDLIST_ITEMS
CI_PUTAWAY
CI_SECTION
CI_STOCKLOC
CI_XBATCHUPLOAD
COMMENTS
COMPETITORS
CONFIG
CROSITLITEDTLS
CROSITLITEHDR
ERRINFO
INCLUSION_TYPE_MASTER
ITEMLBL
ITEMLBL_AUDIT
ITEMSTS
LBLFORMAT
LBLSTAGING
LINEDISTRCODE
MDLINFO
NOTIFICATIONHISTRY
ORDDTLS
ORDHDR
ORDHDR_ERROR_EXTENSION
ORDLBLDETAILS
ORDLBLHDR
ORDSTS
ORDTYPE
PURGEINFO
RUNTABLE
STCKLOC
STCKLOCSTAGING
TEMPITEMS
UPLOAD_DETAILS
UPLOAD_HEADER
UPLOADHDRSTS
USER_ROLES
USERS
VIRTUAL_LOC
WEBCONTACT
WEBCONTACT_AUDIT
WEBORDTYPE

db2 "select TABSCHEMA, TABNAME, TYPE, STATUS, CREATE_TIME from syscat.tables where type='T' and status = 'N' and tabschema='WSCOMUSR' and tabname not like 'SYS%'" ;

db2 "select TABSCHEMA, TABNAME, count(*(from syscat.tables where type='T' and status = 'N' and tabschema='WSCOMUSR' and tabname not like 'SYS%'" ;
db2 "select count(*) as number_of_tables from syscat.tables where type='T' and status = 'N' and tabschema='WSCOMUSR' and tabname not like 'SYS%'" ;
db2 "select count(*) as number_of_tables from syscat.tables where type='T' and status = 'N' and tabschema='WSCOMUSR'" ;
db2 "select count(*) as number_of_tables from syscat.tables where type='T' and status <> 'N' and tabschema='WSCOMUSR'" ;



db2 "SELECT SUBSTR(AUTHORITY,1,30) AS AUTHORITY, D_USER, D_GROUP, D_PUBLIC, ROLE_USER, ROLE_GROUP, ROLE_PUBLIC, D_ROLE   FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('CLOUDXPZ', 'U') ) AS T  ORDER BY AUTHORITY" ;


db2inst1@srvatldb04v:/db2home/db2inst1>db2 describe table syscat.dbauth

                                Data type                     Column
Column name                     schema    Data type name      Length     Scale Nulls
------------------------------- --------- ------------------- ---------- ----- ------
GRANTOR                         SYSIBM    VARCHAR                    128     0 No
GRANTORTYPE                     SYSIBM    CHARACTER                    1     0 No
GRANTEE                         SYSIBM    VARCHAR                    128     0 No
GRANTEETYPE                     SYSIBM    CHARACTER                    1     0 No
BINDADDAUTH                     SYSIBM    CHARACTER                    1     0 No
CONNECTAUTH                     SYSIBM    CHARACTER                    1     0 No
CREATETABAUTH                   SYSIBM    CHARACTER                    1     0 No
DBADMAUTH                       SYSIBM    CHARACTER                    1     0 No
EXTERNALROUTINEAUTH             SYSIBM    CHARACTER                    1     0 No
IMPLSCHEMAAUTH                  SYSIBM    CHARACTER                    1     0 No
LOADAUTH                        SYSIBM    CHARACTER                    1     0 No
NOFENCEAUTH                     SYSIBM    CHARACTER                    1     0 No
QUIESCECONNECTAUTH              SYSIBM    CHARACTER                    1     0 No
LIBRARYADMAUTH                  SYSIBM    CHARACTER                    1     0 No
SECURITYADMAUTH                 SYSIBM    CHARACTER                    1     0 No
SQLADMAUTH                      SYSIBM    CHARACTER                    1     0 No
WLMADMAUTH                      SYSIBM    CHARACTER                    1     0 No
EXPLAINAUTH                     SYSIBM    CHARACTER                    1     0 No
DATAACCESSAUTH                  SYSIBM    CHARACTER                    1     0 No
ACCESSCTRLAUTH                  SYSIBM    CHARACTER                    1     0 No
CREATESECUREAUTH                SYSIBM    CHARACTER                    1     0 No

  21 record(s) selected.


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
from  syscat.dbauth order by grantee" ;




db2 "select * from TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('CLOUDXPZ', 'U') ) AS T  ORDER BY AUTHORITY" ;

-----------------------------------------

List of Roles:
--------------

db2 "SELECT SUBSTR(GRANTOR,1,10) as GRANTOR, GRANTEETYPE, SUBSTR(GRANTEE,1,10) as GRANTEE, GRANTORTYPE, SUBSTR(ROLENAME,1,15) as ROLENAME, CREATE_TIME, ADMIN FROM TABLE (SYSPROC.AUTH_LIST_ROLES_FOR_AUTHID ('PUBLIC', 'G') ) AS T" ;

GRANTOR    GRANTEETYPE GRANTEE    GRANTORTYPE ROLENAME        CREATE_TIME                ADMIN
---------- ----------- ---------- ----------- --------------- -------------------------- -----
SYSIBM     G           PUBLIC     S           SYSTS_USR       2017-01-28-00.47.27.143675 N

  1 record(s) selected.


db2 "SELECT SUBSTR(GRANTOR,1,10) as GRANTOR, GRANTEETYPE, SUBSTR(GRANTEE,1,10) as GRANTEE, GRANTORTYPE, SUBSTR(ROLENAME,1,15) as ROLENAME, CREATE_TIME, ADMIN FROM TABLE (SYSPROC.AUTH_LIST_ROLES_FOR_AUTHID ('SYSTS_USR', 'R') ) AS T" ;

GRANTOR    GRANTEETYPE GRANTEE    GRANTORTYPE ROLENAME        CREATE_TIME                ADMIN
---------- ----------- ---------- ----------- --------------- -------------------------- -----

  0 record(s) selected.


Retrieve List of Authorities for a Particular User:
---------------------------------------------------

db2inst1@srvatldb04v:/db2home/db2inst1>db2 "SELECT AUTHORITY, D_USER, D_GROUP, D_PUBLIC, ROLE_USER, ROLE_GROUP, ROLE_PUBLIC, D_ROLE   FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('CLOUDXPZ', 'U') ) AS T  ORDER BY AUTHORITY" ;

AUTHORITY                                                                                                                        D_USER D_GROUP D_PUBLIC ROLE_USER ROLE_GROUP ROLE_PUBLIC D_ROLE
-------------------------------------------------------------------------------------------------------------------------------- ------ ------- -------- --------- ---------- ----------- ------
ACCESSCTRL                                                                                                                       N      N       N        N         N          N           *
BINDADD                                                                                                                          N      N       N        N         N          N           *
CONNECT                                                                                                                          N      Y       N        N         N          N           *
CREATETAB                                                                                                                        N      N       N        N         N          N           *
CREATE_EXTERNAL_ROUTINE                                                                                                          N      N       N        N         N          N           *
CREATE_NOT_FENCED_ROUTINE                                                                                                        N      N       N        N         N          N           *
CREATE_SECURE_OBJECT                                                                                                             N      N       N        N         N          N           *
DATAACCESS                                                                                                                       N      N       N        N         N          N           *
DBADM                                                                                                                            N      N       N        N         N          N           *
EXPLAIN                                                                                                                          N      N       N        N         N          N           *
IMPLICIT_SCHEMA                                                                                                                  N      N       N        N         N          N           *
LOAD                                                                                                                             N      N       N        N         N          N           *
QUIESCE_CONNECT                                                                                                                  N      N       N        N         N          N           *
SECADM                                                                                                                           N      N       N        N         N          N           *
SQLADM                                                                                                                           N      N       N        N         N          N           *
SYSADM                                                                                                                           *      N       *        *         *          *           *
SYSCTRL                                                                                                                          *      N       *        *         *          *           *
SYSMAINT                                                                                                                         *      N       *        *         *          *           *
SYSMON                                                                                                                           *      Y       *        *         *          *           *
WLMADM                                                                                                                           N      N       N        N         N          N           *

  20 record(s) selected.



db2inst1@srvatldb04v:/db2home/db2inst1>db2 "select \
> char(grantee,20) as grantee, \
> char(granteetype,1) as granteetype, \
> char(grantor,20) as grantor, \
> char(grantortype,1) as grantortype, \
> char(dbadmauth,1) as dbadm,  \
> char(createtabauth,1) as createtab,  \
> char(bindaddauth,1) as bindadd,  \
> char(connectauth,1) as connect,  \
> char(nofenceauth,1) as nofence,  \
> char(implschemaauth,1) as implschema,  \
> char(loadauth,1) as load,  \
> char(externalroutineauth,1) as extroutine,  \
> char(quiesceconnectauth,1) as quiesceconn,  \
> char(dataaccessauth,1) as dataaccess, \
> char(libraryadmauth,1) as libadm, \
> char(securityadmauth,1) as securityadm, \
> char(sqladmauth,1) as sqladm, \
> char(wlmadmauth,1) as wlmadm, \
> char(explainauth,1) as explain, \
> char(accessctrlauth,1) as accessctrl, \
> char(createsecureauth,1) as createsecure \
> from  syscat.dbauth order by grantee" ;

GRANTEE              GRANTEETYPE GRANTOR              GRANTORTYPE DBADM CREATETAB BINDADD CONNECT NOFENCE IMPLSCHEMA LOAD EXTROUTINE QUIESCECONN DATAACCESS LIBADM SECURITYADM SQLADM WLMADM EXPLAIN ACCESSCTRL CREATESECURE
-------------------- ----------- -------------------- ----------- ----- --------- ------- ------- ------- ---------- ---- ---------- ----------- ---------- ------ ----------- ------ ------ ------- ---------- ------------
CLOUDXPZ             U           DB2INST1             U           N     N         N       Y       N       N          N    N          N           Y          N      N           N      N      N       N          N
DB2INST1             U           SYSIBM               S           Y     N         N       N       N       N          N    N          N           Y          N      Y           N      N      N       Y          N
DB2MONGP             G           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
DB2READ              U           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
DB2READ              G           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
DESAIN               U           DB2INST1             U           Y     N         N       N       N       N          N    N          N           Y          N      N           N      N      N       Y          N
DEVDBGRP             G           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
DEVDBUSR             U           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
DTLDUSR              U           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
MUMESH               U           DB2INST1             U           Y     N         N       N       N       N          N    N          N           Y          N      N           N      N      N       Y          N
OMTUSR               U           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
POUTREAD             R           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
ROYA                 U           DB2INST1             U           Y     N         N       N       N       N          N    N          N           Y          N      N           N      N      N       Y          N
STGDBUSR             U           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
SUNDARAS02           U           DB2INST1             U           Y     N         N       N       N       N          N    N          N           Y          N      N           N      N      N       Y          N
VDBAMON              U           DB2INST1             U           N     N         N       N       N       Y          N    N          N           Y          N      N           N      N      N       N          N
WCSGCPUSR            U           DB2INST1             U           N     N         N       Y       N       N          N    N          N           Y          N      N           N      N      N       N          N
WSAUDGRP             G           DB2INST1             U           N     N         N       Y       N       N          N    N          N           N          N      N           N      N      N       N          N
WSCOMUSR             U           DB2INST1             U           N     N         N       Y       N       N          N    N          N           Y          N      N           N      N      N       Y          N
WSPOUT               U           DB2INST1             U           N     N         N       N       N       N          N    N          N           Y          N      N           N      N      N       N          N

  20 record(s) selected.



Example 1: Retrieve all roles granted to user CLOUDXPZ.
---------------------------------------------------------

db2 "SELECT SUBSTR(GRANTOR,1,10) as GRANTOR, GRANTEETYPE, SUBSTR(GRANTEE,1,10) as GRANTEE, GRANTORTYPE, \
SUBSTR(ROLENAME,1,15) as ROLENAME, CREATE_TIME, ADMIN FROM TABLE (SYSPROC.AUTH_LIST_ROLES_FOR_AUTHID ('CLOUDXPZ', 'U') ) AS T" ;

GRANTOR    GRANTEETYPE GRANTEE    GRANTORTYPE ROLENAME        CREATE_TIME                ADMIN
---------- ----------- ---------- ----------- --------------- -------------------------- -----
SYSIBM     G           PUBLIC     S           SYSTS_USR       2017-01-28-00.47.27.143675 N

  1 record(s) selected.

db2 "SELECT SUBSTR(GRANTOR,1,10) as GRANTOR, GRANTEETYPE, SUBSTR(GRANTEE,1,10) as GRANTEE, GRANTORTYPE, \
SUBSTR(ROLENAME,1,15) as ROLENAME, CREATE_TIME, ADMIN FROM TABLE (SYSPROC.AUTH_LIST_ROLES_FOR_AUTHID ('DB2MONGP', 'G') ) AS T" ;



Example 2: The AUTHORIZATIONIDS administrative view returns a list of all the users, roles, and groups that exist in the database catalog of the currently connected server as a result of GRANT statements.

db2 "SELECT * FROM SYSIBMADM.AUTHORIZATIONIDS ORDER BY AUTHIDTYPE" ;


AUTHID                                                                                                                           AUTHIDTYPE
-------------------------------------------------------------------------------------------------------------------------------- ----------
DB2MONGP                                                                                                                         G
DB2READ                                                                                                                          G
DEVDBGRP                                                                                                                         G
PUBLIC                                                                                                                           G
WSAUDGRP                                                                                                                         G
POUTREAD                                                                                                                         R
SYSDEBUG                                                                                                                         R
SYSDEBUGPRIVATE                                                                                                                  R
SYSTS_ADM                                                                                                                        R
SYSTS_MGR                                                                                                                        R
UPD_ORDERS                                                                                                                       R
SYSIBM                                                                                                                           S
AMBEPUJ                                                                                                                          U
ANDREWJ                                                                                                                          U
BHADRAS                                                                                                                          U
BHATV                                                                                                                            U
BISWASS01                                                                                                                        U
CLOUDXPZ                                                                                                                         U
DB2INST1                                                                                                                         U
DB2READ                                                                                                                          U
DESAIN                                                                                                                           U
DEVANV                                                                                                                           U
DEVDBGRP                                                                                                                         U
DEVDBUSR                                                                                                                         U
DTLDUSR                                                                                                                          U
FENTYW                                                                                                                           U
GALLMEIT                                                                                                                         U
KAMATHA                                                                                                                          U
KOLLIPAA                                                                                                                         U
MEEJURUR                                                                                                                         U
MUMESH                                                                                                                           U
OMTUSR                                                                                                                           U
REDDIPAS                                                                                                                         U
ROYA                                                                                                                             U
SANKARAV                                                                                                                         U
SANKATRV                                                                                                                         U
SG                                                                                                                               U
SHANBHAA                                                                                                                         U
STGDBUSR                                                                                                                         U
SUNDARAS02                                                                                                                       U
VARMAD01                                                                                                                         U
VDBAMON                                                                                                                          U
WCSDBGCPUSER                                                                                                                     U
WCSGCPUSR                                                                                                                        U
WSAUDGRP                                                                                                                         U
WSCOMUSR                                                                                                                         U
WSPOUT                                                                                                                           U
ZBKUMM01                                                                                                                         U
ZRAHMANM                                                                                                                         U

  49 record(s) selected.


Retrieve All the Groups where the User Belongs:
------------------------------------------------

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('CLOUDXPZ')) AS T" ;


GROUP
--------------------------------------------------------------------------------------------------------------------------------
DB2MONGP
STAFF

  2 record(s) selected.



db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('ROYA')) AS T" ;

GROUP
--------------------------------------------------------------------------------------------------------------------------------
DB2READ
MINDTREE
STAFF

  3 record(s) selected.



db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('DB2INST1 ')) AS T" ;
GROUP
--------------------------------------------------------------------------------------------------------------------------------
DB2IADM1
STAFF

  2 record(s) selected.

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('WCSGCPUSR')) AS T" ;

GROUP
--------------------------------------------------------------------------------------------------------------------------------
DB2IADM1
DB2READ
STAFF

  3 record(s) selected.

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('WCSDBGCPUSER')) AS T" ;

GROUP
--------------------------------------------------------------------------------------------------------------------------------
STAFF

  1 record(s) selected.

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('WSCOMUSR')) AS T" ;

GROUP
--------------------------------------------------------------------------------------------------------------------------------
DB2IADM1
STAFF

  2 record(s) selected.


Retrieve List of ROLES:
----------------------------

db2 "SELECT SUBSTR(GRANTOR,1,30) as GRANTOR, GRANTORTYPE, GRANTORROLEID,  SUBSTR(GRANTEE,1,30) as GRANTEE, GRANTEETYPE, GRANTEEROLEID, \
SUBSTR(ROLENAME,1,30) as ROLENAME, ROLEID, ADMIN FROM SYSIBM.SYSROLEAUTH ORDER BY ROLENAME";

GRANTOR                        GRANTORTYPE GRANTORROLEID GRANTEE                        GRANTEETYPE GRANTEEROLEID ROLENAME                       ROLEID      ADMIN
------------------------------ ----------- ------------- ------------------------------ ----------- ------------- ------------------------------ ----------- -----
DB2INST1                       U                       - CROSSITUSR                     U                       - CROSSITROLE                           1001 N
DB2INST1                       U                       - LOFASOJ                        U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - SANKARAV                       U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - LEARYT                         U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - WCSGCPUSR                      U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - TUMMANAH                       U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - DAMANIAR                       U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - KHANA01                        U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - MEHERA                         U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - MEIZLISS                       U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - SINGHS04                       U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - MWATCHDB                       U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - AN                             U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - TAYALA                         U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - KAMATHA                        U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - REDDYM                         U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - KAURB                          U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - NAVPUTES                       U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - SAHANAA                        U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - RACHARLV                       U                       - DB2RDEVMI                             1000 N
DB2INST1                       U                       - PANDLAP                        U                       - DB2RDEVMI                             1000 N
SYSIBM                         S                       - DB2INST1                       U                       - SYSROLE_AUTH_DBADM                       1 N
SYSIBM                         S                       - SYSROLE_AUTH_SQLADM            R                       4 SYSROLE_AUTH_EXPLAIN                     2 N
SYSIBM                         S                       - DB2INST1                       U                       - SYSROLE_AUTH_SECADM                      3 N
SYSIBM                         S                       - SYSROLE_AUTH_DBADM             R                       1 SYSROLE_AUTH_SQLADM                      4 N
SYSIBM                         S                       - SYSROLE_AUTH_DBADM             R                       1 SYSROLE_AUTH_WLMADM                      5 N
SYSIBM                         S                       - DB2INST1                       U                       - SYSTS_ADM                                8 N
SYSIBM                         S                       - DB2INST1                       U                       - SYSTS_MGR                                9 N
SYSIBM                         S                       - PUBLIC                         G                       - SYSTS_USR                               10 N

  29 record(s) selected.



Retreive List of Authorities the any particular Authorization ID has :
-----------------------------------------------------------------------

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('ROYA', 'U') ) AS T ORDER BY AUTHORITY" ;


AUTHORITY                                                                                                                        D_USER D_GROUP D_PUBLIC ROLE_USER ROLE_GROUP ROLE_PUBLIC D_ROLE
-------------------------------------------------------------------------------------------------------------------------------- ------ ------- -------- --------- ---------- ----------- ------
ACCESSCTRL                                                                                                                       Y      N       N        N         N          N           *
BINDADD                                                                                                                          N      N       N        N         N          N           *
CONNECT                                                                                                                          N      Y       N        Y         N          N           *
CREATETAB                                                                                                                        N      N       N        N         N          N           *
CREATE_EXTERNAL_ROUTINE                                                                                                          N      N       N        N         N          N           *
CREATE_NOT_FENCED_ROUTINE                                                                                                        N      N       N        N         N          N           *
CREATE_SECURE_OBJECT                                                                                                             N      N       N        N         N          N           *
DATAACCESS                                                                                                                       Y      N       N        N         N          N           *
DBADM                                                                                                                            Y      N       N        N         N          N           *
EXPLAIN                                                                                                                          N      N       N        N         N          N           *
IMPLICIT_SCHEMA                                                                                                                  N      N       N        N         N          N           *
LOAD                                                                                                                             N      N       N        N         N          N           *
QUIESCE_CONNECT                                                                                                                  N      N       N        N         N          N           *
SECADM                                                                                                                           N      N       N        N         N          N           *
SQLADM                                                                                                                           N      N       N        N         N          N           *
SYSADM                                                                                                                           *      N       *        *         *          *           *
SYSCTRL                                                                                                                          *      N       *        *         *          *           *
SYSMAINT                                                                                                                         *      N       *        *         *          *           *
SYSMON                                                                                                                           *      N       *        *         *          *           *
WLMADM                                                                                                                           N      N       N        N         N          N           *

  20 record(s) selected.


db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('DB2READ', 'G') ) AS T ORDER BY AUTHORITY" ;

AUTHORITY                                                                                                                        D_USER D_GROUP D_PUBLIC ROLE_USER ROLE_GROUP ROLE_PUBLIC D_ROLE
-------------------------------------------------------------------------------------------------------------------------------- ------ ------- -------- --------- ---------- ----------- ------
ACCESSCTRL                                                                                                                       *      N       *        *         N          *           *
BINDADD                                                                                                                          *      N       *        *         N          *           *
CONNECT                                                                                                                          *      Y       *        *         N          *           *
CREATETAB                                                                                                                        *      N       *        *         N          *           *
CREATE_EXTERNAL_ROUTINE                                                                                                          *      N       *        *         N          *           *
CREATE_NOT_FENCED_ROUTINE                                                                                                        *      N       *        *         N          *           *
CREATE_SECURE_OBJECT                                                                                                             *      N       *        *         N          *           *
DATAACCESS                                                                                                                       *      N       *        *         N          *           *
DBADM                                                                                                                            *      N       *        *         N          *           *
EXPLAIN                                                                                                                          *      N       *        *         N          *           *
IMPLICIT_SCHEMA                                                                                                                  *      N       *        *         N          *           *
LOAD                                                                                                                             *      N       *        *         N          *           *
QUIESCE_CONNECT                                                                                                                  *      N       *        *         N          *           *
SECADM                                                                                                                           *      N       *        *         N          *           *
SQLADM                                                                                                                           *      N       *        *         N          *           *
SYSADM                                                                                                                           *      N       *        *         *          *           *
SYSCTRL                                                                                                                          *      N       *        *         *          *           *
SYSMAINT                                                                                                                         *      N       *        *         *          *           *
SYSMON                                                                                                                           *      N       *        *         *          *           *
WLMADM                                                                                                                           *      N       *        *         N          *           *

  20 record(s) selected.




db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('CLOUDXPZ', 'U') ) AS T ORDER BY AUTHORITY" ;

AUTHORITY                                                                                                                        D_USER D_GROUP D_PUBLIC ROLE_USER ROLE_GROUP ROLE_PUBLIC D_ROLE
-------------------------------------------------------------------------------------------------------------------------------- ------ ------- -------- --------- ---------- ----------- ------
ACCESSCTRL                                                                                                                       N      N       N        N         N          N           *
BINDADD                                                                                                                          N      N       N        N         N          N           *
CONNECT                                                                                                                          Y      Y       N        N         N          N           *
CREATETAB                                                                                                                        N      N       N        N         N          N           *
CREATE_EXTERNAL_ROUTINE                                                                                                          N      N       N        N         N          N           *
CREATE_NOT_FENCED_ROUTINE                                                                                                        N      N       N        N         N          N           *
CREATE_SECURE_OBJECT                                                                                                             N      N       N        N         N          N           *
DATAACCESS                                                                                                                       Y      N       N        N         N          N           *
DBADM                                                                                                                            N      N       N        N         N          N           *
EXPLAIN                                                                                                                          N      N       N        N         N          N           *
IMPLICIT_SCHEMA                                                                                                                  N      N       N        N         N          N           *
LOAD                                                                                                                             N      N       N        N         N          N           *
QUIESCE_CONNECT                                                                                                                  N      N       N        N         N          N           *
SECADM                                                                                                                           N      N       N        N         N          N           *
SQLADM                                                                                                                           N      N       N        N         N          N           *
SYSADM                                                                                                                           *      N       *        *         *          *           *
SYSCTRL                                                                                                                          *      N       *        *         *          *           *
SYSMAINT                                                                                                                         *      N       *        *         *          *           *
SYSMON                                                                                                                           *      Y       *        *         *          *           *
WLMADM                                                                                                                           N      N       N        N         N          N           *

  20 record(s) selected.


db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('STAFF', 'G') ) AS T ORDER BY AUTHORITY" ;

AUTHORITY                                                                                                                        D_USER D_GROUP D_PUBLIC ROLE_USER ROLE_GROUP ROLE_PUBLIC D_ROLE
-------------------------------------------------------------------------------------------------------------------------------- ------ ------- -------- --------- ---------- ----------- ------
ACCESSCTRL                                                                                                                       *      N       *        *         N          *           *
BINDADD                                                                                                                          *      N       *        *         N          *           *
CONNECT                                                                                                                          *      N       *        *         N          *           *
CREATETAB                                                                                                                        *      N       *        *         N          *           *
CREATE_EXTERNAL_ROUTINE                                                                                                          *      N       *        *         N          *           *
CREATE_NOT_FENCED_ROUTINE                                                                                                        *      N       *        *         N          *           *
CREATE_SECURE_OBJECT                                                                                                             *      N       *        *         N          *           *
DATAACCESS                                                                                                                       *      N       *        *         N          *           *
DBADM                                                                                                                            *      N       *        *         N          *           *
EXPLAIN                                                                                                                          *      N       *        *         N          *           *
IMPLICIT_SCHEMA                                                                                                                  *      N       *        *         N          *           *
LOAD                                                                                                                             *      N       *        *         N          *           *
QUIESCE_CONNECT                                                                                                                  *      N       *        *         N          *           *
SECADM                                                                                                                           *      N       *        *         N          *           *
SQLADM                                                                                                                           *      N       *        *         N          *           *
SYSADM                                                                                                                           *      N       *        *         *          *           *
SYSCTRL                                                                                                                          *      N       *        *         *          *           *
SYSMAINT                                                                                                                         *      N       *        *         *          *           *
SYSMON                                                                                                                           *      N       *        *         *          *           *
WLMADM                                                                                                                           *      N       *        *         N          *           *

  20 record(s) selected.


db2 "SELECT SUBSTR(GRANTOR,1,10) as GRANTOR, GRANTEETYPE, SUBSTR(GRANTEE,1,10) as GRANTEE, GRANTORTYPE, \
SUBSTR(ROLENAME,1,15) as ROLENAME, CREATE_TIME, ADMIN FROM TABLE (SYSPROC.AUTH_LIST_ROLES_FOR_AUTHID ('DB2INST1', 'G') ) AS T" ;



To get list of all IDs that have system or database authorities:
----------------------------------------------------------------

db2 "SELECT SUBSTR(AUTHID,1,30) as AUTHID, AUTHIDTYPE FROM SYSIBMADM.AUTHORIZATIONIDS" ;

AUTHID                         AUTHIDTYPE
------------------------------ ----------
DB2READ                        G
PUBLIC                         G
CROSSITROLE                    R
DB2RDEVMI                      R
SYSDEBUG                       R
SYSDEBUGPRIVATE                R
SYSTS_ADM                      R
SYSTS_MGR                      R
AN                             U
CLOUDXPZ                       U
CROSSITUSR                     U
DAMANIAR                       U
DB2INST1                       U
DB2RDEVMI                      U
EVMIAPP                        U
KAMATHA                        U
KAURB                          U
KHANA01                        U
LEARYT                         U
LOFASOJ                        U
MEHERA                         U
MEIZLISS                       U
MWATCHDB                       U
NAVPUTES                       U
PANDLAP                        U
RACHARLV                       U
REDDYM                         U
SAHANAA                        U
SANKARAV                       U
SINGHS04                       U
TAYALA                         U
TUMMANAH                       U
WCSGCPUSR                      U
ZJAYAPRK                       U

  34 record(s) selected.


To Get all the Authorities for any of the above or all the Authorization IDs at both System and Database Level using the below table function:
------------------------------------------------------------------------------------------------------------------------------------------------
Checking for PUBLIC Group:
---------------------------

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('PUBLIC', 'G') ) AS T ORDER BY AUTHORITY" ; 

AUTHORITY                                                                                                                        D_USER D_GROUP D_PUBLIC ROLE_USER ROLE_GROUP ROLE_PUBLIC D_ROLE
-------------------------------------------------------------------------------------------------------------------------------- ------ ------- -------- --------- ---------- ----------- ------
ACCESSCTRL                                                                                                                       *      *       N        *         *          N           *
BINDADD                                                                                                                          *      *       N        *         *          N           *
CONNECT                                                                                                                          *      *       N        *         *          N           *
CREATE_EXTERNAL_ROUTINE                                                                                                          *      *       N        *         *          N           *
CREATE_NOT_FENCED_ROUTINE                                                                                                        *      *       N        *         *          N           *
CREATE_SECURE_OBJECT                                                                                                             *      *       N        *         *          N           *
CREATETAB                                                                                                                        *      *       N        *         *          N           *
DATAACCESS                                                                                                                       *      *       N        *         *          N           *
DBADM                                                                                                                            *      *       N        *         *          N           *
EXPLAIN                                                                                                                          *      *       N        *         *          N           *
IMPLICIT_SCHEMA                                                                                                                  *      *       N        *         *          N           *
LOAD                                                                                                                             *      *       N        *         *          N           *
QUIESCE_CONNECT                                                                                                                  *      *       N        *         *          N           *
SECADM                                                                                                                           *      *       N        *         *          N           *
SQLADM                                                                                                                           *      *       N        *         *          N           *
SYSADM                                                                                                                           *      *       *        *         *          *           *
SYSCTRL                                                                                                                          *      *       *        *         *          *           *
SYSMAINT                                                                                                                         *      *       *        *         *          *           *
SYSMON                                                                                                                           *      *       *        *         *          *           *
WLMADM                                                                                                                           *      *       N        *         *          N           *

  20 record(s) selected.


Checking for CLOUDXPZ user:
---------------------------

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('CLOUDXPZ', 'U') ) AS T ORDER BY AUTHORITY" ;

AUTHORITY                                                                                                                        D_USER D_GROUP D_PUBLIC ROLE_USER ROLE_GROUP ROLE_PUBLIC D_ROLE
-------------------------------------------------------------------------------------------------------------------------------- ------ ------- -------- --------- ---------- ----------- ------
ACCESSCTRL                                                                                                                       N      N       N        N         N          N           *
BINDADD                                                                                                                          N      N       N        N         N          N           *
CONNECT                                                                                                                          Y      N       N        N         N          N           *
CREATE_EXTERNAL_ROUTINE                                                                                                          N      N       N        N         N          N           *
CREATE_NOT_FENCED_ROUTINE                                                                                                        N      N       N        N         N          N           *
CREATE_SECURE_OBJECT                                                                                                             N      N       N        N         N          N           *
CREATETAB                                                                                                                        N      N       N        N         N          N           *
DATAACCESS                                                                                                                       Y      N       N        N         N          N           *
DBADM                                                                                                                            N      N       N        N         N          N           *
EXPLAIN                                                                                                                          N      N       N        N         N          N           *
IMPLICIT_SCHEMA                                                                                                                  N      N       N        N         N          N           *
LOAD                                                                                                                             N      N       N        N         N          N           *
QUIESCE_CONNECT                                                                                                                  N      N       N        N         N          N           *
SECADM                                                                                                                           N      N       N        N         N          N           *
SQLADM                                                                                                                           N      N       N        N         N          N           *
SYSADM                                                                                                                           *      N       *        *         *          *           *
SYSCTRL                                                                                                                          *      N       *        *         *          *           *
SYSMAINT                                                                                                                         *      N       *        *         *          *           *
SYSMON                                                                                                                           *      Y       *        *         *          *           *
WLMADM                                                                                                                           N      N       N        N         N          N           *

  20 record(s) selected.



Checking for DB2INST1 user:
---------------------------

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('DB2INST1', 'U') ) AS T ORDER BY AUTHORITY" ;

AUTHORITY                                                                                                                        D_USER D_GROUP D_PUBLIC ROLE_USER ROLE_GROUP ROLE_PUBLIC D_ROLE
-------------------------------------------------------------------------------------------------------------------------------- ------ ------- -------- --------- ---------- ----------- ------
ACCESSCTRL                                                                                                                       Y      N       N        N         N          N           *
BINDADD                                                                                                                          N      N       N        N         N          N           *
CONNECT                                                                                                                          N      N       N        N         N          N           *
CREATE_EXTERNAL_ROUTINE                                                                                                          N      N       N        N         N          N           *
CREATE_NOT_FENCED_ROUTINE                                                                                                        N      N       N        N         N          N           *
CREATE_SECURE_OBJECT                                                                                                             N      N       N        N         N          N           *
CREATETAB                                                                                                                        N      N       N        N         N          N           *
DATAACCESS                                                                                                                       Y      N       N        N         N          N           *
DBADM                                                                                                                            Y      N       N        N         N          N           *
EXPLAIN                                                                                                                          N      N       N        N         N          N           *
IMPLICIT_SCHEMA                                                                                                                  N      N       N        N         N          N           *
LOAD                                                                                                                             N      N       N        N         N          N           *
QUIESCE_CONNECT                                                                                                                  N      N       N        N         N          N           *
SECADM                                                                                                                           Y      N       N        N         N          N           *
SQLADM                                                                                                                           N      N       N        N         N          N           *
SYSADM                                                                                                                           *      Y       *        *         *          *           *
SYSCTRL                                                                                                                          *      N       *        *         *          *           *
SYSMAINT                                                                                                                         *      N       *        *         *          *           *
SYSMON                                                                                                                           *      N       *        *         *          *           *
WLMADM                                                                                                                           N      N       N        N         N          N           *

  20 record(s) selected.


Checking for MWATCHDB user:
---------------------------

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('MWATCHDB', 'U') ) AS T ORDER BY AUTHORITY" ;


AUTHORITY                                                                                                                        D_USER D_GROUP D_PUBLIC ROLE_USER ROLE_GROUP ROLE_PUBLIC D_ROLE
-------------------------------------------------------------------------------------------------------------------------------- ------ ------- -------- --------- ---------- ----------- ------
ACCESSCTRL                                                                                                                       N      N       N        N         N          N           *
BINDADD                                                                                                                          N      N       N        N         N          N           *
CONNECT                                                                                                                          N      N       N        Y         N          N           *
CREATE_EXTERNAL_ROUTINE                                                                                                          N      N       N        N         N          N           *
CREATE_NOT_FENCED_ROUTINE                                                                                                        N      N       N        N         N          N           *
CREATE_SECURE_OBJECT                                                                                                             N      N       N        N         N          N           *
CREATETAB                                                                                                                        N      N       N        N         N          N           *
DATAACCESS                                                                                                                       N      N       N        N         N          N           *
DBADM                                                                                                                            N      N       N        N         N          N           *
EXPLAIN                                                                                                                          N      N       N        N         N          N           *
IMPLICIT_SCHEMA                                                                                                                  N      N       N        N         N          N           *
LOAD                                                                                                                             N      N       N        N         N          N           *
QUIESCE_CONNECT                                                                                                                  N      N       N        N         N          N           *
SECADM                                                                                                                           N      N       N        N         N          N           *
SQLADM                                                                                                                           N      N       N        N         N          N           *
SYSADM                                                                                                                           *      N       *        *         *          *           *
SYSCTRL                                                                                                                          *      N       *        *         *          *           *
SYSMAINT                                                                                                                         *      N       *        *         *          *           *
SYSMON                                                                                                                           *      Y       *        *         *          *           *
WLMADM                                                                                                                           N      N       N        N         N          N           *

  20 record(s) selected.




Checking for DB2IADM1 group:
---------------------------

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('DB2IADM1', 'G') ) AS T ORDER BY AUTHORITY" ;


AUTHORITY                                                                                                                        D_USER D_GROUP D_PUBLIC ROLE_USER ROLE_GROUP ROLE_PUBLIC D_ROLE
-------------------------------------------------------------------------------------------------------------------------------- ------ ------- -------- --------- ---------- ----------- ------
ACCESSCTRL                                                                                                                       *      N       *        *         N          *           *
BINDADD                                                                                                                          *      N       *        *         N          *           *
CONNECT                                                                                                                          *      N       *        *         N          *           *
CREATE_EXTERNAL_ROUTINE                                                                                                          *      N       *        *         N          *           *
CREATE_NOT_FENCED_ROUTINE                                                                                                        *      N       *        *         N          *           *
CREATE_SECURE_OBJECT                                                                                                             *      N       *        *         N          *           *
CREATETAB                                                                                                                        *      N       *        *         N          *           *
DATAACCESS                                                                                                                       *      N       *        *         N          *           *
DBADM                                                                                                                            *      N       *        *         N          *           *
EXPLAIN                                                                                                                          *      N       *        *         N          *           *
IMPLICIT_SCHEMA                                                                                                                  *      N       *        *         N          *           *
LOAD                                                                                                                             *      N       *        *         N          *           *
QUIESCE_CONNECT                                                                                                                  *      N       *        *         N          *           *
SECADM                                                                                                                           *      N       *        *         N          *           *
SQLADM                                                                                                                           *      N       *        *         N          *           *
SYSADM                                                                                                                           *      Y       *        *         *          *           *
SYSCTRL                                                                                                                          *      N       *        *         *          *           *
SYSMAINT                                                                                                                         *      N       *        *         *          *           *
SYSMON                                                                                                                           *      N       *        *         *          *           *
WLMADM                                                                                                                           *      N       *        *         N          *           *

  20 record(s) selected.


Checking for DB2MONGP group:
---------------------------

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('DB2MONGP', 'G') ) AS T ORDER BY AUTHORITY" ;

AUTHORITY                                                                                                                        D_USER D_GROUP D_PUBLIC ROLE_USER ROLE_GROUP ROLE_PUBLIC D_ROLE
-------------------------------------------------------------------------------------------------------------------------------- ------ ------- -------- --------- ---------- ----------- ------
ACCESSCTRL                                                                                                                       *      N       *        *         N          *           *
BINDADD                                                                                                                          *      N       *        *         N          *           *
CONNECT                                                                                                                          *      N       *        *         N          *           *
CREATE_EXTERNAL_ROUTINE                                                                                                          *      N       *        *         N          *           *
CREATE_NOT_FENCED_ROUTINE                                                                                                        *      N       *        *         N          *           *
CREATE_SECURE_OBJECT                                                                                                             *      N       *        *         N          *           *
CREATETAB                                                                                                                        *      N       *        *         N          *           *
DATAACCESS                                                                                                                       *      N       *        *         N          *           *
DBADM                                                                                                                            *      N       *        *         N          *           *
EXPLAIN                                                                                                                          *      N       *        *         N          *           *
IMPLICIT_SCHEMA                                                                                                                  *      N       *        *         N          *           *
LOAD                                                                                                                             *      N       *        *         N          *           *
QUIESCE_CONNECT                                                                                                                  *      N       *        *         N          *           *
SECADM                                                                                                                           *      N       *        *         N          *           *
SQLADM                                                                                                                           *      N       *        *         N          *           *
SYSADM                                                                                                                           *      N       *        *         *          *           *
SYSCTRL                                                                                                                          *      N       *        *         *          *           *
SYSMAINT                                                                                                                         *      N       *        *         *          *           *
SYSMON                                                                                                                           *      Y       *        *         *          *           *
WLMADM                                                                                                                           *      N       *        *         N          *           *

  20 record(s) selected.


Checking for DB2READ group:
---------------------------

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_AUTHORITIES_FOR_AUTHID ('DB2READ', 'G') ) AS T ORDER BY AUTHORITY" ;


AUTHORITY                                                                                                                        D_USER D_GROUP D_PUBLIC ROLE_USER ROLE_GROUP ROLE_PUBLIC D_ROLE
-------------------------------------------------------------------------------------------------------------------------------- ------ ------- -------- --------- ---------- ----------- ------
ACCESSCTRL                                                                                                                       *      N       *        *         N          *           *
BINDADD                                                                                                                          *      N       *        *         N          *           *
CONNECT                                                                                                                          *      N       *        *         N          *           *
CREATE_EXTERNAL_ROUTINE                                                                                                          *      N       *        *         N          *           *
CREATE_NOT_FENCED_ROUTINE                                                                                                        *      N       *        *         N          *           *
CREATE_SECURE_OBJECT                                                                                                             *      N       *        *         N          *           *
CREATETAB                                                                                                                        *      N       *        *         N          *           *
DATAACCESS                                                                                                                       *      N       *        *         N          *           *
DBADM                                                                                                                            *      N       *        *         N          *           *
EXPLAIN                                                                                                                          *      N       *        *         N          *           *
IMPLICIT_SCHEMA                                                                                                                  *      N       *        *         N          *           *
LOAD                                                                                                                             *      N       *        *         N          *           *
QUIESCE_CONNECT                                                                                                                  *      N       *        *         N          *           *
SECADM                                                                                                                           *      N       *        *         N          *           *
SQLADM                                                                                                                           *      N       *        *         N          *           *
SYSADM                                                                                                                           *      N       *        *         *          *           *
SYSCTRL                                                                                                                          *      N       *        *         *          *           *
SYSMAINT                                                                                                                         *      N       *        *         *          *           *
SYSMON                                                                                                                           *      N       *        *         *          *           *
WLMADM                                                                                                                           *      N       *        *         N          *           *

  20 record(s) selected.


***********************************************************************
Dev Environment
-------------------
db2 "select substr(AUTHORITY,1,30) as Authority, D_GROUP, D_PUBLIC from table(auth_list_authorities_for_authid('CLOUDXPZ','U'))" ;


db2 "select sum(case when d_group = 'Y' then 1 else 0 end) from  table(AUTH_LIST_AUTHORITIES_FOR_AUTHID(cast('CLOUDXPZ' as varchar(128)),'U')) where authority in ('SYSMON','SYSCTRL','SYSMAINT','SYSADM') ";

usermod -G db2mongp cloudxpz

db2 "CONNECT TO DB WCD01" ;
--db2 "GRANT CONNECT ON DATABASE TO USER CLOUDXPZ";
db2 "REVOKE CONNECT ON DATABASE FROM USER CLOUDXPZ" ;
db2 "GRANT CONNECT ON DATABASE TO GROUP DB2MONGP" ;

db2 "GRANT CONNECT, BINDADD, CREATETAB, IMPLICIT_SCHEMA ON DATABASE TO PUBLIC";

--db2 "GRANT ROLE DB2READ TO USER CLOUDXPZ"
--db2 "REVOKE ROLE DB2READ FROM USER CLOUDXPZ";

*******************************************************************

To get the List of Groups the User belongs:
--------------------------------------------

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('CLOUDXPZ')) AS T" ;

GROUP
--------------------------------------------------------------------------------------------------------------------------------
DB2MONGP
STAFF

  2 record(s) selected.


Checking for DB2INST1 User:
--------------------------

db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('DB2INST1')) AS T" ;

GROUP
--------------------------------------------------------------------------------------------------------------------------------
DB2IADM1
STAFF

  2 record(s) selected.

Checking for MWATCHDB User:
--------------------------
db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('MWATCHDB')) AS T" ;

GROUP
--------------------------------------------------------------------------------------------------------------------------------
DB2MONGP
STAFF

  2 record(s) selected.


Checking for MWATCHDB User:
--------------------------
db2 "SELECT * FROM TABLE (SYSPROC.AUTH_LIST_GROUPS_FOR_AUTHID('SINGHS04')) AS T" ;

GROUP
--------------------------------------------------------------------------------------------------------------------------------
DB2READ
STAFF

  2 record(s) selected.




To List all roles granted to user:
***********************************

db2 "SELECT SUBSTR(GRANTOR,1,10) as GRANTOR, GRANTEETYPE, SUBSTR(GRANTEE,1,10) as GRANTEE, GRANTORTYPE, \
SUBSTR(ROLENAME,1,15) as ROLENAME, CREATE_TIME, ADMIN FROM TABLE (SYSPROC.AUTH_LIST_ROLES_FOR_AUTHID ('CLOUDXPZ', 'U') ) AS T" ;

GRANTOR    GRANTEETYPE GRANTEE    GRANTORTYPE ROLENAME        CREATE_TIME                ADMIN
---------- ----------- ---------- ----------- --------------- -------------------------- -----
SYSIBM     G           PUBLIC     S           SYSTS_USR       2017-01-28-00.49.24.795580 N

  1 record(s) selected.



Checking for DB2INST1 User:
--------------------------

db2 "SELECT SUBSTR(GRANTOR,1,10) as GRANTOR, GRANTEETYPE, SUBSTR(GRANTEE,1,10) as GRANTEE, GRANTORTYPE, \
SUBSTR(ROLENAME,1,15) as ROLENAME, CREATE_TIME, ADMIN FROM TABLE (SYSPROC.AUTH_LIST_ROLES_FOR_AUTHID ('DB2INST1', 'U') ) AS T" ;


GRANTOR    GRANTEETYPE GRANTEE    GRANTORTYPE ROLENAME        CREATE_TIME                ADMIN
---------- ----------- ---------- ----------- --------------- -------------------------- -----
SYSIBM     U           DB2INST1   S           SYSTS_ADM       2017-01-28-00.49.24.795551 N
SYSIBM     U           DB2INST1   S           SYSTS_MGR       2017-01-28-00.49.24.795569 N
SYSIBM     G           PUBLIC     S           SYSTS_USR       2017-01-28-00.49.24.795580 N

  3 record(s) selected.


Checking for MWATCHDB User:
--------------------------
db2 "SELECT SUBSTR(GRANTOR,1,10) as GRANTOR, GRANTEETYPE, SUBSTR(GRANTEE,1,10) as GRANTEE, GRANTORTYPE, \
SUBSTR(ROLENAME,1,15) as ROLENAME, CREATE_TIME, ADMIN FROM TABLE (SYSPROC.AUTH_LIST_ROLES_FOR_AUTHID ('MWATCHDB', 'U') ) AS T" ;


GRANTOR    GRANTEETYPE GRANTEE    GRANTORTYPE ROLENAME        CREATE_TIME                ADMIN
---------- ----------- ---------- ----------- --------------- -------------------------- -----
DB2INST1   U           MWATCHDB   U           DB2RDEVMI       2017-01-14-21.30.13.954094 N
SYSIBM     G           PUBLIC     S           SYSTS_USR       2017-01-28-00.49.24.795580 N

  2 record(s) selected.


Checking for DB2RDEVMI Role:
--------------------------
db2 "SELECT SUBSTR(GRANTOR,1,10) as GRANTOR, GRANTEETYPE, SUBSTR(GRANTEE,1,10) as GRANTEE, GRANTORTYPE, \
SUBSTR(ROLENAME,1,15) as ROLENAME, CREATE_TIME, ADMIN FROM TABLE (SYSPROC.AUTH_LIST_ROLES_FOR_AUTHID ('DB2RDEVMI', 'R') ) AS T" ;


GRANTOR    GRANTEETYPE GRANTEE    GRANTORTYPE ROLENAME        CREATE_TIME                ADMIN
---------- ----------- ---------- ----------- --------------- -------------------------- -----

  0 record(s) selected.




Retrieve List of Users Under Which ROLES, USER-ROLE Mapping:
------------------------------------------------------------

db2 "SELECT SUBSTR(GRANTOR,1,30) as GRANTOR, GRANTORTYPE, GRANTORROLEID,  SUBSTR(GRANTEE,1,30) as GRANTEE, GRANTEETYPE, GRANTEEROLEID, \
SUBSTR(ROLENAME,1,30) as ROLENAME, ROLEID, ADMIN FROM SYSIBM.SYSROLEAUTH ORDER BY ROLENAME";


db2 "SELECT SUBSTR(GRANTOR,1,30) as GRANTOR, GRANTORTYPE, SUBSTR(GRANTEE,1,30) as GRANTEE, GRANTEETYPE,  \
SUBSTR(ROLENAME,1,30) as ROLENAME, ADMIN FROM SYSIBM.SYSROLEAUTH ORDER BY ROLENAME";

GRANTOR                        GRANTORTYPE GRANTEE                        GRANTEETYPE ROLENAME                       ADMIN
------------------------------ ----------- ------------------------------ ----------- ------------------------------ -----
DB2INST1                       U           CROSSITUSR                     U           CROSSITROLE                    N
DB2INST1                       U           LOFASOJ                        U           DB2RDEVMI                      N
DB2INST1                       U           SANKARAV                       U           DB2RDEVMI                      N
DB2INST1                       U           LEARYT                         U           DB2RDEVMI                      N
DB2INST1                       U           WCSGCPUSR                      U           DB2RDEVMI                      N
DB2INST1                       U           TUMMANAH                       U           DB2RDEVMI                      N
DB2INST1                       U           DAMANIAR                       U           DB2RDEVMI                      N
DB2INST1                       U           KHANA01                        U           DB2RDEVMI                      N
DB2INST1                       U           MEHERA                         U           DB2RDEVMI                      N
DB2INST1                       U           MEIZLISS                       U           DB2RDEVMI                      N
DB2INST1                       U           SINGHS04                       U           DB2RDEVMI                      N
DB2INST1                       U           MWATCHDB                       U           DB2RDEVMI                      N
DB2INST1                       U           AN                             U           DB2RDEVMI                      N
DB2INST1                       U           TAYALA                         U           DB2RDEVMI                      N
DB2INST1                       U           KAMATHA                        U           DB2RDEVMI                      N
DB2INST1                       U           REDDYM                         U           DB2RDEVMI                      N
DB2INST1                       U           KAURB                          U           DB2RDEVMI                      N
DB2INST1                       U           NAVPUTES                       U           DB2RDEVMI                      N
DB2INST1                       U           SAHANAA                        U           DB2RDEVMI                      N
DB2INST1                       U           RACHARLV                       U           DB2RDEVMI                      N
DB2INST1                       U           PANDLAP                        U           DB2RDEVMI                      N
SYSIBM                         S           DB2INST1                       U           SYSROLE_AUTH_DBADM             N
SYSIBM                         S           SYSROLE_AUTH_SQLADM            R           SYSROLE_AUTH_EXPLAIN           N
SYSIBM                         S           DB2INST1                       U           SYSROLE_AUTH_SECADM            N
SYSIBM                         S           SYSROLE_AUTH_DBADM             R           SYSROLE_AUTH_SQLADM            N
SYSIBM                         S           SYSROLE_AUTH_DBADM             R           SYSROLE_AUTH_WLMADM            N
SYSIBM                         S           DB2INST1                       U           SYSTS_ADM                      N
SYSIBM                         S           DB2INST1                       U           SYSTS_MGR                      N
SYSIBM                         S           PUBLIC                         G           SYSTS_USR                      N

  29 record(s) selected.



To List the granted privileges and object name, schema, and type values for Authorization ID: 
*********************************************************************************************
Checking For Authorization ID of Type Role: DB2RDEVMI
------------------------------------------------------

db2 "SELECT SUBSTR(AUTHID,1,30) as AUTHID, AUTHIDTYPE, PRIVILEGE, GRANTABLE, SUBSTR(OBJECTNAME,1,30) as OBJECTNAME, SUBSTR(OBJECTSCHEMA,1,30) as OBJECTSCHEMA, OBJECTTYPE \
FROM SYSIBMADM.PRIVILEGES WHERE AUTHID='DB2RDEVMI'";

AUTHID                         AUTHIDTYPE PRIVILEGE   GRANTABLE OBJECTNAME                     OBJECTSCHEMA                   OBJECTTYPE
------------------------------ ---------- ----------- --------- ------------------------------ ------------------------------ ------------------------
DB2RDEVMI                      R          USE         N         SYSTOOLSTMPSPACE                                              TABLESPACE
DB2RDEVMI                      R          USE         N         TSDEL16K                                                      TABLESPACE
DB2RDEVMI                      R          USE         N         TSMAST16K                                                     TABLESPACE
DB2RDEVMI                      R          USE         N         TSMAST4K                                                      TABLESPACE
DB2RDEVMI                      R          USE         N         TSREG16K                                                      TABLESPACE
DB2RDEVMI                      R          SELECT      N         SYSRELS                        SYSIBM                         TABLE
DB2RDEVMI                      R          SELECT      N         SYSROUTINEPARMS                SYSIBM                         TABLE
DB2RDEVMI                      R          SELECT      N         SYSKEYCOLUSE                   SYSIBM                         TABLE
DB2RDEVMI                      R          SELECT      N         USER_ROLES                     EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         SYSDUMMY1                      SYSIBM                         VIEW
DB2RDEVMI                      R          SELECT      N         CI_BATCH                       EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_BATCH_ITEMS                 EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_STOCKLOC                    EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_AISLE                       EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         SQLCOLPRIVILEGES               SYSIBM                         VIEW
DB2RDEVMI                      R          SELECT      N         SQLPRIMARYKEYS                 SYSIBM                         VIEW
DB2RDEVMI                      R          SELECT      N         SQLPROCEDURECOLS               SYSIBM                         VIEW
DB2RDEVMI                      R          SELECT      N         SQLPROCEDURES                  SYSIBM                         VIEW
DB2RDEVMI                      R          SELECT      N         SQLSPECIALCOLUMNS              SYSIBM                         VIEW
DB2RDEVMI                      R          SELECT      N         SQLSTATISTICS                  SYSIBM                         VIEW
DB2RDEVMI                      R          SELECT      N         SQLTABLEPRIVILEGES             SYSIBM                         VIEW
DB2RDEVMI                      R          SELECT      N         SQLTABLETYPES                  SYSIBM                         VIEW
DB2RDEVMI                      R          SELECT      N         SQLSCHEMAS                     SYSIBM                         VIEW
DB2RDEVMI                      R          SELECT      N         SQLTABLES                      SYSIBM                         VIEW
DB2RDEVMI                      R          SELECT      N         SQLUDTS                        SYSIBM                         VIEW
DB2RDEVMI                      R          SELECT      N         SQLTYPEINFO                    SYSIBM                         VIEW
DB2RDEVMI                      R          SELECT      N         WEBCONTACT_AUDIT               EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         VIRTUAL_LOC                    EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         RUNTABLE                       EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         ORDHDR_ERROR_EXTENSION         EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         ITEMLBL_AUDIT                  EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         INCLUSION_TYPE_MASTER          EVMIDB                         TABLE
DB2RDEVMI                      U          SELECT      N         TEMPITEMS                      EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         TEMPITEMS                      EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         BLNKTPO                        EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         LINEDISTRCODE                  EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         ERRINFO                        EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         ORDSTS                         EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         MDLINFO                        EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         COMPETITORS                    EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         ITEMSTS                        EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         ORDTYPE                        EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CROSITLITEHDR                  EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         STCKLOC                        EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         ITEMLBL                        EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         UPLOADHDRSTS                   EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         LBLSTAGING                     EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         ORDHDR                         EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         NOTIFICATIONHISTRY             EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         ORDDTLS                        EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         COMMENTS                       EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         ORDLBLHDR                      EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         ORDLBLDETAILS                  EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         PURGEINFO                      EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         AUDIT                          EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         STCKLOCSTAGING                 EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CROSITLITEDTLS                 EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         WEBORDTYPE                     EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         WEBCONTACT                     EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CONFIG                         EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         UPLOAD_HEADER                  EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         SYSINDEXES                     SYSIBM                         TABLE
DB2RDEVMI                      R          SELECT      N         SYSROUTINES                    SYSIBM                         TABLE
DB2RDEVMI                      R          SELECT      N         SYSTABCONST                    SYSIBM                         TABLE
DB2RDEVMI                      R          SELECT      N         SYSDATATYPES                   SYSIBM                         TABLE
DB2RDEVMI                      R          SELECT      N         UPLOAD_DETAILS                 EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_CABINET                     EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_XBATCHUPLOAD                EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_BATCH_UPLOAD                EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         SYSTABLES                      SYSIBM                         TABLE
DB2RDEVMI                      R          SELECT      N         SYSCOLUMNS                     SYSIBM                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_PUTAWAY                     EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_PAITEMS                     EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_CIMLBATCHHDR                EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_BIN_TEMPLATE                EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_SECTION                     EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_FAVOURITE_BATCHES           EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         USERS                          EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_PREDEFINEDLIST              EVMIDB                         TABLE
DB2RDEVMI                      R          SELECT      N         CI_PREDEFINEDLIST_ITEMS        EVMIDB                         TABLE

  80 record(s) selected.



Checking For Authorization ID of Type Group: DB2READ
------------------------------------------------------

db2 "SELECT SUBSTR(AUTHID,1,30) as AUTHID, AUTHIDTYPE, PRIVILEGE, GRANTABLE, SUBSTR(OBJECTNAME,1,30) as OBJECTNAME, SUBSTR(OBJECTSCHEMA,1,30) as OBJECTSCHEMA, OBJECTTYPE \
FROM SYSIBMADM.PRIVILEGES WHERE AUTHID='DB2READ'";


AUTHID                         AUTHIDTYPE PRIVILEGE   GRANTABLE OBJECTNAME                     OBJECTSCHEMA                   OBJECTTYPE
------------------------------ ---------- ----------- --------- ------------------------------ ------------------------------ ------------------------
DB2READ                        G          EXECUTE     N         SQL231213105044447             EVMIDB                         PROCEDURE

  1 record(s) selected.


Checking For Authorization ID of Type User: CLOUDXPZ
------------------------------------------------------

db2 "SELECT SUBSTR(AUTHID,1,30) as AUTHID, AUTHIDTYPE, PRIVILEGE, GRANTABLE, SUBSTR(OBJECTNAME,1,30) as OBJECTNAME, SUBSTR(OBJECTSCHEMA,1,30) as OBJECTSCHEMA, OBJECTTYPE \
FROM SYSIBMADM.PRIVILEGES WHERE AUTHID='CLOUDXPZ'";


AUTHID                         AUTHIDTYPE PRIVILEGE   GRANTABLE OBJECTNAME                     OBJECTSCHEMA                   OBJECTTYPE
------------------------------ ---------- ----------- --------- ------------------------------ ------------------------------ ------------------------

  0 record(s) selected.



Checking For Authorization ID of Type User: MWATCHDB
------------------------------------------------------

db2 "SELECT SUBSTR(AUTHID,1,30) as AUTHID, AUTHIDTYPE, PRIVILEGE, GRANTABLE, SUBSTR(OBJECTNAME,1,30) as OBJECTNAME, SUBSTR(OBJECTSCHEMA,1,30) as OBJECTSCHEMA, OBJECTTYPE \
FROM SYSIBMADM.PRIVILEGES WHERE AUTHID='MWATCHDB'";

AUTHID                         AUTHIDTYPE PRIVILEGE   GRANTABLE OBJECTNAME                     OBJECTSCHEMA                   OBJECTTYPE
------------------------------ ---------- ----------- --------- ------------------------------ ------------------------------ ------------------------
MWATCHDB                       U          EXECUTE     Y         SQLUFO17                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          EXECUTE     Y         SQLC2O29                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          EXECUTE     Y         SQLC3O28                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          EXECUTE     Y         SQLC4O28                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          EXECUTE     Y         SQLC5O28                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          EXECUTE     Y         SQLC6O28                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          EXECUTE     Y         SQLL9O1O                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          BIND        Y         SQLUFO17                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          BIND        Y         SQLC2O29                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          BIND        Y         SQLC3O28                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          BIND        Y         SQLC4O28                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          BIND        Y         SQLC5O28                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          BIND        Y         SQLC6O28                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          BIND        Y         SQLL9O1O                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          CONTROL     N         SQLUFO17                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          CONTROL     N         SQLC2O29                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          CONTROL     N         SQLC3O28                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          CONTROL     N         SQLC4O28                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          CONTROL     N         SQLC5O28                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          CONTROL     N         SQLC6O28                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          CONTROL     N         SQLL9O1O                       NULLID                         DB2 PACKAGE
MWATCHDB                       U          SELECT      N         SYSFUNCMAPOPTIONS              SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         ATTRIBUTES                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         AUDITPOLICIES                  SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         AUDITUSE                       SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         BUFFERPOOLDBPARTITIONS         SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         BUFFERPOOLEXCEPTIONS           SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         BUFFERPOOLNODES                SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         BUFFERPOOLS                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         CASTFUNCTIONS                  SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         CHECKS                         SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         COLUMNS                        SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         COLUSE                         SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         CONDITIONS                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         CONSTDEP                       SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         CONTEXTATTRIBUTES              SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         CONTEXTS                       SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         CONTROLDEP                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         CONTROLS                       SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         DATAPARTITIONEXPRESSION        SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         DATAPARTITIONS                 SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         DATATYPEDEP                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         DATATYPES                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         DBAUTH                         SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         DBPARTITIONGROUPDEF            SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         DBPARTITIONGROUPS              SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         EVENTMONITORS                  SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         EVENTS                         SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         EVENTTABLES                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         FULLHIERARCHIES                SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         FUNCDEP                        SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         FUNCMAPOPTIONS                 SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         FUNCMAPPARMOPTIONS             SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         FUNCMAPPINGS                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         FUNCPARMS                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         FUNCTIONS                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         HIERARCHIES                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         HISTOGRAMTEMPLATEBINS          SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         HISTOGRAMTEMPLATES             SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         HISTOGRAMTEMPLATEUSE           SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         INDEXAUTH                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         INDEXCOLUSE                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         INDEXDEP                       SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         INDEXES                        SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         INDEXEXPLOITRULES              SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         INDEXEXTENSIONDEP              SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         INDEXEXTENSIONMETHODS          SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         COLAUTH                        SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         COLCHECKS                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         COLDIST                        SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         COLGROUPCOLS                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         COLGROUPDIST                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         COLGROUPDISTCOUNTS             SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         COLGROUPS                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         COLIDENTATTRIBUTES             SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         COLLATIONS                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         COLOPTIONS                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         INDEXEXTENSIONPARMS            SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         INDEXEXTENSIONS                SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         INDEXOPTIONS                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         INDEXPARTITIONS                SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         INDEXXMLPATTERNS               SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         INVALIDOBJECTS                 SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         KEYCOLUSE                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         LIBRARIES                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         LIBRARYAUTH                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         LIBRARYBINDFILES               SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         LIBRARYVERSIONS                SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         MEMBERSUBSETATTRS              SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         MEMBERSUBSETMEMBERS            SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         MEMBERSUBSETS                  SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         MODULEAUTH                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         MODULEOBJECTS                  SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         MODULES                        SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         NAMEMAPPINGS                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         NICKNAMES                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         NODEGROUPDEF                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         NODEGROUPS                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         PACKAGEAUTH                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         PACKAGEDEP                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         PACKAGES                       SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         PARTITIONMAPS                  SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         PASSTHRUAUTH                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         PERIODS                        SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         PREDICATESPECS                 SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         PROCEDURES                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         PROCPARMS                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         REFERENCES                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         ROLEAUTH                       SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         ROLES                          SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         ROUTINEAUTH                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         ROUTINEDEP                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         ROUTINEOPTIONS                 SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         ROUTINEPARMOPTIONS             SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         ROUTINEPARMS                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         ROUTINES                       SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         ROUTINESFEDERATED              SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         ROWFIELDS                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SCHEMAAUTH                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SCHEMATA                       SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SCPREFTBSPACES                 SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SECURITYLABELACCESS            SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SECURITYLABELCOMPONENTELEMENTS SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SECURITYLABELCOMPONENTS        SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SECURITYLABELS                 SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SECURITYPOLICIES               SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SECURITYPOLICYCOMPONENTRULES   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SECURITYPOLICYEXEMPTIONS       SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SEQUENCEAUTH                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SEQUENCES                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SERVEROPTIONS                  SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SERVERS                        SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SERVICECLASSES                 SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         STATEMENTS                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         STATEMENTTEXTS                 SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         STOGROUPS                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         SURROGATEAUTHIDS               SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         TABAUTH                        SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         TABCONST                       SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         TABDEP                         SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         TABDETACHEDDEP                 SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         TABLES                         SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         TABLESPACES                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         TABOPTIONS                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         TBSPACEAUTH                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         THRESHOLDS                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         TRANSFORMS                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         TRIGDEP                        SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         TRIGGERS                       SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         TYPEMAPPINGS                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         USAGELISTS                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         USEROPTIONS                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         VARIABLEAUTH                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         VARIABLEDEP                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         VARIABLES                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         VIEWDEP                        SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         VIEWS                          SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         WORKACTIONS                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         WORKACTIONSETS                 SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         WORKCLASSATTRIBUTES            SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         WORKCLASSES                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         WORKCLASSSETS                  SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         WORKLOADAUTH                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         WORKLOADCONNATTR               SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         WORKLOADS                      SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         WRAPOPTIONS                    SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         WRAPPERS                       SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         XDBMAPGRAPHS                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         XDBMAPSHREDTREES               SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         XMLSTRINGS                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         XSROBJECTAUTH                  SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         XSROBJECTCOMPONENTS            SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         XSROBJECTDEP                   SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         XSROBJECTDETAILS               SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         XSROBJECTHIERARCHIES           SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         XSROBJECTS                     SYSCAT                         VIEW
MWATCHDB                       U          SELECT      N         CHECK_CONSTRAINTS              SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         COLUMNS                        SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         COLUMNS_S                      SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         DUAL                           SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         PARAMETERS                     SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         PARAMETERS_S                   SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         REFERENTIAL_CONSTRAINTS        SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         REF_CONSTRAINTS                SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         ROUTINES                       SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         ROUTINES_S                     SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLCOLPRIVILEGES               SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLCOLUMNS                     SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLFOREIGNKEYS                 SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLPRIMARYKEYS                 SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLPROCEDURECOLS               SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLPROCEDURES                  SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLSCHEMAS                     SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLSPECIALCOLUMNS              SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLSTATISTICS                  SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLTABLEPRIVILEGES             SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLTABLES                      SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLTABLETYPES                  SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLTYPEINFO                    SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SQLUDTS                        SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SYSATTRIBUTES                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSAUDITEXCEPTIONS             SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSAUDITPOLICIES               SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSAUDITUSE                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSBUFFERPOOLNODES             SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSBUFFERPOOLS                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCHECKS                      SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCODEPROPERTIES              SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOLAUTH                     SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOLCHECKS                   SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOLDEPENDENCIES             SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOLDIST                     SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOLGROUPDIST                SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOLGROUPDISTCOUNTS          SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOLGROUPS                   SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOLGROUPSCOLS               SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOLLATIONS                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOLOPTIONS                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOLPROPERTIES               SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOLUMNS                     SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOLUSE                      SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCOMMENTS                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCONSTDEP                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCONTEXTATTRIBUTES           SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCONTEXTS                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSCONTROLS                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSDATAPARTITIONEXPRESSION     SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSDATAPARTITIONS              SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSDATATYPES                   SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSDBAUTH                      SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSDEPENDENCIES                SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSDUMMY1                      SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SYSENVIRONMENT                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSEVENTMONITORS               SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSEVENTS                      SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSEVENTTABLES                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSFUNCMAPPARMOPTIONS          SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSFUNCMAPPINGS                SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSFUNCPARMS                   SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SYSFUNCTIONS                   SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SYSHIERARCHIES                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSHISTOGRAMTEMPLATEBINS       SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSHISTOGRAMTEMPLATES          SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSHISTOGRAMTEMPLATEUSE        SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSINDEXAUTH                   SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSINDEXCOLUSE                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSINDEXES                     SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSINDEXEXPLOITRULES           SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSINDEXEXTENSIONMETHODS       SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSINDEXEXTENSIONPARMS         SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSINDEXEXTENSIONS             SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSINDEXOPTIONS                SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSINDEXPARTITIONS             SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSINDEXXMLPATTERNS            SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSINVALIDOBJECTS              SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSJARCONTENTS                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSJAROBJECTS                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSJOBS                        SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSKEYCOLUSE                   SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSLIBRARIES                   SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSLIBRARYAUTH                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSLIBRARYBINDFILES            SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSLIBRARYVERSIONS             SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSMEMBERSUBSETATTRS           SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSMODULES                     SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSNAMEMAPPINGS                SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSNODEGROUPDEF                SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSNODEGROUPS                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSPARTITIONMAPS               SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSPASSTHRUAUTH                SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSPERIODS                     SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSPLAN                        SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSPLANAUTH                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSPLANDEP                     SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSPREDICATESPECS              SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSPROCEDURES                  SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SYSPROCPARMS                   SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SYSRELS                        SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSREVTYPEMAPPINGS             SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SYSROLEAUTH                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSROLES                       SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSROUTINEAUTH                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSROUTINEOPTIONS              SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSROUTINEPARMOPTIONS          SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSROUTINEPARMS                SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSROUTINEPROPERTIES           SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSROUTINEPROPERTIESJAVA       SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         SYSROUTINES                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSCHEMAAUTH                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSCHEMATA                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSCPREFTBSPACES              SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSECTION                     SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSECURITYLABELACCESS         SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSECURITYLABELCOMPONENTS     SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSECURITYLABELS              SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSECURITYPOLICIES            SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSECURITYPOLICYEXEMPTIONS    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSEQUENCEAUTH                SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSEQUENCES                   SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSERVEROPTIONS               SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSERVERS                     SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSERVICECLASSES              SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSTMT                        SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSTOGROUPS                   SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSSURROGATEAUTHIDS            SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSTABAUTH                     SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSTABCONST                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSMEMBERSUBSETMEMBERS         SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSMEMBERSUBSETS               SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSMODULEAUTH                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSTBSPACEAUTH                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSTHRESHOLDS                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSTRANSFORMS                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSTRIGGERS                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSTUNINGINFO                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSTYPEMAPPINGS                SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSUPGRADERUNSTATSTASKS        SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSUSAGELISTS                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSUSERAUTH                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSUSEROPTIONS                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSVARIABLEAUTH                SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSVARIABLES                   SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSVERSIONS                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSVIEWDEP                     SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSVIEWS                       SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSWORKACTIONS                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSWORKACTIONSETS              SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSWORKCLASSATTRIBUTES         SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSWORKCLASSES                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSWORKCLASSSETS               SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSWORKLOADAUTH                SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSWORKLOADCONNATTR            SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSWORKLOADS                   SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSWRAPOPTIONS                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSWRAPPERS                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSXDBMAPGRAPHS                SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSXDBMAPSHREDTREES            SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSXMLPATHS                    SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSXMLSTRINGS                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSXSROBJECTAUTH               SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSXSROBJECTCOMPONENTS         SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSXSROBJECTHIERARCHIES        SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSXSROBJECTS                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         TABLES                         SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         TABLES_S                       SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         TABLE_CONSTRAINTS              SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         UDT_S                          SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         USER_DEFINED_TYPES             SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         VIEWS                          SYSIBM                         VIEW
MWATCHDB                       U          SELECT      N         ADMINTABCOMPRESSINFO           SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         ADMINTABINFO                   SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         ADMINTEMPCOLUMNS               SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SYSTABLES                      SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSTABLESPACES                 SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSTABOPTIONS                  SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         SYSTASKS                       SYSIBM                         TABLE
MWATCHDB                       U          SELECT      N         ADMINTEMPTABLES                SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         APPLICATIONS                   SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         APPL_PERFORMANCE               SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         AUTHORIZATIONIDS               SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         BP_HITRATIO                    SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         BP_READ_IO                     SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         BP_WRITE_IO                    SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         CONTACTGROUPS                  SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         CONTACTS                       SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         CONTAINER_UTILIZATION          SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         DB2_INSTANCE_ALERTS            SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         DBCFG                          SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         DBMCFG                         SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         DBPATHS                        SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         DB_HISTORY                     SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         ENV_CF_SYS_RESOURCES           SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         ENV_FEATURE_INFO               SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         ENV_INST_INFO                  SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         ENV_PROD_INFO                  SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         ENV_SYS_INFO                   SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         ENV_SYS_RESOURCES              SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         LOCKS_HELD                     SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         LOCKWAITS                      SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         LOG_UTILIZATION                SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         LONG_RUNNING_SQL               SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         NOTIFICATIONLIST               SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         OBJECTOWNERS                   SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         PDLOGMSGS_LAST24HOURS          SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         PRIVILEGES                     SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         QUERY_PREP_COST                SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         REG_VARIABLES                  SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPAGENT                      SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPAGENT_MEMORY_POOL          SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPAPPL                       SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPAPPL_INFO                  SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPBP                         SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPBP_PART                    SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPCONTAINER                  SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPDB                         SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPDBM                        SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPDBM_MEMORY_POOL            SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPDB_MEMORY_POOL             SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPDETAILLOG                  SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPDYN_SQL                    SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPFCM                        SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPFCM_PART                   SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPHADR                       SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPLOCK                       SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPLOCKWAIT                   SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPSTMT                       SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPSTORAGE_PATHS              SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPSUBSECTION                 SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPSWITCHES                   SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPTAB                        SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPTAB_REORG                  SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPTBSP                       SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPTBSP_PART                  SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPTBSP_QUIESCER              SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPTBSP_RANGE                 SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPUTIL                       SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         SNAPUTIL_PROGRESS              SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         TBSP_UTILIZATION               SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         TOP_DYNAMIC_SQL                SYSIBMADM                      VIEW
MWATCHDB                       U          SELECT      N         COLDIST                        SYSSTAT                        VIEW
MWATCHDB                       U          SELECT      N         COLGROUPDIST                   SYSSTAT                        VIEW
MWATCHDB                       U          SELECT      N         COLGROUPDISTCOUNTS             SYSSTAT                        VIEW
MWATCHDB                       U          SELECT      N         COLGROUPS                      SYSSTAT                        VIEW
MWATCHDB                       U          SELECT      N         COLUMNS                        SYSSTAT                        VIEW
MWATCHDB                       U          SELECT      N         FUNCTIONS                      SYSSTAT                        VIEW
MWATCHDB                       U          SELECT      N         INDEXES                        SYSSTAT                        VIEW
MWATCHDB                       U          SELECT      N         ROUTINES                       SYSSTAT                        VIEW
MWATCHDB                       U          SELECT      N         TABLES                         SYSSTAT                        VIEW




Checking for DB Authorization Privileges:
**************************************************
db2 "SELECT SUBSTR(GRANTOR,1,15) as GRANTOR, GRANTORTYPE,  SUBSTR(GRANTEE,1,15) as GRANTEE, GRANTEETYPE, \
BINDADDAUTH, CONNECTAUTH, CREATETABAUTH, DBADMAUTH, EXTERNALROUTINEAUTH, IMPLSCHEMAAUTH, LOADAUTH, NOFENCEAUTH, \
QUIESCECONNECTAUTH, LIBRARYADMAUTH, SECURITYADMAUTH, SQLADMAUTH, WLMADMAUTH, EXPLAINAUTH, DATAACCESSAUTH, \
ACCESSCTRLAUTH, SECURITYADMAUTH, CREATESECUREAUTH FROM SYSCAT.DBAUTH" ;


db2 "SELECT SUBSTR(GRANTOR,1,30) as GRANTOR, GRANTORTYPE,  SUBSTR(GRANTEE,1,30) as GRANTEE, GRANTEETYPE, \
BINDADDAUTH, CONNECTAUTH, CREATETABAUTH, DBADMAUTH, EXTERNALROUTINEAUTH, IMPLSCHEMAAUTH, DATAACCESSAUTH, ACCESSCTRLAUTH, SECURITYADMAUTH, \
CREATESECUREAUTH FROM SYSCAT.DBAUTH" ;

GRANTOR                        GRANTORTYPE GRANTEE                        GRANTEETYPE BINDADDAUTH CONNECTAUTH CREATETABAUTH DBADMAUTH EXTERNALROUTINEAUTH IMPLSCHEMAAUTH DATAACCESSAUTH ACCESSCTRLAUTH SECURITYADMAUTH CREATESECUREAUTH
------------------------------ ----------- ------------------------------ ----------- ----------- ----------- ------------- --------- ------------------- -------------- -------------- -------------- --------------- ----------------
SYSIBM                         S           DB2INST1                       U           N           N           N             Y         N                   N              Y              Y              Y               N
DB2INST1                       U           CROSSITROLE                    R           N           Y           N             N         N                   N              Y              N              N               N
DB2INST1                       U           DB2RDEVMI                      R           N           Y           N             N         N                   N              N              N              N               N
DB2INST1                       U           EVMIAPP                        U           N           Y           N             N         N                   N              Y              N              N               N
DB2INST1                       U           CLOUDXPZ                       U           N           Y           N             N         N                   N              Y              N              N               N

  5 record(s) selected.


db2 "SELECT SUBSTR(GRANTOR,1,15) AS GRANTOR, GRANTORTYPE, SUBSTR(GRANTEE,1,15) AS GRANTEE, GRANTEETYPE, SUBSTR(TABSCHEMA,1,15) AS TABSCHEMA, \
SUBSTR(TABNAME,1,50) AS TABNAME, CONTROLAUTH,ALTERAUTH,DELETEAUTH,INDEXAUTH,INSERTAUTH,REFAUTH,SELECTAUTH,UPDATEAUTH \
FROM SYSCAT.TABAUTH WHERE GRANTOR <> 'SYSIBM' ORDER BY GRANTEE";

GRANTOR         GRANTORTYPE GRANTEE         GRANTEETYPE TABSCHEMA       TABNAME                                            CONTROLAUTH ALTERAUTH DELETEAUTH INDEXAUTH INSERTAUTH REFAUTH SELECTAUTH UPDATEAUTH
--------------- ----------- --------------- ----------- --------------- -------------------------------------------------- ----------- --------- ---------- --------- ---------- ------- ---------- ----------
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SQLTABLES                                          N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SYSTABLES                                          N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SQLTABLETYPES                                      N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SQLTABLEPRIVILEGES                                 N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SYSCOLUMNS                                         N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SQLSPECIALCOLUMNS                                  N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SQLCOLPRIVILEGES                                   N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SYSDUMMY1                                          N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SQLPRIMARYKEYS                                     N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SQLSTATISTICS                                      N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SYSINDEXES                                         N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SQLPROCEDURES                                      N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SQLPROCEDURECOLS                                   N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SYSROUTINES                                        N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SYSROUTINEPARMS                                    N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SQLTYPEINFO                                        N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SQLUDTS                                            N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SQLSCHEMAS                                         N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SYSRELS                                            N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SYSKEYCOLUSE                                       N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SYSTABCONST                                        N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           SYSIBM          SYSDATATYPES                                       N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          AUDIT                                              N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          BLNKTPO                                            N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          COMMENTS                                           N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          COMPETITORS                                        N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          CONFIG                                             N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          CROSITLITEDTLS                                     N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          CROSITLITEHDR                                      N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          ERRINFO                                            N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          ITEMLBL                                            N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          ITEMSTS                                            N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          LBLSTAGING                                         N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          LINEDISTRCODE                                      N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          MDLINFO                                            N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          NOTIFICATIONHISTRY                                 N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          ORDDTLS                                            N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          ORDHDR                                             N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          ORDLBLDETAILS                                      N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          ORDLBLHDR                                          N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          ORDSTS                                             N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          ORDTYPE                                            N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          PURGEINFO                                          N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          STCKLOC                                            N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          STCKLOCSTAGING                                     N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          WEBCONTACT                                         N           N         N          N         N          N       Y          N
DB2INST1        U           DB2RDEVMI       R           EVMIDB          WEBORDTYPE                                         N           N         N          N         N          N       Y          N


