// GRANT command grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_GRANT.html

grantStatement
    : grantTablePrivileges
    | grantDatabasePrivileges
    | grantSchemaPrivileges
    | grantFunctionPrivileges
    | grantDatasharePrivileges
    | grantRolePrivileges
    | grantModelPrivileges
    ;

// GRANT privileges ON table/view TO users/roles
grantTablePrivileges
    : GRANT tablePrivilegeList ON tableObjectSpec TO granteeList (WITH GRANT OPTION)?
    ;

tablePrivilegeList
    : tablePrivilege (COMMA tablePrivilege)*
    | ALL (PRIVILEGES)?
    ;

tablePrivilege
    : SELECT (LPAREN columnList RPAREN)?
    | INSERT (LPAREN columnList RPAREN)?
    | UPDATE (LPAREN columnList RPAREN)?
    | DELETE
    | DROP
    | REFERENCES (LPAREN columnList RPAREN)?
    | ALTER
    | TRUNCATE
    ;

tableObjectSpec
    : (TABLE)? tableName=identifier
    | ALL TABLES IN SCHEMA schemaName=identifier
    ;

// GRANT privileges ON DATABASE TO users/roles
grantDatabasePrivileges
    : GRANT databasePrivilegeList ON DATABASE databaseName=identifier TO granteeList (WITH GRANT OPTION)?
    ;

databasePrivilegeList
    : databasePrivilege (COMMA databasePrivilege)*
    | ALL (PRIVILEGES)?
    ;

databasePrivilege
    : CREATE
    | USAGE
    | TEMPORARY
    | TEMP
    | ALTER
    | DROP
    ;

// GRANT privileges ON SCHEMA TO users/roles
grantSchemaPrivileges
    : GRANT schemaPrivilegeList ON SCHEMA schemaName=identifier TO granteeList (WITH GRANT OPTION)?
    ;

schemaPrivilegeList
    : schemaPrivilege (COMMA schemaPrivilege)*
    | ALL (PRIVILEGES)?
    ;

schemaPrivilege
    : CREATE
    | USAGE
    | ALTER
    | DROP
    ;

// GRANT privileges ON FUNCTION/PROCEDURE TO users/roles
grantFunctionPrivileges
    : GRANT functionPrivilegeList ON functionObjectSpec TO granteeList (WITH GRANT OPTION)?
    ;

functionPrivilegeList
    : functionPrivilege (COMMA functionPrivilege)*
    | ALL (PRIVILEGES)?
    ;

functionPrivilege
    : EXECUTE
    ;

functionObjectSpec
    : FUNCTION functionName=identifier (LPAREN parameterTypeList? RPAREN)?
    | PROCEDURE procedureName=identifier (LPAREN parameterTypeList? RPAREN)?
    | ALL FUNCTIONS IN SCHEMA schemaName=identifier
    | ALL PROCEDURES IN SCHEMA schemaName=identifier
    ;

// GRANT privileges ON DATASHARE TO users/roles
grantDatasharePrivileges
    : GRANT datasharePrivilegeList ON DATASHARE datashareName=identifier TO granteeList
    ;

datasharePrivilegeList
    : datasharePrivilege (COMMA datasharePrivilege)*
    ;

datasharePrivilege
    : ALTER
    | SHARE
    | USAGE
    ;

// GRANT ROLE TO users/roles
grantRolePrivileges
    : GRANT ROLE roleName=identifier TO roleGranteeList
    ;

roleGranteeList
    : roleGrantee (COMMA roleGrantee)*
    ;

roleGrantee
    : userName=identifier (WITH ADMIN OPTION)?
    | ROLE roleName=identifier
    ;

// GRANT privileges ON MODEL TO users/roles
grantModelPrivileges
    : GRANT modelPrivilegeList ON MODEL modelName=identifier TO granteeList (WITH GRANT OPTION)?
    ;

modelPrivilegeList
    : modelPrivilege (COMMA modelPrivilege)*
    | ALL (PRIVILEGES)?
    ;

modelPrivilege
    : EXECUTE
    ;

// Common elements
granteeList
    : grantee (COMMA grantee)*
    ;

grantee
    : userName=identifier
    | ROLE roleName=identifier
    | GROUP groupName=identifier
    | PUBLIC
    ;

columnList
    : columnName=identifier (COMMA columnName=identifier)*
    ;

parameterTypeList
    : parameterType (COMMA parameterType)*
    ;

parameterType
    : dataTypeName=identifier (LPAREN numericLiteral (COMMA numericLiteral)? RPAREN)?
    ;

identifier
    : IDENTIFIER
    | quotedIdentifier
    ;

quotedIdentifier
    : QUOTED_IDENTIFIER
    ;

numericLiteral
    : INTEGER_LITERAL
    | DECIMAL_LITERAL
    ;

// Keywords
GRANT : G R A N T ;
ON : O N ;
TO : T O ;
WITH : W I T H ;
OPTION : O P T I O N ;
ALL : A L L ;
PRIVILEGES : P R I V I L E G E S ;
TABLE : T A B L E ;
TABLES : T A B L E S ;
DATABASE : D A T A B A S E ;
SCHEMA : S C H E M A ;
FUNCTION : F U N C T I O N ;
FUNCTIONS : F U N C T I O N S ;
PROCEDURE : P R O C E D U R E ;
PROCEDURES : P R O C E D U R E S ;
DATASHARE : D A T A S H A R E ;
MODEL : M O D E L ;
ROLE : R O L E ;
GROUP : G R O U P ;
PUBLIC : P U B L I C ;
IN : I N ;
ADMIN : A D M I N ;
SELECT : S E L E C T ;
INSERT : I N S E R T ;
UPDATE : U P D A T E ;
DELETE : D E L E T E ;
DROP : D R O P ;
REFERENCES : R E F E R E N C E S ;
ALTER : A L T E R ;
TRUNCATE : T R U N C A T E ;
CREATE : C R E A T E ;
USAGE : U S A G E ;
TEMPORARY : T E M P O R A R Y ;
TEMP : T E M P ;
EXECUTE : E X E C U T E ;
SHARE : S H A R E ;

// Punctuation
COMMA : ',' ;
LPAREN : '(' ;
RPAREN : ')' ;

// Lexer tokens
IDENTIFIER
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

QUOTED_IDENTIFIER
    : '"' ( ~'"' | '""' )* '"'
    ;

INTEGER_LITERAL
    : [0-9]+
    ;

DECIMAL_LITERAL
    : [0-9]+ '.' [0-9]+
    | '.' [0-9]+
    | [0-9]+ '.'
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