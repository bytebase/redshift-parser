grammar Abort;

// Parser rule for ABORT statement
// ABORT stops the current transaction and is equivalent to ROLLBACK
// Syntax: ABORT [ WORK | TRANSACTION ]
abortStatement
    : ABORT (WORK | TRANSACTION)?
    ;

// Lexer rules
ABORT        : A B O R T;
WORK         : W O R K;
TRANSACTION  : T R A N S A C T I O N;

// Case-insensitive letter fragments
fragment A : [aA];
fragment B : [bB];
fragment O : [oO];
fragment R : [rR];
fragment T : [tT];
fragment W : [wW];
fragment C : [cC];
fragment I : [iI];
fragment N : [nN];
fragment S : [sS];
fragment K : [kK];

// Whitespace
WS : [ \t\r\n]+ -> skip;