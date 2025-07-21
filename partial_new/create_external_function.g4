// CREATE EXTERNAL FUNCTION command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_EXTERNAL_FUNCTION.html

createExternalFunctionStatement
    : CREATE (OR REPLACE)? EXTERNAL FUNCTION functionName '(' parameterList? ')'
      RETURNS dataType
      functionVolatility
      LAMBDA STRING_LITERAL
      IAM_ROLE iamRoleClause
      (RETRY_TIMEOUT milliseconds=INTEGER_LITERAL)?
      (MAX_BATCH_ROWS count=INTEGER_LITERAL)?
      (MAX_BATCH_SIZE size=INTEGER_LITERAL (KB | MB)?)?
    ;

functionName
    : identifier
    ;

parameterList
    : dataType (',' dataType)*
    ;

dataType
    : VARCHAR ('(' INTEGER_LITERAL ')')?
    | CHAR ('(' INTEGER_LITERAL ')')?
    | INTEGER
    | INT
    | BIGINT
    | SMALLINT
    | DECIMAL ('(' INTEGER_LITERAL (',' INTEGER_LITERAL)? ')')?
    | NUMERIC ('(' INTEGER_LITERAL (',' INTEGER_LITERAL)? ')')?
    | REAL
    | DOUBLE PRECISION?
    | BOOLEAN
    | DATE
    | TIMESTAMP (WITH TIME ZONE | WITHOUT TIME ZONE)?
    | TIMESTAMPTZ
    | TIME (WITH TIME ZONE | WITHOUT TIME ZONE)?
    | TIMETZ
    | INTERVAL
    | TEXT
    | JSONB
    | JSON
    | SUPER
    | HLLSKETCH
    | GEOMETRY
    | GEOGRAPHY
    ;

functionVolatility
    : VOLATILE
    | STABLE
    ;

iamRoleClause
    : DEFAULT
    | STRING_LITERAL  // ARN string
    ;

// Tokens (these would typically be in the lexer file)
CREATE: 'CREATE';
OR: 'OR';
REPLACE: 'REPLACE';
EXTERNAL: 'EXTERNAL';
FUNCTION: 'FUNCTION';
RETURNS: 'RETURNS';
VOLATILE: 'VOLATILE';
STABLE: 'STABLE';
LAMBDA: 'LAMBDA';
IAM_ROLE: 'IAM_ROLE';
DEFAULT: 'DEFAULT';
RETRY_TIMEOUT: 'RETRY_TIMEOUT';
MAX_BATCH_ROWS: 'MAX_BATCH_ROWS';
MAX_BATCH_SIZE: 'MAX_BATCH_SIZE';
KB: 'KB';
MB: 'MB';

// Data type tokens
VARCHAR: 'VARCHAR';
CHAR: 'CHAR';
INTEGER: 'INTEGER';
INT: 'INT';
BIGINT: 'BIGINT';
SMALLINT: 'SMALLINT';
DECIMAL: 'DECIMAL';
NUMERIC: 'NUMERIC';
REAL: 'REAL';
DOUBLE: 'DOUBLE';
PRECISION: 'PRECISION';
BOOLEAN: 'BOOLEAN';
DATE: 'DATE';
TIMESTAMP: 'TIMESTAMP';
TIMESTAMPTZ: 'TIMESTAMPTZ';
TIME: 'TIME';
TIMETZ: 'TIMETZ';
WITH: 'WITH';
WITHOUT: 'WITHOUT';
ZONE: 'ZONE';
INTERVAL: 'INTERVAL';
TEXT: 'TEXT';
JSONB: 'JSONB';
JSON: 'JSON';
SUPER: 'SUPER';
HLLSKETCH: 'HLLSKETCH';
GEOMETRY: 'GEOMETRY';
GEOGRAPHY: 'GEOGRAPHY';

// Rules referenced from main parser (placeholders for this partial grammar)
identifier: ID;

// Basic tokens
ID: [a-zA-Z_][a-zA-Z0-9_]*;
INTEGER_LITERAL: [0-9]+;
STRING_LITERAL: '\'' (~['\r\n] | '\'\'')* '\'';
WS: [ \t\r\n]+ -> skip;