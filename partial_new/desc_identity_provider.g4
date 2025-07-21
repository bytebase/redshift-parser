// DESC IDENTITY PROVIDER command grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_DESC_IDENTITY_PROVIDER.html

grammar desc_identity_provider;

// Main rule for DESC IDENTITY PROVIDER statement
desc_identity_provider_stmt
    : (DESC | DESCRIBE) IDENTITY PROVIDER identity_provider_name
    ;

// Identity provider name - can be an identifier
identity_provider_name
    : identifier
    ;

// Basic identifier rule
identifier
    : IDENTIFIER
    | quoted_identifier
    ;

quoted_identifier
    : QUOTED_IDENTIFIER
    ;

// Lexer tokens
DESC            : D E S C ;
DESCRIBE        : D E S C R I B E ;
IDENTITY        : I D E N T I T Y ;
PROVIDER        : P R O V I D E R ;

IDENTIFIER      : [a-zA-Z_][a-zA-Z0-9_$]* ;
QUOTED_IDENTIFIER : '"' (~["\r\n] | '""')* '"' ;

// Whitespace and comments
WS              : [ \t\r\n]+ -> skip ;
LINE_COMMENT    : '--' ~[\r\n]* -> skip ;
BLOCK_COMMENT   : '/*' .*? '*/' -> skip ;

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