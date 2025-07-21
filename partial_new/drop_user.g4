/*
Amazon Redshift DROP USER Command Grammar
Syntax: DROP USER [ IF EXISTS ] name [, ... ]

Based on AWS documentation:
https://docs.aws.amazon.com/redshift/latest/dg/r_DROP_USER.html

This command drops database users. Key features:
- Optional IF EXISTS clause to prevent errors
- Support for dropping multiple users in one statement
- Restrictions on dropping special users (rdsdb, database administrator)
- Cannot drop users who own objects or have privileges
*/

grammar DropUser;

// Main rule for DROP USER statement
dropUserStatement
    : DROP USER ifExists? userNameList
    ;

// Optional IF EXISTS clause
ifExists
    : IF EXISTS
    ;

// List of user names to drop (comma-separated)
userNameList
    : userName (COMMA userName)*
    ;

// User name - can be identifier or quoted identifier
userName
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    ;

// Lexer tokens
DROP        : D R O P ;
USER        : U S E R ;
IF          : I F ;
EXISTS      : E X I S T S ;
COMMA       : ',' ;

// Identifiers
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_$]*
    ;

QUOTED_IDENTIFIER
    : '"' (~["\r\n] | '""')* '"'
    ;

// Case-insensitive letters
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