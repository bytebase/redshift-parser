// CREATE LIBRARY command grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_LIBRARY.html

grammar CreateLibrary;

// Main CREATE LIBRARY statement
createLibraryStatement
    : CREATE (OR REPLACE)? LIBRARY libraryName 
      LANGUAGE PLPYTHONU 
      FROM librarySource
      (authorization)?
      (regionClause)?
      iamRoleClause
    ;

// Library name
libraryName
    : identifier
    ;

// Library source - HTTP/HTTPS URL or S3 path
librarySource
    : stringLiteral
    ;

// Optional authorization clause (for backwards compatibility)
authorization
    : CREDENTIALS stringLiteral
    ;

// Optional region specification
regionClause
    : REGION (AS)? stringLiteral
    ;

// IAM role specification (required)
iamRoleClause
    : IAM_ROLE (DEFAULT | stringLiteral)
    ;

// Basic tokens and identifiers
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
CREATE          : C R E A T E ;
OR              : O R ;
REPLACE         : R E P L A C E ;
LIBRARY         : L I B R A R Y ;
LANGUAGE        : L A N G U A G E ;
PLPYTHONU       : P L P Y T H O N U ;
FROM            : F R O M ;
CREDENTIALS     : C R E D E N T I A L S ;
REGION          : R E G I O N ;
AS              : A S ;
IAM_ROLE        : I A M '_' R O L E ;
DEFAULT         : D E F A U L T ;

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

// Character fragments for case-insensitive keywords
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