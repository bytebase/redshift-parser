// CREATE EXTERNAL MODEL command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_create_external_model.html

createExternalModelStatement
    : CREATE EXTERNAL MODEL modelName
      FUNCTION functionName
      IAM_ROLE iamRoleClause
      MODEL_TYPE BEDROCK
      SETTINGS '(' settingsList ')'
    ;

modelName
    : identifier
    ;

functionName
    : identifier
    ;

iamRoleClause
    : DEFAULT
    | STRING_LITERAL  // ARN string
    ;

settingsList
    : settingsItem (',' settingsItem)*
    ;

settingsItem
    : MODEL_ID modelIdValue
    | PROMPT promptValue
    | SUFFIX suffixValue
    | REQUEST_TYPE requestTypeValue
    | RESPONSE_TYPE responseTypeValue
    ;

modelIdValue
    : STRING_LITERAL
    ;

promptValue
    : STRING_LITERAL
    ;

suffixValue
    : STRING_LITERAL
    ;

requestTypeValue
    : RAW
    | UNIFIED
    ;

responseTypeValue
    : VARCHAR
    | SUPER
    ;

// Tokens (these would typically be in the lexer file)
CREATE: 'CREATE';
EXTERNAL: 'EXTERNAL';
MODEL: 'MODEL';
FUNCTION: 'FUNCTION';
IAM_ROLE: 'IAM_ROLE';
DEFAULT: 'DEFAULT';
MODEL_TYPE: 'MODEL_TYPE';
BEDROCK: 'BEDROCK';
SETTINGS: 'SETTINGS';
MODEL_ID: 'MODEL_ID';
PROMPT: 'PROMPT';
SUFFIX: 'SUFFIX';
REQUEST_TYPE: 'REQUEST_TYPE';
RESPONSE_TYPE: 'RESPONSE_TYPE';
RAW: 'RAW';
UNIFIED: 'UNIFIED';
VARCHAR: 'VARCHAR';
SUPER: 'SUPER';

// Rules referenced from main parser (placeholders for this partial grammar)
identifier: ID;

// Basic tokens
ID: [a-zA-Z_][a-zA-Z0-9_]*;
STRING_LITERAL: '\'' (~['\r\n] | '\'\'')* '\'';
WS: [ \t\r\n]+ -> skip;