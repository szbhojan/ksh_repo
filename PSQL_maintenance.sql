1. VACUUM Operations (vacuum, vacuum full)
---------------------------------------------
Regularly performed maintenance operation in PostgreSQL. This operation:

Reclaims disk space occupied by updated and deleted rows.
Updates statistics used by the query planner.
Updates Visibility Map files, allowing faster data access.

AUTOVACUUM
-----------
The vacuum operation can be automated with autovacuum. Autovacuum regularly examines statistics and detects tables with a large number of dead rows. 
It creates workers within the limits of the autovacuum_max_workers parameter to perform maintenance on these tables. These workers apply VACUUM and ANALYZE operations to the necessary tables. 
If the number of workers is insufficient for all tasks, the tables are queued.

VACUUM FULL
-----------
Uses a more effective cleaning algorithm compared to normal VACUUM.
Rebuilds tables in a new copy, using more disk space temporarily. Once the operation is complete, this space is released.
Locks the table and prevents access until the operation is finished.
Useful for tables experiencing significant data changes.

VACUUM Examples
----------------
VACUUM; -- no locks, removes dead rows and marks for reuse
VACUUM FULL; -- locks, compacts, more time
\h vacuum
VACUUM FULL VERBOSE emp;
VACUUM;
VACUUM (index_cleanup true, verbose true, analyze true) customers;
VACUUM (full true, index_cleanup true, verbose true, analyze true) customers;
VACUUM (index_cleanup true, verbose true, analyze true, parallel 4) customers; -- with full no parallel

Monitoring Vacuum Status
------------------------
SELECT
        *
FROM
        pg_stat_progress_vacuum;

------------------------------------------

-------------------------------
Unused Indexes
-------------------------------
select
        relname     ,
        indexrelname,
        idx_scan
from
        pg_catalog.pg_stat_user_indexes;
		
ecomm=> select relname, indexrelname, idx_scan from pg_catalog.pg_stat_user_indexes order by idx_scan desc ;
           relname           |                indexrelname                | idx_scan
-----------------------------+--------------------------------------------+----------
 contact                     | CONTACT_pkey                               |   220594
 cust_contact_relation       | uniq_cust_contact                          |    49221
 ca_category                 | CA_CATEGORY_pkey                           |    29148
 punchout_request            | punchout_request_pkey                      |    16458
 widget                      | idx_parent_product_nbr                     |    11432
 contact                     | cdc_uid_key                                |     8790
 contact_role                | CONTACT_ROLE_pkey                          |     6970
 customer                    | CUSTOMER_pkey                              |     5377
 wf_attr_val                 | uniq_wf_attr_val                           |     4281
 customer                    | uniq_ext_billto_number                     |     3702
 wf_attr                     | wf_attr_wf_attr_name_key                   |     3435
 contact                     | contact_external_contact_id                |     3181
 contact_profile             | uniq_add_ext_contact_id                    |     2492
-- More --		

----------------------------------
Duplicate Indexes
----------------------------------

select
        indrelid::regclass   relname  ,
        indexrelid::regclass indexname,
        indkey
from
        pg_index
group by
        relname  ,
        indexname,
        indkey   ,
        relname;
--		
select
        indrelid::regclass relname,
        indkey                    ,
        amname
from
        pg_index   i,
        pg_opclass o,
        pg_am      a
where
        o.oid = ALL(indclass)
and     a.oid = o.opcmethod
group by
        relname ,
        indclass,
        amname  ,
        indkey
having
        count(*) > 1;
		
-----------------------------------------------
To View the current Parameter settings
-----------------------------------------------		
SELECT
        name    AS setting_name ,
        setting AS setting_value,
        unit    AS setting_unit
FROM
        pg_settings
WHERE
        name IN ( 'max_connections',
                  'shared_buffers',
                  'effective_cache_size',
                  'work_mem',
                  'maintenance_work_mem',
                  'autovacuum_max_workers',
                  'wal_buffers',
                  'effective_io_concurrency',
                  'random_page_cost',
                  'seq_page_cost',
                  'log_min_duration_statement' );
					 
SELECT
        name    AS setting_name ,
        setting AS setting_value,
        unit    AS setting_unit
FROM
        pg_settings | awk '{print $1}'
--
select
        *
from
        pg_extension;
--		
--		
		
------------------------------------------------------------
ECOMM QA
---------
ecomm=> SELECT table_schema || '.' || table_name as SCHEMA_TABNAME FROM information_schema.tables WHERE table_type = 'BASE TABLE' AND table_schema NOT IN ('pg_catalog', 'information_schema');
          schema_tabname
----------------------------------
 drex.cust_type
 drex.promotions
 drex.promotion_class_mapping
 drex.promotion_class
 drex.ecomm_page
 drex.promotion_sub_class_mapping
 drex.promotion_sub_class
 drex.promotional_message
 drex.message_type
 drex.promotion_shipping_mapping
 drex.shipping_type
 ecomm.customer_part_numbers
 dbadmin.seq_lastval_maxval_tbl
 drex.widget_item_audit
 drex.widget
 ecomm.user_data_rights_request
 drex.widget_upload_template
 drex.widget_upload_item_template
 ecomm.audit_data
 drex.widget_upload_item_errors
 drex.widget_upload_item_staging
 drex.widget_upload_status_type
 drex.widget_upload_staging
 ecomm.common_address_info
 drex.widget_upload
 ecomm.preregistration
 drex.promotion_segment
 drex.segment
 ecomm.excluded_items
 ecomm.contact_ship_pref_val
 ecomm.ca_upload
 ecomm.ca_category
 ecomm.contact_ca_rstr
 ecomm.contact_basic_attr
 ecomm.contact_flags
 ecomm.contact_ca_defaults
 ecomm.contact_costalloc_attr_val
 ecomm.contact_costalloc_attr
 ecomm.contact_flags_val
 ecomm.contact_ord_pref_val
 ecomm.contact_ord_pref
 ecomm.contact_role
 ecomm.contact_profile
 ecomm.ca_category_val
 ecomm.customer
 ecomm.cust_contact_relation
 ecomm.customer_flag
 ecomm.cust_basic_pref_val
 ecomm.customer_profile
 ecomm.customer_segment_val
 ecomm.customer_segment
 ecomm.cust_basic_pref
 ecomm.cust_costalloc_pref_val
 ecomm.cust_costalloc_pref
 ecomm.cust_ordappr_pref
 ecomm.cust_ordappr_pref_val
 ecomm.msg_audit
 ecomm.orders
 ecomm.po_order_history
 ecomm.customer_flag_val
 ecomm.contact
 ecomm.seq_last_value_tbl
 ecomm.contact_registration
 ecomm.ap_payments_log
 ecomm.ultimate_address
 ecomm.ap_payments_log_status
 ecomm.ap_payments_log_invoice
 ecomm.punchout_intrinsic_contact
 ecomm.purchase_orders_copy
 ecomm.shipping_address
 ecomm.punchout_related_account
 ecomm.wf_attr
 ecomm.wf_buyer_approver
 ecomm.wf_default
 ecomm.x_billtodeactivate
 epro.oauth2_registered_client
 epro.punchout_cart_items
 epro.punchout_cart
 epro.punchout_customer_details
 epro.punchout_customer
 epro.punchout_item
 epro.punchout_request
 public.customernumber
 dbadmin.demo_contact
 dbadmin.demo_contact_copy
 drex.audit
 drex.widget_item
 drex.widget_type
 drex.widget_upload_cross_ref
 drex.widget_upload_errors
 ecomm.common_contact_info
 ecomm.billing_address
 ecomm.contact_basic_attr_val
 ecomm.contact_ship_pref
 ecomm.purchase_orders
 epro.punchout_address
 ecomm.orders_relation
 epro.punchout_audit
 ecomm.wf_attr_val
 ecomm.wf_upload
(100 rows)


ecomm=>

SELECT
        query          ,
        calls          ,
--        total_exec_time,
        rows           ,
        100.0 * shared_blks_hit / nullif(shared_blks_hit + shared_blks_read, 0) AS hit_percent
FROM
        pg_stat_statements
--ORDER BY
--        total_exec_time DESC
LIMIT 5;
		  


SELECT
        'ECOMM' as db_name,
        n.nspname        ,
        c.relname        ,
        count(*) AS buffers
FROM
        ecomm.pg_buffercache b
JOIN
        pg_catalog.pg_class c
ON
        b.relfilenode = pg_relation_filenode(c.oid)
AND     b.reldatabase IN (0,
                          (
                                  SELECT
                                          oid
                                  FROM
                                          pg_database
                                  WHERE
                                          datname = current_database()))
JOIN
        pg_namespace n
ON
        n.oid     = c.relnamespace
and     n.nspname ='public'
GROUP BY
        n.nspname,
        c.relname
ORDER BY
        4 DESC
LIMIT 10;	  

		  
		  
--Manging Bloat:
--------------		  

SELECT
        schemaname,
        tblname   ,
        CASE
        WHEN
                tblpages                       > 0
                AND tblpages - est_tblpages_ff > 0
        THEN
                100 * (tblpages - est_tblpages_ff)/tblpages::float
        ELSE
                0
        END AS bloat_pct
FROM
        (
                SELECT
                        ceil(reltuples / ((bs-page_hdr)/tpl_size)) + ceil(toasttuples / 4) AS est_tblpages_ff,
                        tblpages                                                                             ,
                        bs                                                                                   ,
                        tblid                                                                                ,
                        schemaname                                                                           ,
                        tblname                                                                              ,
                        is_na
                FROM
                        (
                                SELECT
                                        (4 + tpl_hdr_size + tpl_data_size + (2*ma) -
                                        CASE
                                        WHEN
                                                tpl_hdr_size%ma = 0
                                        THEN
                                                ma
                                        ELSE
                                                tpl_hdr_size%ma
                                        END -
                                        CASE
                                        WHEN
                                                ceil(tpl_data_size)::int%ma = 0
                                        THEN
                                                ma
                                        ELSE
                                                ceil(tpl_data_size)::int%ma
                                        END )                    AS tpl_size,
                                        (heappages + toastpages) AS tblpages,
                                        heappages                           ,
                                        toastpages                          ,
                                        reltuples                           ,
                                        toasttuples                         ,
                                        bs                                  ,
                                        page_hdr                            ,
                                        tblid                               ,
                                        schemaname                          ,
                                        tblname                             ,
                                        fillfactor                          ,
                                        is_na
                                FROM
                                        (
                                                SELECT
                                                        tbl.oid     AS tblid                                                                                              ,
                                                        ns.nspname  AS schemaname                                                                                         ,
                                                        tbl.relname AS tblname                                                                                            ,
                                                        tbl.reltuples                                                                                                     ,
                                                        tbl.relpages                                                                                        AS heappages  ,
                                                        coalesce(toast.relpages, 0)                                                                         AS toastpages ,
                                                        coalesce(toast.reltuples, 0)                                                                        AS toasttuples,
                                                        coalesce(substring(array_to_string(tbl.reloptions, ' ') FROM 'fillfactor=([0–9]+)')::smallint, 100) AS fillfactor ,
                                                        current_setting('block_size')::numeric                                                              AS bs         ,
                                                        CASE
                                                        WHEN
                                                                version()~'mingw32'
                                                                OR version()~'64-bit|x86_64|ppc64|ia64|amd64'
                                                        THEN
                                                                8
                                                        ELSE
                                                                4
                                                        END AS ma      ,
                                                        24  AS page_hdr,
                                                        23 +
                                                        CASE
                                                        WHEN
                                                                MAX(coalesce(s.null_frac,0)) > 0
                                                        THEN
                                                                (7 + count(s.attname)) / 8
                                                        ELSE
                                                                0::int
                                                        END +
                                                        CASE
                                                        WHEN
                                                                bool_or(att.attname = 'oid'
                                                                and att.attnum      < 0)
                                                        THEN
                                                                4
                                                        ELSE
                                                                0
                                                        END                                                          AS tpl_hdr_size ,
                                                        sum((1-coalesce(s.null_frac, 0)) * coalesce(s.avg_width, 0)) AS tpl_data_size,
                                                        bool_or(att.atttypid = 'pg_catalog.name'::regtype)
                                                        OR sum(
                                                                CASE
                                                                WHEN
                                                                        att.attnum > 0
                                                                THEN
                                                                        1
                                                                ELSE
                                                                        0
                                                                END) <> count(s.attname) AS is_na
                                                FROM
                                                        pg_attribute AS att
                                                JOIN
                                                        pg_class AS tbl
                                                ON
                                                        att.attrelid = tbl.oid
                                                JOIN
                                                        pg_namespace AS ns
                                                ON
                                                        ns.oid = tbl.relnamespace
                                                LEFT JOIN
                                                        pg_stats AS s
                                                ON
                                                        s.schemaname=ns.nspname
                                                AND     s.tablename =tbl.relname
                                                AND     s.inherited =false
                                                AND     s.attname   =att.attname
                                                LEFT JOIN
                                                        pg_class AS toast
                                                ON
                                                        tbl.reltoastrelid = toast.oid
                                                WHERE
                                                        NOT att.attisdropped
                                                AND     tbl.relkind in ('r',
                                                                        'm')
                                                GROUP BY
                                                        1,
                                                        2,
                                                        3,
                                                        4,
                                                        5,
                                                        6,
                                                        7,
                                                        8,
                                                        9,
                                                        10
                                                ORDER BY
                                                        2,
                                                        3 ) AS s ) AS s2 ) AS s3
WHERE
        schemaname NOT IN ('pg_catalog',
                           'information_schema',
                           'profile')
ORDER BY
        schemaname,
        tblname;
		
SELECT
        datname ,
        pid     ,
        --        state_change    ,
        application_name,
        client_addr     ,
        client_hostname ,
        client_port     ,
        backend_start   ,
        query_start     ,
        state           ,
        backend_type
        --       query_id        ,
        --       query
FROM
        pg_stat_activity
where
        backend_type='client backend'
and     pid         <>pg_backend_pid()
        --and     state       <> 'idle'
;

---
Problems with VACUUM BLOATED TABLES:
-------------------------------------
SELECT * FROM pg_stat_all_tables ORDER BY n_dead_tup / (n_live_tup * current_setting('autovacuum_vacuum_scale_factor')::float8 + current_setting('autovacuum_vacuum_threshold')::float8) DESC LIMIT 10 ;

SELECT schemaname, relname, n_live_tup, n_dead_tup, last_autovacuum FROM pg_stat_all_tables ORDER BY n_dead_tup / (n_live_tup * current_setting('autovacuum_vacuum_scale_factor')::float8 + current_setting('autovacuum_vacuum_threshold')::float8) DESC LIMIT 10 ;

ecomm=> SELECT schemaname, relname, n_live_tup, n_dead_tup, last_autovacuum FROM pg_stat_all_tables ORDER BY n_dead_tup / (n_live_tup * current_setting('autovacuum_vacuum_scale_factor')::float8 + current_setting('autovacuum_vacuum_thresh
old')::float8) DESC LIMIT 10 ;
 schemaname |        relname         | n_live_tup | n_dead_tup |        last_autovacuum
------------+------------------------+------------+------------+-------------------------------
 dbadmin    | seq_lastval_maxval_tbl |     198764 |      36408 | 2024-11-30 14:35:52.764488+00
 pg_toast   | pg_toast_2619          |         74 |         54 | 2024-12-04 06:31:02.598146+00
 pg_catalog | pg_class               |        817 |        137 | 2024-12-01 11:30:07.983838+00
 pg_catalog | pg_statistic           |       1052 |        137 | 2024-12-04 08:30:03.567349+00
 pg_catalog | pg_attribute           |         47 |         29 |
 epro       | punchout_cart          |        190 |         40 |
 ecomm      | purchase_orders        |       2889 |        255 |
 ecomm      | contact                |      47345 |       3589 |
 ecomm      | cust_basic_pref_val    |        211 |         34 | 2024-11-30 06:30:40.5354+00
 epro       | punchout_customer      |        440 |         50 |
(10 rows)


ecomm=>

