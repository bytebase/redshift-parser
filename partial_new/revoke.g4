// REVOKE command grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_REVOKE.html

revokeStatement
    : revokeTablePrivileges
    | revokeColumnPrivileges
    | revokeDatabasePrivileges
    | revokeSchemaPrivileges
    | revokeFunctionPrivileges
    | revokeLanguagePrivileges
    | revokeDatasharePrivileges
    | revokeRolePrivileges
    | revokeModelPrivileges
    | revokeGrantOption
    | revokeAdminOption
    ;

// REVOKE privileges ON table/view FROM users/roles
revokeTablePrivileges
    : REVOKE tablePrivilegeList ON tableObjectSpec FROM granteeList (CASCADE | RESTRICT)?
    ;

// REVOKE column-level privileges
revokeColumnPrivileges
    : REVOKE columnPrivilegeList ON TABLE tableName=identifier FROM granteeList (CASCADE | RESTRICT)?
    ;

columnPrivilegeList
    : columnPrivilege (COMMA columnPrivilege)*
    | ALL (PRIVILEGES)? LPAREN columnList RPAREN
    ;

columnPrivilege
    : SELECT LPAREN columnList RPAREN
    | UPDATE LPAREN columnList RPAREN
    ;

tablePrivilegeList
    : tablePrivilege (COMMA tablePrivilege)*
    | ALL (PRIVILEGES)?
    ;

tablePrivilege
    : SELECT
    | INSERT
    | UPDATE
    | DELETE
    | DROP
    | REFERENCES
    | ALTER
    | TRUNCATE
    ;

tableObjectSpec
    : (TABLE)? tableName=identifier
    | ALL TABLES IN SCHEMA schemaName=identifier
    ;

// REVOKE privileges ON DATABASE FROM users/roles
revokeDatabasePrivileges
    : REVOKE databasePrivilegeList ON DATABASE databaseName=identifier FROM granteeList (CASCADE | RESTRICT)?
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

// REVOKE privileges ON SCHEMA FROM users/roles
revokeSchemaPrivileges
    : REVOKE schemaPrivilegeList ON SCHEMA schemaName=identifier FROM granteeList (CASCADE | RESTRICT)?
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

// REVOKE privileges ON FUNCTION/PROCEDURE FROM users/roles
revokeFunctionPrivileges
    : REVOKE functionPrivilegeList ON functionObjectSpec FROM granteeList (CASCADE | RESTRICT)?
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
    | EXECUTE FOR FUNCTIONS IN SCHEMA schemaName=identifier
    | EXECUTE FOR PROCEDURES IN SCHEMA schemaName=identifier
    ;

// REVOKE privileges ON LANGUAGE FROM users/roles
revokeLanguagePrivileges
    : REVOKE USAGE ON LANGUAGE languageName=identifier FROM granteeList (CASCADE | RESTRICT)?
    ;

// REVOKE privileges ON DATASHARE FROM users/roles
revokeDatasharePrivileges
    : REVOKE datasharePrivilegeList ON DATASHARE datashareName=identifier FROM datashareGranteeList
    ;

datasharePrivilegeList
    : datasharePrivilege (COMMA datasharePrivilege)*
    ;

datasharePrivilege
    : ALTER
    | SHARE
    | USAGE
    ;

datashareGranteeList
    : datashareGrantee (COMMA datashareGrantee)*
    ;

datashareGrantee
    : userName=identifier
    | ROLE roleName=identifier
    | GROUP groupName=identifier
    | ACCOUNT accountNumber=identifier
    | NAMESPACE namespaceId=identifier
    ;

// REVOKE ROLE FROM users/roles
revokeRolePrivileges
    : REVOKE ROLE roleName=identifier FROM roleGranteeList
    ;

// REVOKE privileges ON MODEL FROM users/roles
revokeModelPrivileges
    : REVOKE modelPrivilegeList ON MODEL modelName=identifier FROM granteeList (CASCADE | RESTRICT)?
    | REVOKE CREATE MODEL FROM granteeList
    ;

modelPrivilegeList
    : modelPrivilege (COMMA modelPrivilege)*
    | ALL (PRIVILEGES)?
    ;

modelPrivilege
    : EXECUTE
    ;

// REVOKE GRANT OPTION FOR privileges
revokeGrantOption
    : REVOKE GRANT OPTION FOR tablePrivilegeList ON tableObjectSpec FROM granteeList (CASCADE | RESTRICT)?
    | REVOKE GRANT OPTION FOR databasePrivilegeList ON DATABASE databaseName=identifier FROM granteeList (CASCADE | RESTRICT)?
    | REVOKE GRANT OPTION FOR schemaPrivilegeList ON SCHEMA schemaName=identifier FROM granteeList (CASCADE | RESTRICT)?
    | REVOKE GRANT OPTION FOR functionPrivilegeList ON functionObjectSpec FROM granteeList (CASCADE | RESTRICT)?
    | REVOKE GRANT OPTION FOR modelPrivilegeList ON MODEL modelName=identifier FROM granteeList (CASCADE | RESTRICT)?
    | REVOKE GRANT OPTION SELECT FOR TABLES IN DATABASE databaseName=identifier FROM granteeList
    ;

// REVOKE ADMIN OPTION FOR role
revokeAdminOption
    : REVOKE ADMIN OPTION FOR ROLE roleName=identifier FROM roleGranteeList
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

roleGranteeList
    : roleGrantee (COMMA roleGrantee)*
    ;

roleGrantee
    : userName=identifier
    | ROLE roleName=identifier
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
REVOKE : R E V O K E ;
GRANT : G R A N T ;
OPTION : O P T I O N ;
FOR : F O R ;
ON : O N ;
FROM : F R O M ;
WITH : W I T H ;
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
LANGUAGE : L A N G U A G E ;
DATASHARE : D A T A S H A R E ;
MODEL : M O D E L ;
ROLE : R O L E ;
GROUP : G R O U P ;
PUBLIC : P U B L I C ;
ACCOUNT : A C C O U N T ;
NAMESPACE : N A M E S P A C E ;
IN : I N ;
ADMIN : A D M I N ;
CASCADE : C A S C A D E ;
RESTRICT : R E S T R I C T ;
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