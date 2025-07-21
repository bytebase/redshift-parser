/*
 * Grammar for CREATE IDENTITY PROVIDER command
 * 
 * Amazon Redshift CREATE IDENTITY PROVIDER statement creates identity providers 
 * for federated authentication with OAuth2 and IAM Identity Center providers.
 * 
 * Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_IDENTITY_PROVIDER.html
 */

grammar CreateIdentityProvider;

// Main CREATE IDENTITY PROVIDER statement
createIdentityProviderStmt
    : CREATE IDENTITY PROVIDER identityProviderName
      TYPE typeSpec
      NAMESPACE namespaceSpec
      parameterSpec?
      applicationArnSpec?
      iamRoleSpec?
      autoCreateRolesSpec?
    ;

// Identity provider name (can be quoted or unquoted)
identityProviderName
    : identifier
    | stringLiteral
    ;

// Type specification (OAUTH2, azure, AWSIDC, IAM_IDENTITY_CENTER)
typeSpec
    : OAUTH2
    | AZURE
    | AWSIDC
    | IAM_IDENTITY_CENTER
    ;

// Namespace specification
namespaceSpec
    : stringLiteral
    | identifier
    ;

// Parameters specification (JSON string for OAUTH2/azure)
parameterSpec
    : PARAMETERS stringLiteral
    ;

// Application ARN specification (required for AWSIDC/IAM_IDENTITY_CENTER)
applicationArnSpec
    : APPLICATION_ARN stringLiteral
    ;

// IAM Role specification (required for AWSIDC/IAM_IDENTITY_CENTER)
iamRoleSpec
    : IAM_ROLE stringLiteral
    ;

// Auto create roles specification
autoCreateRolesSpec
    : AUTO_CREATE_ROLES autoCreateRolesValue
    ;

autoCreateRolesValue
    : TRUE groupFilterSpec?
    | FALSE
    ;

groupFilterSpec
    : (INCLUDE | EXCLUDE) GROUPS LIKE stringLiteral
    ;

// Common elements
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
IDENTITY : I D E N T I T Y ;
PROVIDER : P R O V I D E R ;
TYPE : T Y P E ;
NAMESPACE : N A M E S P A C E ;
PARAMETERS : P A R A M E T E R S ;
APPLICATION_ARN : A P P L I C A T I O N '_' A R N ;
IAM_ROLE : I A M '_' R O L E ;
AUTO_CREATE_ROLES : A U T O '_' C R E A T E '_' R O L E S ;
TRUE : T R U E ;
FALSE : F A L S E ;
INCLUDE : I N C L U D E ;
EXCLUDE : E X C L U D E ;
GROUPS : G R O U P S ;
LIKE : L I K E ;

// Type values
OAUTH2 : O A U T H '2' ;
AZURE : A Z U R E ;
AWSIDC : A W S I D C ;
IAM_IDENTITY_CENTER : I A M '_' I D E N T I T Y '_' C E N T E R ;

// Identifiers and literals
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_$]*
    ;

QUOTED_IDENTIFIER
    : '"' (~["\r\n] | '""')* '"'
    ;

STRING_LITERAL
    : '\'' (~['\r\n] | '\'\'')* '\''
    ;

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
WS
    : [ \t\r\n]+ -> skip
    ;

LINE_COMMENT
    : '--' ~[\r\n]* -> skip
    ;

BLOCK_COMMENT
    : '/*' .*? '*/' -> skip
    ;