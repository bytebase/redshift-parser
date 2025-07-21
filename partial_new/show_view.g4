grammar show_view;

// SHOW VIEW command - Shows the definition of a view
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_SHOW_VIEW.html

// Parser rules
showViewStmt
    : SHOW VIEW viewName
    ;

viewName
    : (schemaName=identifier DOT)? name=identifier
    ;

// Common rules
identifier
    : IDENTIFIER
    | unreservedKeyword
    ;

unreservedKeyword
    : SHOW | VIEW
    ;

// Lexer rules
SHOW : [Ss][Hh][Oo][Ww];
VIEW : [Vv][Ii][Ee][Ww];

// Basic tokens
DOT : '.';
IDENTIFIER
    : [A-Za-z_][A-Za-z0-9_]*
    | '"' (~["])+ '"'
    ;

// Skip whitespace and comments
WS : [ \t\r\n]+ -> skip;
COMMENT : '--' ~[\r\n]* -> skip;
BLOCK_COMMENT : '/*' .*? '*/' -> skip;