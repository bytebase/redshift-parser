// CREATE GROUP statement grammar for Redshift
// Based on: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_GROUP.html

grammar CreateGroup;

// Parser rules
createGroupStatement
    : CREATE GROUP groupName (withUserClause)?
    ;

withUserClause
    : (WITH)? USER userList
    ;

userList
    : userName (',' userName)*
    ;

groupName
    : identifier
    ;

userName
    : identifier
    ;

identifier
    : IDENTIFIER
    | nonReservedKeyword
    ;

nonReservedKeyword
    : CREATE
    | GROUP
    | WITH
    | USER
    ;

// Lexer rules
CREATE : C R E A T E;
GROUP  : G R O U P;
WITH   : W I T H;
USER   : U S E R;

IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

COMMA  : ',';

// Whitespace and comments
WS     : [ \t\r\n]+ -> skip;
COMMENT: '--' ~[\r\n]* -> skip;

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