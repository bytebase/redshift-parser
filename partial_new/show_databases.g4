// SHOW DATABASES grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_SHOW_DATABASES.html

grammar show_databases;

// Main rule for SHOW DATABASES statement
showDatabasesStatement
    : SHOW DATABASES showDatabasesFromClause? showDatabasesLikeClause? showDatabasesLimitClause?
    ;

// FROM DATA CATALOG clause with optional ACCOUNT specification
showDatabasesFromClause
    : FROM DATA CATALOG showDatabasesAccountClause? showDatabasesIamRoleClause?
    ;

// ACCOUNT clause for specifying AWS Glue Data Catalog accounts
showDatabasesAccountClause
    : ACCOUNT accountIdList
    ;

// List of account IDs
accountIdList
    : STRING_LITERAL (COMMA STRING_LITERAL)*
    ;

// IAM_ROLE clause for authentication
showDatabasesIamRoleClause
    : IAM_ROLE (DEFAULT | SESSION | STRING_LITERAL)
    ;

// LIKE clause for pattern matching
showDatabasesLikeClause
    : LIKE STRING_LITERAL
    ;

// LIMIT clause to restrict results
showDatabasesLimitClause
    : LIMIT NUMBER_LITERAL
    ;

// Lexer rules
SHOW        : S H O W ;
DATABASES   : D A T A B A S E S ;
FROM        : F R O M ;
DATA        : D A T A ;
CATALOG     : C A T A L O G ;
ACCOUNT     : A C C O U N T ;
LIKE        : L I K E ;
IAM_ROLE    : I A M UNDERSCORE R O L E ;
DEFAULT     : D E F A U L T ;
SESSION     : S E S S I O N ;
LIMIT       : L I M I T ;
COMMA       : ',' ;
UNDERSCORE  : '_' ;

// String literal for patterns, account IDs, and IAM roles
STRING_LITERAL
    : '\'' (~['\r\n] | '\'\'')* '\''
    ;

// Number literal for LIMIT
NUMBER_LITERAL
    : [0-9]+
    ;

// Whitespace
WS
    : [ \t\r\n]+ -> skip
    ;

// Case-insensitive character matching
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