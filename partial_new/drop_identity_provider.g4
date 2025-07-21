/*
 * DROP IDENTITY PROVIDER command grammar for Amazon Redshift
 * 
 * Supports:
 * - DROP IDENTITY PROVIDER identity_provider_name
 * - DROP IDENTITY PROVIDER identity_provider_name CASCADE
 * 
 * Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_DROP_IDENTITY_PROVIDER.html
 */

grammar DropIdentityProvider;

// Main rule for DROP IDENTITY PROVIDER statement
dropIdentityProviderStmt
    : DROP IDENTITY PROVIDER identity_provider_name cascadeClause? ';'?
    ;

// CASCADE clause (optional)
cascadeClause
    : CASCADE
    ;

// Identity provider name - can be a simple identifier or quoted identifier
identity_provider_name
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
    : IDENTITY
    | PROVIDER
    | OAUTH
    | SAML
    | AZURE
    | OKTA
    | AUTH
    ;

// Lexer tokens
DROP : D R O P ;
IDENTITY : I D E N T I T Y ;
PROVIDER : P R O V I D E R ;
CASCADE : C A S C A D E ;

// Common keyword tokens for identifiers
OAUTH : O A U T H ;
SAML : S A M L ;
AZURE : A Z U R E ;
OKTA : O K T A ;
AUTH : A U T H ;

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