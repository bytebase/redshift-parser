// VACUUM command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_VACUUM_command.html

grammar vacuum;

// Parser Rules
vacuumStmt
    : VACUUM vacuumOption? vacuumTarget?
    ;

vacuumOption
    : FULL
    | SORT ONLY
    | DELETE ONLY
    | REINDEX
    | RECLUSTER
    ;

vacuumTarget
    : tableName=identifier vacuumThreshold? vacuumBoost?
    | vacuumThreshold vacuumBoost?
    | vacuumBoost
    ;

vacuumThreshold
    : TO threshold=number PERCENT
    ;

vacuumBoost
    : BOOST
    ;

identifier
    : IDENTIFIER
    | quotedIdentifier
    ;

quotedIdentifier
    : QUOTED_IDENTIFIER
    ;

number
    : INTEGER
    | DECIMAL
    ;

// Lexer Rules
VACUUM      : V A C U U M ;
FULL        : F U L L ;
SORT        : S O R T ;
ONLY        : O N L Y ;
DELETE      : D E L E T E ;
REINDEX     : R E I N D E X ;
RECLUSTER   : R E C L U S T E R ;
TO          : T O ;
PERCENT     : P E R C E N T ;
BOOST       : B O O S T ;

// Identifiers and numbers
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

QUOTED_IDENTIFIER
    : '"' (~["])+ '"'
    ;

INTEGER
    : [0-9]+
    ;

DECIMAL
    : [0-9]+ '.' [0-9]+
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