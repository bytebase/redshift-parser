grammar drop_model;

// DROP MODEL Statement
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_DROP_MODEL.html
//
// Syntax:
// DROP MODEL [ IF EXISTS ] model_name

drop_model_stmt:
    DROP MODEL if_exists? qualified_name
    ;

if_exists:
    IF EXISTS
    ;

qualified_name:
    (schema_name DOT)? model_name
    ;

schema_name:
    identifier
    ;

model_name:
    identifier
    ;

identifier:
    ID
    | QUOTED_ID
    | keyword_as_identifier
    ;

keyword_as_identifier:
    MODEL
    | IF
    | EXISTS
    | DROP
    ;

// Tokens
DROP: D R O P;
MODEL: M O D E L;
IF: I F;
EXISTS: E X I S T S;
DOT: '.';

ID: [a-zA-Z_] [a-zA-Z0-9_$]*;
QUOTED_ID: '"' (~["\r\n] | '""')* '"';

// Case-insensitive alphabet fragments
fragment A: [aA];
fragment B: [bB];
fragment C: [cC];
fragment D: [dD];
fragment E: [eE];
fragment F: [fF];
fragment G: [gG];
fragment H: [hH];
fragment I: [iI];
fragment J: [jJ];
fragment K: [kK];
fragment L: [lL];
fragment M: [mM];
fragment N: [nN];
fragment O: [oO];
fragment P: [pP];
fragment Q: [qQ];
fragment R: [rR];
fragment S: [sS];
fragment T: [tT];
fragment U: [uU];
fragment V: [vV];
fragment W: [wW];
fragment X: [xX];
fragment Y: [yY];
fragment Z: [zZ];

// Skip whitespace and comments
WS: [ \t\r\n]+ -> skip;
LINE_COMMENT: '--' ~[\r\n]* -> skip;
BLOCK_COMMENT: '/*' .*? '*/' -> skip;