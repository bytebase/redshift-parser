/*
 * DROP MASKING POLICY command grammar for Amazon Redshift
 * 
 * Supports:
 * - DROP MASKING POLICY policy_name
 * 
 * Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_DROP_MASKING_POLICY.html
 */

grammar DropMaskingPolicy;

// Main rule for DROP MASKING POLICY statement
dropMaskingPolicyStmt
    : DROP MASKING POLICY policy_name ';'?
    ;

// Policy name - can be a simple identifier or quoted identifier
policy_name
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
    : MASKING
    | POLICY
    | DATA
    | MASK
    | SECURITY
    ;

// Lexer tokens
DROP : D R O P ;
MASKING : M A S K I N G ;
POLICY : P O L I C Y ;

// Common keyword tokens for identifiers
DATA : D A T A ;
MASK : M A S K ;
SECURITY : S E C U R I T Y ;

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