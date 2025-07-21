// CREATE LIBRARY statement - Redshift-specific command

createlibrarystmt:
    CREATE opt_or_replace LIBRARY colid
    LANGUAGE PLPYTHONU
    FROM sconst
    (CREDENTIALS sconst)?
    (REGION (AS)? sconst)?
    IAM_ROLE iam_role_clause
    ;

iam_role_clause:
    DEFAULT | sconst
    ;

// Needed tokens: CREATE, LIBRARY, LANGUAGE, PLPYTHONU, FROM, CREDENTIALS, REGION, 
// AS, IAM_ROLE, DEFAULT