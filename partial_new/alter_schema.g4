// ALTER SCHEMA grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_SCHEMA.html

alterSchemaStatement
    : ALTER SCHEMA schemaName=identifier alterSchemaAction
    ;

alterSchemaAction
    : RENAME TO newName=identifier
    | OWNER TO newOwner=identifier
    | QUOTA quotaSpec
    ;

quotaSpec
    : quotaAmount=INTEGER? quotaUnit?
    | UNLIMITED
    ;

quotaUnit
    : MB
    | GB
    | TB
    ;

// Common identifier rule
identifier
    : IDENTIFIER
    | quotedIdentifier
    | nonReservedKeyword
    ;

quotedIdentifier
    : QUOTED_IDENTIFIER
    ;

nonReservedKeyword
    : ALTER | SCHEMA | RENAME | TO | OWNER | QUOTA | UNLIMITED | MB | GB | TB
    ;

// Lexer rules
ALTER       : A L T E R ;
SCHEMA      : S C H E M A ;
RENAME      : R E N A M E ;
TO          : T O ;
OWNER       : O W N E R ;
QUOTA       : Q U O T A ;
UNLIMITED   : U N L I M I T E D ;
MB          : M B ;
GB          : G B ;
TB          : T B ;

// Basic tokens
IDENTIFIER
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

QUOTED_IDENTIFIER
    : '"' (~["])+ '"'
    ;

INTEGER
    : [0-9]+
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

// Whitespace and comments
WS
    : [ \t\r\n]+ -> skip
    ;

COMMENT
    : '--' ~[\r\n]* -> skip
    ;

MULTILINE_COMMENT
    : '/*' .*? '*/' -> skip
    ;