// CREATE EXTERNAL MODEL statement - Redshift-specific command

createexternalmodelstmt:
    CREATE EXTERNAL MODEL colid
    FUNCTION colid
    IAM_ROLE iam_role_clause
    MODEL_TYPE BEDROCK
    SETTINGS '(' settingslist ')'
    ;

iam_role_clause:
    DEFAULT | sconst
    ;

settingslist:
    settingsitem (',' settingsitem)*
    ;

settingsitem:
    MODEL_ID sconst
    | PROMPT sconst
    | SUFFIX sconst
    | REQUEST_TYPE requesttypevalue
    | RESPONSE_TYPE responsetypevalue
    ;

requesttypevalue:
    RAW | UNIFIED
    ;

responsetypevalue:
    VARCHAR | SUPER
    ;

// Needed tokens: CREATE, EXTERNAL, MODEL, FUNCTION, IAM_ROLE, DEFAULT, MODEL_TYPE,
// BEDROCK, SETTINGS, MODEL_ID, PROMPT, SUFFIX, REQUEST_TYPE, RESPONSE_TYPE, RAW,
// UNIFIED, VARCHAR, SUPER