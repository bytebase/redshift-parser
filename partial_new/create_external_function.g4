// CREATE EXTERNAL FUNCTION statement - Redshift-specific command

createexternalfunctionstmt:
    CREATE opt_or_replace EXTERNAL FUNCTION func_name func_args_with_defaults_redshift
    RETURNS func_return 
    volatilespec
    LAMBDA sconst
    IAM_ROLE iam_role_clause
    (RETRY_TIMEOUT iconst)?
    (MAX_BATCH_ROWS iconst)?
    (MAX_BATCH_SIZE iconst (KB | MB)?)?
    ;

func_args_with_defaults_redshift:
    '(' func_args_list? ')'
    ;

func_args_list:
    typename (',' typename)*
    ;

func_return:
    typename
    ;

volatilespec:
    VOLATILE | STABLE | /* empty */
    ;

iam_role_clause:
    DEFAULT | sconst
    ;

// Needed tokens: CREATE, EXTERNAL, FUNCTION, RETURNS, VOLATILE, STABLE, LAMBDA,
// IAM_ROLE, DEFAULT, RETRY_TIMEOUT, MAX_BATCH_ROWS, MAX_BATCH_SIZE, KB, MB