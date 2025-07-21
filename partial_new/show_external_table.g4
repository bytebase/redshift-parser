// SHOW EXTERNAL TABLE command grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_SHOW_EXTERNAL_TABLE.html

grammar show_external_table;

// Parser rule for SHOW EXTERNAL TABLE statement
showExternalTableStatement
    : SHOW EXTERNAL TABLE externalTableName partition?
    ;

// External table name with optional database and required schema
externalTableName
    : (identifier DOT)? identifier DOT identifier  // [database.]schema.table
    ;

// Optional PARTITION keyword
partition
    : PARTITION
    ;

// Identifiers
identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    | keyword
    ;

// Keywords that can be used as identifiers
keyword
    : SHOW
    | EXTERNAL
    | TABLE
    | PARTITION
    ;

// Lexer rules
SHOW      : S H O W;
EXTERNAL  : E X T E R N A L;
TABLE     : T A B L E;
PARTITION : P A R T I T I O N;

// Identifier rules
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

QUOTED_IDENTIFIER
    : '"' (~["])+ '"'
    ;

// Punctuation
DOT : '.';

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