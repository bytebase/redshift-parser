grammar show_datashares;

// SHOW DATASHARES command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_SHOW_DATASHARES.html

showDatasharesStmt
    : SHOW DATASHARES (LIKE stringLiteral)?
    ;

// Keywords
SHOW        : S H O W;
DATASHARES  : D A T A S H A R E S;
LIKE        : L I K E;

// String literal
stringLiteral
    : SINGLE_QUOTED_STRING
    ;

// String token
SINGLE_QUOTED_STRING
    : '\'' ( ~('\'' | '\\') | ('\\' .) )* '\''
    ;

// Whitespace and comments
WS
    : [ \t\r\n]+ -> skip
    ;

COMMENT
    : '--' ~[\r\n]* -> skip
    ;

BLOCK_COMMENT
    : '/*' .*? '*/' -> skip
    ;

// Case-insensitive letter fragments
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