// CREATE IDENTITY PROVIDER statement - Redshift-specific command

createidentityproviderstmt:
    CREATE IDENTITY PROVIDER colid TYPE typespec NAMESPACE sconst
    (PARAMETERS sconst)?
    (APPLICATION_ARN sconst)?
    (IAM_ROLE sconst)?
    (AUTO_CREATE_ROLES autocreaterolesoption)?
    ;

typespec:
    OAUTH2 | AZURE | AWSIDC | IAM_IDENTITY_CENTER
    ;

autocreaterolesoption:
    TRUE (groupfilter)?
    | FALSE
    ;

groupfilter:
    (INCLUDE | EXCLUDE) GROUPS LIKE sconst
    ;

// Needed tokens: CREATE, IDENTITY, PROVIDER, TYPE, NAMESPACE, PARAMETERS, 
// APPLICATION_ARN, IAM_ROLE, AUTO_CREATE_ROLES, TRUE, FALSE, INCLUDE, EXCLUDE,
// GROUPS, LIKE, OAUTH2, AZURE, AWSIDC, IAM_IDENTITY_CENTER