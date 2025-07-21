grammar show_tables;

// Parser rules
showTablesStmt
    : SHOW TABLES FROM SCHEMA databaseName=identifier DOT schemaName=identifier
      (LIKE pattern=stringLiteral)?
      (LIMIT limitValue=INTEGERLITERAL)?
    ;

// Common rules
identifier
    : IDENTIFIER
    | unreservedKeyword
    ;

unreservedKeyword
    : SHOW | TABLES | FROM | SCHEMA | LIKE | LIMIT
    ;

stringLiteral
    : STRINGLITERAL
    ;

// Lexer rules
SHOW : [Ss][Hh][Oo][Ww];
TABLES : [Tt][Aa][Bb][Ll][Ee][Ss];
FROM : [Ff][Rr][Oo][Mm];
SCHEMA : [Ss][Cc][Hh][Ee][Mm][Aa];
LIKE : [Ll][Ii][Kk][Ee];
LIMIT : [Ll][Ii][Mm][Ii][Tt];

// Basic tokens
DOT : '.';
IDENTIFIER
    : [A-Za-z_][A-Za-z0-9_]*
    | '"' (~["])+ '"'
    ;

INTEGERLITERAL
    : [0-9]+
    ;

STRINGLITERAL
    : '\'' (~['\r\n] | '\'\'')* '\''
    ;

// Skip whitespace and comments
WS : [ \t\r\n]+ -> skip;
COMMENT : '--' ~[\r\n]* -> skip;
BLOCK_COMMENT : '/*' .*? '*/' -> skip;