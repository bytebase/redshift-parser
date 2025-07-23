-- DROP DATABASE examples for Redshift
-- Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_DROP_DATABASE.html

-- Basic DROP DATABASE
DROP DATABASE tickit_test;

-- DROP DATABASE with IF EXISTS clause
DROP DATABASE IF EXISTS analytics_db;
DROP DATABASE IF EXISTS temp_database;

-- DROP DATABASE with CASCADE option
-- CASCADE will drop all dependent objects
DROP DATABASE test_db CASCADE;
DROP DATABASE IF EXISTS staging_db CASCADE;

-- DROP DATABASE with RESTRICT option
-- RESTRICT prevents dropping if there are dependent objects (default behavior)
DROP DATABASE production_backup RESTRICT;
DROP DATABASE IF EXISTS development_db RESTRICT;

-- Various database name formats
DROP DATABASE mydb;
DROP DATABASE "MixedCaseDB";
DROP DATABASE db_with_underscore;
DROP DATABASE "db-with-hyphens";
DROP DATABASE db123;

-- Combined options
DROP DATABASE IF EXISTS old_analytics CASCADE;
DROP DATABASE IF EXISTS archive_2023 RESTRICT;

-- Special case: Dropping database with AWS Data Exchange datashares
-- Requires setting special session variable first
SET datashare_break_glass_session_var to 'ce8d280c10ad41';
DROP DATABASE test_db_with_datashare;

-- More examples with different naming conventions
DROP DATABASE IF EXISTS customer_data;
DROP DATABASE IF EXISTS "UPPERCASE_DB";
DROP DATABASE IF EXISTS mixed_Case_DB123;

-- Edge cases
-- Note: The following would fail due to Redshift restrictions:
-- DROP DATABASE dev;            -- Cannot drop system database
-- DROP DATABASE padb_harvest;   -- Cannot drop system database
-- DROP DATABASE template0;      -- Cannot drop system database
-- DROP DATABASE template1;      -- Cannot drop system database
-- DROP DATABASE "sys:internal"; -- Cannot drop system database