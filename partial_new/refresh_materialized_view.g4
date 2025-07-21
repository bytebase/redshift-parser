// REFRESH MATERIALIZED VIEW command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/materialized-view-refresh-sql-command.html

refreshMaterializedViewStmt
    : REFRESH MATERIALIZED VIEW qualifiedName refreshOption?
    ;

refreshOption
    : RESTRICT
    | CASCADE
    ;

// Common elements (these would be shared with other grammar files)
qualifiedName
    : (schemaName DOT)? identifier
    ;

schemaName
    : identifier
    ;

identifier
    : IDENTIFIER
    | nonReservedWord
    | quotedIdentifier
    ;

quotedIdentifier
    : DOUBLE_QUOTE_ID
    ;

nonReservedWord
    : REFRESH | MATERIALIZED | VIEW | RESTRICT | CASCADE
    ;

// Keywords (these would typically be defined in the lexer)
REFRESH: 'REFRESH';
MATERIALIZED: 'MATERIALIZED';
VIEW: 'VIEW';
RESTRICT: 'RESTRICT';
CASCADE: 'CASCADE';

// Common tokens
DOT: '.';
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
DOUBLE_QUOTE_ID: '"' (~["])+ '"';