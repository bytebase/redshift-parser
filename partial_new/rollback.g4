// rollback.g4
// Grammar for ROLLBACK command in Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_ROLLBACK.html

grammar rollback;

// Parser rule for ROLLBACK statement
rollbackStmt
    : ROLLBACK (WORK | TRANSACTION)?
    ;

// Lexer rules
ROLLBACK     : R O L L B A C K;
WORK         : W O R K;
TRANSACTION  : T R A N S A C T I O N;

// Whitespace
WS : [ \t\r\n]+ -> skip;

// Case-insensitive letter fragments
fragment A : [aA];
fragment B : [bB];
fragment C : [cC];
fragment K : [kK];
fragment L : [lL];
fragment N : [nN];
fragment O : [oO];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment W : [wW];