// SET command grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_SET.html

setStmt
    : SET setScope? setTarget (TO | EQUALS) setValue
    | SET setScope? SEED TO seedValue
    | SET SESSION CHARACTERISTICS AS TRANSACTION transactionMode
    ;

setScope
    : SESSION
    | LOCAL
    ;

setTarget
    : parameterName
    | contextVariable
    | SEED
    ;

parameterName
    : identifier
    ;

contextVariable
    : identifier DOT identifier
    ;

setValue
    : value
    | quotedValue
    | DEFAULT
    ;

value
    : identifier
    | NUMBER
    | TRUE
    | FALSE
    ;

quotedValue
    : STRING_LITERAL
    ;

seedValue
    : NUMBER
    ;

transactionMode
    : ISOLATION LEVEL isolationLevel
    ;

isolationLevel
    : READ UNCOMMITTED
    | READ COMMITTED
    | REPEATABLE READ
    | SERIALIZABLE
    ;

identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    | nonReservedKeyword
    ;

nonReservedKeyword
    : CHARACTERISTICS
    | DATESTYLE
    | DEFAULT_IDENTITY_NAMESPACE
    | ENABLE_RESULT_CACHE_FOR_SESSION
    | ISOLATION
    | LEVEL
    | LOCAL
    | MAX_CONCURRENCY_SCALING_CLUSTERS
    | QUERY_GROUP
    | READ
    | SEARCH_PATH
    | SEED
    | SESSION
    | SPECTRUM_ENABLE_PSEUDO_COLUMNS
    | STATEMENT_TIMEOUT
    | TIMEZONE
    | TRANSACTION
    | WLM_JSON_CONFIGURATION
    ;

// Keywords
AS: 'AS';
CHARACTERISTICS: 'CHARACTERISTICS';
COMMITTED: 'COMMITTED';
DATESTYLE: 'DATESTYLE';
DEFAULT: 'DEFAULT';
DEFAULT_IDENTITY_NAMESPACE: 'DEFAULT_IDENTITY_NAMESPACE';
ENABLE_RESULT_CACHE_FOR_SESSION: 'ENABLE_RESULT_CACHE_FOR_SESSION';
FALSE: 'FALSE';
ISOLATION: 'ISOLATION';
LEVEL: 'LEVEL';
LOCAL: 'LOCAL';
MAX_CONCURRENCY_SCALING_CLUSTERS: 'MAX_CONCURRENCY_SCALING_CLUSTERS';
QUERY_GROUP: 'QUERY_GROUP';
READ: 'READ';
REPEATABLE: 'REPEATABLE';
SEARCH_PATH: 'SEARCH_PATH';
SEED: 'SEED';
SERIALIZABLE: 'SERIALIZABLE';
SESSION: 'SESSION';
SET: 'SET';
SPECTRUM_ENABLE_PSEUDO_COLUMNS: 'SPECTRUM_ENABLE_PSEUDO_COLUMNS';
STATEMENT_TIMEOUT: 'STATEMENT_TIMEOUT';
TIMEZONE: 'TIMEZONE';
TO: 'TO';
TRANSACTION: 'TRANSACTION';
TRUE: 'TRUE';
UNCOMMITTED: 'UNCOMMITTED';
WLM_JSON_CONFIGURATION: 'WLM_JSON_CONFIGURATION';

// Operators
DOT: '.';
EQUALS: '=';

// Literals
NUMBER: [0-9]+ ('.' [0-9]+)?;
STRING_LITERAL: '\'' (~'\'' | '\'\'')* '\'';
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
QUOTED_IDENTIFIER: '"' (~'"' | '""')* '"';

// Whitespace and comments
WS: [ \t\r\n]+ -> skip;
COMMENT: '--' ~[\r\n]* -> skip;