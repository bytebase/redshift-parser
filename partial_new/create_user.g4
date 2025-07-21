// CREATE USER command grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_USER.html

createUserStatement
    : CREATE USER userName=identifier 
      (WITH)? PASSWORD passwordOption
      userOption*
    ;

passwordOption
    : stringLiteral                           // Clear text password
    | MD5 md5Hash=stringLiteral              // MD5 hash
    | SHA256 sha256Hash=stringLiteral        // SHA-256 hash
    | DISABLE                                // Disable password for IAM
    ;

userOption
    : CREATEDB                               // Can create databases
    | NOCREATEDB                             // Cannot create databases (default)
    | CREATEUSER                             // Can create other users
    | NOCREATEUSER                           // Cannot create other users (default)
    | SYSLOG ACCESS accessLevel              // Syslog access level
    | IN GROUP groupName=identifier          // Add to group
    | VALID UNTIL validTime=stringLiteral    // Account expiration
    | CONNECTION LIMIT connectionLimit       // Connection limit
    | SESSION TIMEOUT sessionTimeout=integerLiteral  // Session timeout in seconds
    | EXTERNALID externalId=stringLiteral    // External identity provider ID
    ;

accessLevel
    : RESTRICTED                             // Restricted syslog access
    | UNRESTRICTED                           // Unrestricted syslog access
    ;

connectionLimit
    : integerLiteral                         // Specific number
    | UNLIMITED                              // No limit
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

integerLiteral
    : INTEGER_LITERAL
    ;

// Keywords
CREATE : C R E A T E ;
USER : U S E R ;
WITH : W I T H ;
PASSWORD : P A S S W O R D ;
MD5 : M D '5' ;
SHA256 : S H A '2' '5' '6' ;
DISABLE : D I S A B L E ;
CREATEDB : C R E A T E D B ;
NOCREATEDB : N O C R E A T E D B ;
CREATEUSER : C R E A T E U S E R ;
NOCREATEUSER : N O C R E A T E U S E R ;
SYSLOG : S Y S L O G ;
ACCESS : A C C E S S ;
RESTRICTED : R E S T R I C T E D ;
UNRESTRICTED : U N R E S T R I C T E D ;
IN : I N ;
GROUP : G R O U P ;
VALID : V A L I D ;
UNTIL : U N T I L ;
CONNECTION : C O N N E C T I O N ;
LIMIT : L I M I T ;
UNLIMITED : U N L I M I T E D ;
SESSION : S E S S I O N ;
TIMEOUT : T I M E O U T ;
EXTERNALID : E X T E R N A L I D ;

// Lexer tokens
IDENTIFIER
    : [a-zA-Z_] [a-zA-Z0-9_]*
    | [a-zA-Z_] [a-zA-Z0-9_]* ':' [a-zA-Z0-9_]+  // Support for external provider format like 'myco_aad:bob'
    ;

QUOTED_IDENTIFIER
    : '"' ( ~'"' | '""' )* '"'
    ;

STRING_LITERAL
    : '\'' ( ~'\'' | '\'\'' )* '\''
    ;

INTEGER_LITERAL
    : [0-9]+
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