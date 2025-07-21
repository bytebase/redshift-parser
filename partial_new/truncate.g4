// TRUNCATE command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_TRUNCATE.html

truncateStmt
    : TRUNCATE TABLE? tableName
    | TRUNCATE materializedViewName
    ;

tableName
    : identifier
    ;

materializedViewName
    : identifier
    ;

identifier
    : IDENTIFIER
    | quotedIdentifier
    ;

quotedIdentifier
    : DOUBLE_QUOTE_ID
    ;

// Keywords (these would typically be defined in the lexer)
TRUNCATE: 'TRUNCATE';
TABLE: 'TABLE';

// Identifiers
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
DOUBLE_QUOTE_ID: '"' (~'"' | '""')* '"';

// Whitespace
WS: [ \t\r\n]+ -> skip;