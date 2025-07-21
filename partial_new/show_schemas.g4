// SHOW SCHEMAS grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_SHOW_SCHEMAS.html

grammar show_schemas;

// Main rule for SHOW SCHEMAS statement
showSchemasStatement
    : SHOW SCHEMAS showSchemasFromClause showSchemasLikeClause? showSchemasLimitClause?
    ;

// FROM DATABASE clause - required
showSchemasFromClause
    : FROM DATABASE databaseName
    ;

// Database name (can be regular database or 'awsdatacatalog')
databaseName
    : identifier
    | AWSDATACATALOG
    ;

// LIKE clause for pattern matching
showSchemasLikeClause
    : LIKE STRING_LITERAL
    ;

// LIMIT clause to restrict results
showSchemasLimitClause
    : LIMIT NUMBER_LITERAL
    ;

// Identifier for database names
identifier
    : IDENTIFIER
    | nonReservedWord
    ;

// Non-reserved words that can be used as identifiers
nonReservedWord
    : DATABASE
    | SCHEMAS
    ;

// Lexer rules
SHOW             : S H O W ;
SCHEMAS          : S C H E M A S ;
FROM             : F R O M ;
DATABASE         : D A T A B A S E ;
LIKE             : L I K E ;
LIMIT            : L I M I T ;
AWSDATACATALOG   : A W S D A T A C A T A L O G ;

// Identifier
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*
    | '"' (~["\r\n] | '""')* '"'
    ;

// String literal for patterns
STRING_LITERAL
    : '\'' (~['\r\n] | '\'\'')* '\''
    ;

// Number literal for LIMIT
NUMBER_LITERAL
    : [0-9]+
    ;

// Whitespace
WS
    : [ \t\r\n]+ -> skip
    ;

// Single-line comment
SINGLE_LINE_COMMENT
    : '--' ~[\r\n]* -> skip
    ;

// Multi-line comment
MULTI_LINE_COMMENT
    : '/*' .*? '*/' -> skip
    ;

// Case-insensitive character matching
fragment A : [aA];
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment H : [hH];
fragment I : [iI];
fragment J : [jJ];
fragment K : [kK];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment Q : [qQ];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment V : [vV];
fragment W : [wW];
fragment X : [xX];
fragment Y : [yY];
fragment Z : [zZ];