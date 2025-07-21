// ALTER GROUP grammar rules for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_GROUP.html

grammar AlterGroup;

// Main rule for ALTER GROUP statement
alterGroupStatement
    : ALTER GROUP groupName=identifier (
        addUserClause
        | dropUserClause
        | renameToClause
    )
    ;

// ADD USER clause - adds one or more users to a group
addUserClause
    : ADD USER userList
    ;

// DROP USER clause - removes one or more users from a group
dropUserClause
    : DROP USER userList
    ;

// RENAME TO clause - renames the group
renameToClause
    : RENAME TO newName=identifier
    ;

// List of users (comma-separated)
userList
    : identifier (',' identifier)*
    ;

// Identifier rule for names
identifier
    : IDENTIFIER
    | DOUBLE_QUOTED_STRING
    | keyword
    ;

// Keywords that can be used as identifiers
keyword
    : ALTER | GROUP | ADD | DROP | USER | RENAME | TO
    ;

// Lexer rules
ALTER : A L T E R;
GROUP : G R O U P;
ADD : A D D;
DROP : D R O P;
USER : U S E R;
RENAME : R E N A M E;
TO : T O;

// Identifier pattern
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_$]*
    ;

// Double-quoted string for identifiers
DOUBLE_QUOTED_STRING
    : '"' (~["])* '"'
    ;

// Whitespace and comments
WS : [ \t\r\n]+ -> skip;
SINGLE_LINE_COMMENT : '--' ~[\r\n]* -> skip;
MULTI_LINE_COMMENT : '/*' .*? '*/' -> skip;

// Case-insensitive lexer fragments
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