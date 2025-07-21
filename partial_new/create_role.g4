// CREATE ROLE command grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_ROLE.html

createRoleStatement
    : CREATE ROLE roleName=identifier (EXTERNALID externalId=stringLiteral)?
    ;

identifier
    : IDENTIFIER
    | quotedIdentifier
    ;

quotedIdentifier
    : QUOTED_IDENTIFIER
    ;

stringLiteral
    : STRING_LITERAL
    ;

// Keywords
CREATE : C R E A T E ;
ROLE : R O L E ;
EXTERNALID : E X T E R N A L I D ;

// Lexer tokens
IDENTIFIER
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

QUOTED_IDENTIFIER
    : '"' ( ~'"' | '""' )* '"'
    ;

STRING_LITERAL
    : '\'' ( ~'\'' | '\'\'' )* '\''
    ;

WS : [ \t\r\n]+ -> skip ;

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