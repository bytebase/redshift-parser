// ALTER DATABASE grammar for Redshift
// Based on: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_DATABASE.html

alterDatabaseStmt
    : ALTER DATABASE databaseName alterDatabaseAction
    ;

alterDatabaseAction
    : RENAME TO newDatabaseName=identifier
    | OWNER TO newOwner=identifier
    | CONNECTION LIMIT connectionLimitValue
    | COLLATE collateOption
    ;

connectionLimitValue
    : UNLIMITED
    | ICONST  // numeric limit
    ;

collateOption
    : CASE_SENSITIVE
    | CS
    | CASE_INSENSITIVE
    | CI
    ;

databaseName
    : identifier
    ;

// These tokens should be defined in the lexer:
// ALTER, DATABASE, RENAME, TO, OWNER, CONNECTION, LIMIT, UNLIMITED,
// COLLATE, CASE_SENSITIVE, CS, CASE_INSENSITIVE, CI