// ALTER DEFAULT PRIVILEGES statement
// https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_DEFAULT_PRIVILEGES.html

alterDefaultPrivilegesStatement
    : ALTER DEFAULT PRIVILEGES alterDefaultPrivilegesAction
    ;

alterDefaultPrivilegesAction
    : (forUserClause)? (inSchemaClause)? (grantOnClause | revokeOnClause)
    ;

forUserClause
    : FOR USER targetUser (COMMA targetUser)*
    ;

targetUser
    : userName
    ;

inSchemaClause
    : IN SCHEMA schemaName (COMMA schemaName)*
    ;

grantOnClause
    : GRANT privilegeList ON objectType TO granteeList
    ;

revokeOnClause
    : REVOKE (GRANT OPTION FOR)? privilegeList ON objectType FROM granteeList
    ;

privilegeList
    : ALL PRIVILEGES?
    | privilege (COMMA privilege)*
    ;

privilege
    : SELECT
    | INSERT
    | UPDATE
    | DELETE
    | DROP
    | REFERENCES
    | TRUNCATE
    | EXECUTE
    ;

objectType
    : TABLES
    | FUNCTIONS
    | PROCEDURES
    ;

granteeList
    : grantee (COMMA grantee)*
    ;

grantee
    : userName (WITH GRANT OPTION)?
    | ROLE roleName
    | GROUP groupName
    | PUBLIC
    ;

userName
    : identifier
    ;

roleName
    : identifier
    ;

groupName
    : identifier
    ;

schemaName
    : identifier
    ;

// Lexer tokens (assuming these are defined in the main lexer file)
// ALTER, DEFAULT, PRIVILEGES, FOR, USER, IN, SCHEMA, GRANT, REVOKE
// SELECT, INSERT, UPDATE, DELETE, DROP, REFERENCES, TRUNCATE, EXECUTE
// ALL, ON, TABLES, FUNCTIONS, PROCEDURES, TO, FROM
// WITH, OPTION, ROLE, GROUP, PUBLIC, COMMA