/*
 * EXECUTE command grammar for Amazon Redshift
 * 
 * Executes a prepared statement that was previously created using the PREPARE command.
 * 
 * Syntax:
 * EXECUTE plan_name [ (parameter [, ...]) ]
 * 
 * Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_EXECUTE.html
 */

grammar execute;

// Main EXECUTE statement rule
executeStmt
    : EXECUTE plan_name=IDENTIFIER (LPAREN parameter_list RPAREN)?
    ;

// Parameter list for the prepared statement
parameter_list
    : parameter (COMMA parameter)*
    ;

// Individual parameter - can be various types of values
parameter
    : literal_value
    | IDENTIFIER
    | bind_parameter
    ;

// Literal values that can be used as parameters
literal_value
    : STRING_LITERAL
    | NUMERIC_LITERAL
    | BOOLEAN_LITERAL
    | NULL
    ;

// Bind parameter (e.g., $1, $2)
bind_parameter
    : DOLLAR NUMERIC_LITERAL
    ;

// Tokens
EXECUTE         : E X E C U T E ;
NULL            : N U L L ;
TRUE            : T R U E ;
FALSE           : F A L S E ;

IDENTIFIER      : [a-zA-Z_][a-zA-Z0-9_]* ;
STRING_LITERAL  : '\'' (~'\'' | '\'\'')* '\'' ;
NUMERIC_LITERAL : [0-9]+ ('.' [0-9]+)? ([eE] [+-]? [0-9]+)? ;
BOOLEAN_LITERAL : TRUE | FALSE ;

LPAREN          : '(' ;
RPAREN          : ')' ;
COMMA           : ',' ;
DOLLAR          : '$' ;

// Case-insensitive character fragments
fragment A : [aA] ;
fragment B : [bB] ;
fragment C : [cC] ;
fragment D : [dD] ;
fragment E : [eE] ;
fragment F : [fF] ;
fragment G : [gG] ;
fragment H : [hH] ;
fragment I : [iI] ;
fragment J : [jJ] ;
fragment K : [kK] ;
fragment L : [lL] ;
fragment M : [mM] ;
fragment N : [nN] ;
fragment O : [oO] ;
fragment P : [pP] ;
fragment Q : [qQ] ;
fragment R : [rR] ;
fragment S : [sS] ;
fragment T : [tT] ;
fragment U : [uU] ;
fragment V : [vV] ;
fragment W : [wW] ;
fragment X : [xX] ;
fragment Y : [yY] ;
fragment Z : [zZ] ;

// Whitespace handling
WS : [ \t\r\n]+ -> skip ;