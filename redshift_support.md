# Redshift Parser Implementation Plan

## Overview
This document outlines the plan to extend the PostgreSQL parser to fully support Amazon Redshift SQL syntax and features. The implementation will maintain compatibility with existing PostgreSQL parsing while adding Redshift-specific capabilities.

**IMPORTANT**: The AWS Redshift documentation at https://docs.aws.amazon.com/redshift/latest/dg/c_SQL_commands.html is the source of truth for all syntax implementation. Each feature must be implemented exactly as documented on the official pages.

## Implementation Phases

### Phase 1: Core DDL Support
Focus on fundamental table creation and modification commands that differ from PostgreSQL.

#### 1.1 CREATE TABLE Extensions
**Reference**: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_TABLE_NEW.html
- Implement all syntax variations from the official documentation
- Extract and test all examples from the documentation page
- Pay special attention to Redshift-specific clauses

#### 1.2 ALTER TABLE Extensions  
**Reference**: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_TABLE.html
- Follow the complete syntax diagram from AWS documentation
- Support all ALTER TABLE variations specific to Redshift

#### 1.3 CREATE EXTERNAL TABLE
**Reference**: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_EXTERNAL_TABLE.html
- Implement full external table syntax as documented
- Support all file formats and table properties listed

### Phase 2: Redshift-Specific DML
#### 2.1 COPY Command
**Reference**: https://docs.aws.amazon.com/redshift/latest/dg/r_COPY.html
- Implement complete COPY syntax from the official documentation
- Support all source types, formats, and options as specified

#### 2.2 UNLOAD Command
**Reference**: https://docs.aws.amazon.com/redshift/latest/dg/r_UNLOAD.html
- Follow the exact syntax specification from AWS
- Implement all options and parameters

#### 2.3 VACUUM and ANALYZE
**References**: 
- VACUUM: https://docs.aws.amazon.com/redshift/latest/dg/r_VACUUM_command.html
- ANALYZE: https://docs.aws.amazon.com/redshift/latest/dg/r_ANALYZE.html
- Implement both commands exactly as documented

### Phase 3: Redshift-Specific SQL Functions
**Reference**: https://docs.aws.amazon.com/redshift/latest/dg/c_SQL_functions.html
- Implement functions listed in the SQL functions reference
- Each function category has its own documentation page
- Window functions: https://docs.aws.amazon.com/redshift/latest/dg/c_Window_functions.html
- Date functions: https://docs.aws.amazon.com/redshift/latest/dg/Date_functions_header.html
- String functions: https://docs.aws.amazon.com/redshift/latest/dg/String_functions_header.html

### Phase 4: Advanced Features
#### 4.1 Materialized Views
**Reference**: https://docs.aws.amazon.com/redshift/latest/dg/materialized-view-overview.html
- CREATE MATERIALIZED VIEW: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_MATERIALIZED_VIEW.html
- REFRESH MATERIALIZED VIEW: https://docs.aws.amazon.com/redshift/latest/dg/r_REFRESH_MATERIALIZED_VIEW.html

#### 4.2 Stored Procedures
**Reference**: https://docs.aws.amazon.com/redshift/latest/dg/stored-procedure-overview.html
- CREATE PROCEDURE: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_PROCEDURE.html

#### 4.3 User-Defined Functions (UDFs)
**Reference**: https://docs.aws.amazon.com/redshift/latest/dg/user-defined-functions.html
- CREATE FUNCTION: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_FUNCTION.html

### Phase 5: System and Administration
#### 5.1 User and Permission Management
**References**:
- CREATE USER: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_USER.html
- CREATE GROUP: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_GROUP.html
- GRANT: https://docs.aws.amazon.com/redshift/latest/dg/r_GRANT.html
- ALTER DEFAULT PRIVILEGES: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_DEFAULT_PRIVILEGES.html

#### 5.2 Data Sharing
**Reference**: https://docs.aws.amazon.com/redshift/latest/dg/datashare-overview.html
- CREATE DATASHARE: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_DATASHARE.html
- ALTER DATASHARE: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_DATASHARE.html

## Implementation Strategy

### 1. Grammar Organization
```
RedshiftParser.g4 structure:
- Maintain PostgreSQL compatibility in base rules
- Add Redshift-specific alternatives using engine detection
- Use semantic predicates for engine-specific parsing
```

### 2. Token Naming Convention
- Follow existing PostgreSQL token names where possible
- Prefix Redshift-specific tokens with `RS_` if no PostgreSQL equivalent
- Maintain consistency with current naming patterns

### 3. Testing Approach
For each feature:
1. Extract examples from AWS documentation
2. Create test files in `examples/redshift/[feature]/`
3. Add positive test cases (should parse)
4. Add negative test cases (should fail)
5. Test both Redshift and PostgreSQL modes

### 4. Example Test Structure
```
examples/
├── redshift/
│   ├── create_table/
│   │   ├── identity_columns.sql
│   │   ├── distribution_keys.sql
│   │   ├── sort_keys.sql
│   │   └── encoding.sql
│   ├── copy/
│   │   ├── copy_from_s3.sql
│   │   ├── copy_formats.sql
│   │   └── copy_options.sql
│   └── ...
```

## Priority Order
1. **High Priority**: DDL (CREATE/ALTER TABLE) with Redshift-specific options
2. **High Priority**: COPY/UNLOAD commands (critical for data loading)
3. **Medium Priority**: Redshift-specific functions and expressions
4. **Medium Priority**: VACUUM/ANALYZE commands
5. **Low Priority**: Advanced features (procedures, UDFs, data sharing)

## Success Criteria
- All Redshift SQL commands from AWS documentation parse successfully
- PostgreSQL compatibility is maintained
- Engine-specific parsing works correctly
- Comprehensive test coverage for each feature
- Performance benchmarks show acceptable parsing speed

## Reference Documentation
Primary reference: https://docs.aws.amazon.com/redshift/latest/dg/c_SQL_commands.html

Key sections:
- SQL Commands: Complete command reference
- SQL Functions: Built-in function documentation
- Data Types: Redshift-specific type support
- System Tables: Catalog and monitoring tables