/*
 * DROP DATASHARE command grammar for Amazon Redshift
 * 
 * Supports:
 * - DROP DATASHARE datashare_name
 * - DROP DATASHARE IF EXISTS datashare_name
 * 
 * Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_DROP_DATASHARE.html
 */

grammar DropDatashare;

// Main rule for DROP DATASHARE statement
dropDatashareStmt
    : DROP DATASHARE ifExists? datashare_name ';'?
    ;

// IF EXISTS clause
ifExists
    : IF EXISTS
    ;

// Datashare name - can be a simple identifier or quoted identifier
datashare_name
    : identifier
    ;

// Identifier rule - supports simple names and quoted names
identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    | unreserved_keyword
    ;

// Common unreserved keywords that can be used as identifiers
unreserved_keyword
    : DATASHARE
    | SALESSHARE
    | MYSHARE
    | SHARE
    | DATA
    ;

// Lexer tokens
DROP : D R O P ;
DATASHARE : D A T A S H A R E ;
IF : I F ;
EXISTS : E X I S T S ;

// Common keyword tokens for identifiers
SALESSHARE : S A L E S S H A R E ;
MYSHARE : M Y S H A R E ;
SHARE : S H A R E ;
DATA : D A T A ;

// Basic identifier tokens
IDENTIFIER : [a-zA-Z_][a-zA-Z0-9_$]* ;
QUOTED_IDENTIFIER : '"' (~["\r\n] | '""')* '"' ;

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

// Whitespace and comments
WS : [ \t\r\n]+ -> skip ;
LINE_COMMENT : '--' ~[\r\n]* -> skip ;
BLOCK_COMMENT : '/*' .*? '*/' -> skip ;

// Semicolon
SEMICOLON : ';' ;