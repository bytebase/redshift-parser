// COMMENT command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_COMMENT.html

commentStatement
    : COMMENT ON commentObject IS commentValue
    ;

commentObject
    : TABLE objectName                                      // COMMENT ON TABLE table_name
    | COLUMN objectName DOT columnName                      // COMMENT ON COLUMN table_name.column_name  
    | CONSTRAINT constraintName ON objectName               // COMMENT ON CONSTRAINT constraint_name ON table_name
    | DATABASE objectName                                   // COMMENT ON DATABASE database_name
    | VIEW objectName                                       // COMMENT ON VIEW view_name
    | SCHEMA objectName                                     // COMMENT ON SCHEMA schema_name
    ;

commentValue
    : STRING_LITERAL                                        // 'comment text'
    | NULL                                                  // NULL to remove comment
    ;

objectName
    : identifier
    | identifier DOT identifier                             // schema.object_name
    ;

columnName
    : identifier
    ;

constraintName
    : identifier
    ;

identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    ;

// Keywords (these would typically be defined in the lexer)
COMMENT: 'COMMENT';
ON: 'ON';
IS: 'IS';
TABLE: 'TABLE';
COLUMN: 'COLUMN';
CONSTRAINT: 'CONSTRAINT';
DATABASE: 'DATABASE';
VIEW: 'VIEW';
SCHEMA: 'SCHEMA';
NULL: 'NULL';
DOT: '.';

// Literals
STRING_LITERAL: '\'' (~'\'' | '\'\'')* '\'';
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
QUOTED_IDENTIFIER: '"' (~'"' | '""')* '"';

// Whitespace
WS: [ \t\r\n]+ -> skip;