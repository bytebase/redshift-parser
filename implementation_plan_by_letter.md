# Redshift SQL Commands Implementation Plan (Grouped by First Letter)

## Status Legend
- ✓ = Completed
- 🔄 = In Progress
- ⏳ = Pending

## A Commands
- ✓ ABORT (already in base parser)
- ✓ ALTER DATASHARE
- ⏳ ALTER DATABASE
- ⏳ ALTER DEFAULT PRIVILEGES
- ⏳ ALTER EXTERNAL SCHEMA
- ⏳ ALTER EXTERNAL VIEW
- ⏳ ALTER FUNCTION
- ⏳ ALTER GROUP
- ⏳ ALTER IDENTITY PROVIDER
- ⏳ ALTER MASKING POLICY
- ⏳ ALTER MATERIALIZED VIEW
- ⏳ ALTER PROCEDURE
- ⏳ ALTER RLS POLICY
- ⏳ ALTER ROLE
- ⏳ ALTER SCHEMA
- ⏳ ALTER SYSTEM
- ⏳ ALTER TABLE (needs Redshift enhancements)
- ⏳ ALTER TABLE APPEND
- ⏳ ALTER USER
- ✓ ANALYZE
- ✓ ANALYZE COMPRESSION
- ✓ ATTACH MASKING POLICY
- ✓ ATTACH RLS POLICY

## B Commands
- ⏳ BEGIN

## C Commands
- ⏳ CALL
- ✓ CANCEL
- ⏳ CLOSE
- ⏳ COMMENT
- ⏳ COMMIT
- ✓ COPY (Redshift-enhanced)
- ⏳ CREATE DATABASE
- ✓ CREATE DATASHARE
- ⏳ CREATE EXTERNAL FUNCTION
- ⏳ CREATE EXTERNAL MODEL
- ⏳ CREATE EXTERNAL SCHEMA
- ✓ CREATE EXTERNAL TABLE
- ⏳ CREATE EXTERNAL VIEW
- ⏳ CREATE FUNCTION
- ⏳ CREATE GROUP
- ⏳ CREATE IDENTITY PROVIDER
- ⏳ CREATE LIBRARY
- ⏳ CREATE MASKING POLICY
- ⏳ CREATE MATERIALIZED VIEW
- ⏳ CREATE MODEL
- ⏳ CREATE PROCEDURE
- ⏳ CREATE RLS POLICY
- ⏳ CREATE ROLE
- ⏳ CREATE SCHEMA
- ⏳ CREATE TABLE (needs Redshift enhancements)
- ⏳ CREATE TABLE AS
- ⏳ CREATE USER
- ⏳ CREATE VIEW

## D Commands
- ⏳ DEALLOCATE
- ⏳ DECLARE
- ⏳ DELETE
- ⏳ DESC DATASHARE
- ⏳ DESC IDENTITY PROVIDER
- ⏳ DETACH MASKING POLICY
- ✓ DETACH RLS POLICY
- ⏳ DROP DATABASE
- ⏳ DROP DATASHARE
- ⏳ DROP EXTERNAL VIEW
- ⏳ DROP FUNCTION
- ⏳ DROP GROUP
- ⏳ DROP IDENTITY PROVIDER
- ⏳ DROP LIBRARY
- ⏳ DROP MASKING POLICY
- ⏳ DROP MATERIALIZED VIEW
- ⏳ DROP MODEL
- ⏳ DROP PROCEDURE
- ⏳ DROP RLS POLICY
- ⏳ DROP ROLE
- ⏳ DROP SCHEMA
- ⏳ DROP TABLE
- ⏳ DROP USER
- ⏳ DROP VIEW

## E Commands
- ⏳ END
- ⏳ EXECUTE
- ⏳ EXPLAIN

## F Commands
- ⏳ FETCH

## G Commands
- ⏳ GRANT

## I Commands
- ⏳ INSERT

## L Commands
- ⏳ LOCK

## M Commands
- ⏳ MERGE

## P Commands
- ⏳ PREPARE

## R Commands
- ⏳ REFRESH MATERIALIZED VIEW
- ⏳ RESET
- ⏳ REVOKE
- ⏳ ROLLBACK

## S Commands
- ⏳ SELECT
- ⏳ SELECT INTO
- ⏳ SET
- ⏳ SET SESSION AUTHORIZATION
- ⏳ SET SESSION CHARACTERISTICS
- ⏳ SHOW
- ⏳ SHOW COLUMNS
- ⏳ SHOW DATABASES
- ⏳ SHOW DATASHARES
- ⏳ SHOW EXTERNAL TABLE
- ⏳ SHOW GRANTS
- ⏳ SHOW MODEL
- ⏳ SHOW PROCEDURE
- ⏳ SHOW SCHEMAS
- ⏳ SHOW TABLES
- ⏳ SHOW VIEW
- ⏳ START TRANSACTION

## T Commands
- ⏳ TRUNCATE

## U Commands
- ✓ UNLOAD
- ⏳ UPDATE
- ⏳ USE

## V Commands
- ⏳ VACUUM

## Implementation Strategy
1. Group commands by first letter
2. Implement all commands starting with the same letter in one batch
3. Create partial/{letter}_commands.g4 for each letter group
4. Create partial/examples/{letter}_commands.sql for test cases
5. This allows for clearer organization and easier merging