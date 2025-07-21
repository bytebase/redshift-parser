// CREATE DATABASE grammar for Amazon Redshift
// Based on: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_DATABASE.html

createDatabaseStatement
    : CREATE DATABASE databaseName createDatabaseOptions? SEMI?
    ;

databaseName
    : identifier
    ;

createDatabaseOptions
    : fromIntegrationClause? withClause?
    | withClause
    ;

fromIntegrationClause
    : FROM INTEGRATION STRING_LITERAL fromIntegrationOptions?
    ;

fromIntegrationOptions
    : fromIntegrationOption+
    ;

fromIntegrationOption
    : DATABASE STRING_LITERAL
    | SET
    | ACCEPTINVCHARS booleanValue
    | QUERY_ALL_STATES booleanValue
    | REFRESH_INTERVAL NUMBER
    | TRUNCATECOLUMNS booleanValue
    | HISTORY_MODE booleanValue
    ;

withClause
    : WITH withOption+
    | withOption+
    ;

withOption
    : OWNER EQUAL? dbOwner
    | CONNECTION LIMIT connectionLimitValue
    | COLLATE collateValue
    | ISOLATION LEVEL isolationLevelValue
    ;

dbOwner
    : identifier
    ;

connectionLimitValue
    : NUMBER
    | UNLIMITED
    ;

collateValue
    : CASE_SENSITIVE
    | CS
    | CASE_INSENSITIVE
    | CI
    ;

isolationLevelValue
    : SERIALIZABLE
    | SNAPSHOT
    ;

booleanValue
    : TRUE
    | FALSE
    ;

// Lexer rules (these would typically be in the lexer file)
CREATE: 'CREATE';
DATABASE: 'DATABASE';
FROM: 'FROM';
INTEGRATION: 'INTEGRATION';
SET: 'SET';
ACCEPTINVCHARS: 'ACCEPTINVCHARS';
QUERY_ALL_STATES: 'QUERY_ALL_STATES';
REFRESH_INTERVAL: 'REFRESH_INTERVAL';
TRUNCATECOLUMNS: 'TRUNCATECOLUMNS';
HISTORY_MODE: 'HISTORY_MODE';
WITH: 'WITH';
OWNER: 'OWNER';
CONNECTION: 'CONNECTION';
LIMIT: 'LIMIT';
UNLIMITED: 'UNLIMITED';
COLLATE: 'COLLATE';
CASE_SENSITIVE: 'CASE_SENSITIVE';
CS: 'CS';
CASE_INSENSITIVE: 'CASE_INSENSITIVE';
CI: 'CI';
ISOLATION: 'ISOLATION';
LEVEL: 'LEVEL';
SERIALIZABLE: 'SERIALIZABLE';
SNAPSHOT: 'SNAPSHOT';
TRUE: 'TRUE';
FALSE: 'FALSE';
EQUAL: '=';
SEMI: ';';

// Assuming these are defined elsewhere in the grammar
identifier: IDENTIFIER;
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
STRING_LITERAL: '\'' (~['\\] | '\\' .)* '\'';
NUMBER: [0-9]+;