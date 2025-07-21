# Amazon Redshift SQL Commands Reference

This document contains a comprehensive list of all SQL commands supported by Amazon Redshift, extracted from the official AWS documentation.

## Command Categories

### Transaction Control Commands
- **ABORT** - Aborts the current transaction
- **BEGIN** - Starts a new transaction
- **COMMIT** - Commits the current transaction
- **END** - Synonym for COMMIT
- **ROLLBACK** - Rolls back the current transaction
- **START TRANSACTION** - Starts a new transaction

### Data Definition Language (DDL) - CREATE Commands
- **CREATE DATABASE** - Creates a new database
- **CREATE DATASHARE** *(Redshift-specific)* - Creates a datashare for sharing data across clusters
- **CREATE EXTERNAL FUNCTION** *(Redshift-specific)* - Creates a scalar function using AWS Lambda
- **CREATE EXTERNAL MODEL** *(Redshift-specific)* - Creates a model for Amazon Redshift ML
- **CREATE EXTERNAL SCHEMA** *(Redshift-specific)* - Creates an external schema for data in S3
- **CREATE EXTERNAL TABLE** *(Redshift-specific)* - Creates an external table for Redshift Spectrum
- **CREATE EXTERNAL VIEW** *(Redshift-specific)* - Creates a view on external tables
- **CREATE FUNCTION** - Creates a user-defined function
- **CREATE GROUP** - Creates a new user group
- **CREATE IDENTITY PROVIDER** *(Redshift-specific)* - Creates an identity provider for federated access
- **CREATE LIBRARY** *(Redshift-specific)* - Creates a library for Python UDFs
- **CREATE MASKING POLICY** *(Redshift-specific)* - Creates a dynamic data masking policy
- **CREATE MATERIALIZED VIEW** - Creates a materialized view
- **CREATE MODEL** *(Redshift-specific)* - Creates a machine learning model
- **CREATE PROCEDURE** - Creates a stored procedure
- **CREATE RLS POLICY** *(Redshift-specific)* - Creates a row-level security policy
- **CREATE ROLE** - Creates a new role
- **CREATE SCHEMA** - Creates a new schema
- **CREATE TABLE** - Creates a new table
- **CREATE TABLE AS** - Creates a table from query results
- **CREATE USER** - Creates a new database user
- **CREATE VIEW** - Creates a view

### Data Definition Language (DDL) - ALTER Commands
- **ALTER DATABASE** - Modifies database properties
- **ALTER DATASHARE** *(Redshift-specific)* - Modifies a datashare
- **ALTER DEFAULT PRIVILEGES** - Changes default access privileges
- **ALTER EXTERNAL SCHEMA** *(Redshift-specific)* - Modifies an external schema
- **ALTER EXTERNAL VIEW** *(Redshift-specific)* - Modifies an external view
- **ALTER FUNCTION** - Modifies a function
- **ALTER GROUP** - Modifies a user group
- **ALTER IDENTITY PROVIDER** *(Redshift-specific)* - Modifies an identity provider
- **ALTER MASKING POLICY** *(Redshift-specific)* - Modifies a masking policy
- **ALTER MATERIALIZED VIEW** - Modifies a materialized view
- **ALTER PROCEDURE** - Modifies a stored procedure
- **ALTER RLS POLICY** *(Redshift-specific)* - Modifies a row-level security policy
- **ALTER ROLE** - Modifies a role
- **ALTER SCHEMA** - Modifies a schema
- **ALTER SYSTEM** *(Redshift-specific)* - Changes system-level configuration
- **ALTER TABLE** - Modifies a table structure
- **ALTER TABLE APPEND** *(Redshift-specific)* - Appends data from one table to another
- **ALTER USER** - Modifies a user account

### Data Definition Language (DDL) - DROP Commands
- **DROP DATABASE** - Removes a database
- **DROP DATASHARE** *(Redshift-specific)* - Removes a datashare
- **DROP EXTERNAL VIEW** *(Redshift-specific)* - Removes an external view
- **DROP FUNCTION** - Removes a function
- **DROP GROUP** - Removes a user group
- **DROP IDENTITY PROVIDER** *(Redshift-specific)* - Removes an identity provider
- **DROP LIBRARY** *(Redshift-specific)* - Removes a library
- **DROP MASKING POLICY** *(Redshift-specific)* - Removes a masking policy
- **DROP MATERIALIZED VIEW** - Removes a materialized view
- **DROP MODEL** *(Redshift-specific)* - Removes a machine learning model
- **DROP PROCEDURE** - Removes a stored procedure
- **DROP RLS POLICY** *(Redshift-specific)* - Removes a row-level security policy
- **DROP ROLE** - Removes a role
- **DROP SCHEMA** - Removes a schema
- **DROP TABLE** - Removes a table
- **DROP USER** - Removes a user
- **DROP VIEW** - Removes a view

### Data Manipulation Language (DML) Commands
- **COPY** *(Redshift-enhanced)* - Loads data from S3, DynamoDB, or other sources
- **DELETE** - Removes rows from a table
- **INSERT** - Adds new rows to a table
- **MERGE** - Performs insert, update, or delete in a single operation
- **SELECT** - Retrieves data from tables
- **SELECT INTO** - Creates a new table from query results
- **TRUNCATE** - Removes all rows from a table
- **UNLOAD** *(Redshift-specific)* - Exports query results to S3
- **UPDATE** - Modifies existing rows in a table

### Data Control Language (DCL) Commands
- **GRANT** - Grants access privileges
- **REVOKE** - Revokes access privileges

### Utility and Maintenance Commands
- **ANALYZE** - Updates table statistics
- **ANALYZE COMPRESSION** *(Redshift-specific)* - Analyzes compression options
- **CANCEL** *(Redshift-specific)* - Cancels a running query
- **COMMENT** - Adds comments to database objects
- **EXPLAIN** - Shows query execution plan
- **LOCK** - Explicitly locks a table
- **REFRESH MATERIALIZED VIEW** - Refreshes a materialized view
- **VACUUM** *(Redshift-enhanced)* - Reclaims space and sorts rows

### Session and Configuration Commands
- **RESET** - Resets a configuration parameter
- **SET** - Sets a configuration parameter
- **SET SESSION AUTHORIZATION** - Changes session user
- **SET SESSION CHARACTERISTICS** - Sets transaction characteristics
- **USE** *(Redshift-specific)* - Sets the current database

### Procedural Commands
- **CALL** - Executes a stored procedure
- **CLOSE** - Closes a cursor
- **DEALLOCATE** - Deallocates a prepared statement
- **DECLARE** - Declares a cursor
- **EXECUTE** - Executes a prepared statement
- **FETCH** - Retrieves rows from a cursor
- **PREPARE** - Prepares a statement for execution

### Informational Commands (SHOW and DESC)
- **DESC DATASHARE** *(Redshift-specific)* - Describes a datashare
- **DESC IDENTITY PROVIDER** *(Redshift-specific)* - Describes an identity provider
- **SHOW** *(Redshift-specific)* - Shows configuration parameters
- **SHOW COLUMNS** *(Redshift-specific)* - Shows table columns
- **SHOW DATABASES** *(Redshift-specific)* - Shows databases
- **SHOW GRANTS** *(Redshift-specific)* - Shows access privileges
- **SHOW MODEL** *(Redshift-specific)* - Shows model details
- **SHOW PROCEDURE** *(Redshift-specific)* - Shows stored procedure details
- **SHOW SCHEMAS** *(Redshift-specific)* - Shows schemas
- **SHOW TABLES** *(Redshift-specific)* - Shows tables
- **SHOW VIEW** *(Redshift-specific)* - Shows view definition

### Security Policy Commands
- **ATTACH MASKING POLICY** *(Redshift-specific)* - Attaches a masking policy to a column
- **ATTACH RLS POLICY** *(Redshift-specific)* - Attaches a row-level security policy
- **DETACH MASKING POLICY** *(Redshift-specific)* - Detaches a masking policy
- **DETACH RLS POLICY** *(Redshift-specific)* - Detaches a row-level security policy

## Notes

1. Commands marked as *(Redshift-specific)* are unique to Amazon Redshift or have significant differences from PostgreSQL
2. Commands marked as *(Redshift-enhanced)* exist in PostgreSQL but have additional features in Redshift
3. Amazon Redshift is based on PostgreSQL 8.0.2 but has evolved significantly with its own features
4. Python UDF support will be deprecated starting November 1, 2025

## Total Command Count: 95 SQL commands