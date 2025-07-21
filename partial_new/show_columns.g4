// SHOW COLUMNS command - Shows information about table columns
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_SHOW_COLUMNS.html

showColumnsStmt
    : SHOW COLUMNS FROM TABLE showColumnsTableName showColumnsLikeClause? showColumnsLimitClause?
    ;

showColumnsTableName
    : tableName                                           // table_name
    | databaseName DOT tableName                         // database_name.table_name  
    | databaseName DOT schemaName DOT tableName         // database_name.schema_name.table_name
    ;

showColumnsLikeClause
    : LIKE filterPattern
    ;

showColumnsLimitClause
    : LIMIT rowLimit
    ;

tableName
    : identifier
    ;

databaseName
    : identifier
    ;

schemaName
    : identifier
    ;

filterPattern
    : STRING_LITERAL
    ;

rowLimit
    : INTEGRAL_LITERAL
    ;

// Tokens that need to be added to RedshiftLexer.g4 if not already present:
// SHOW: 'SHOW';
// COLUMNS: 'COLUMNS';
// FROM: 'FROM';
// TABLE: 'TABLE';
// LIKE: 'LIKE';
// LIMIT: 'LIMIT';
// DOT: '.';
// STRING_LITERAL: single-quoted string
// INTEGRAL_LITERAL: integer number