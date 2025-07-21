// ALTER IDENTITY PROVIDER statement - Redshift-specific command

alteridentityproviderstmt:
    ALTER IDENTITY PROVIDER colid alteridentityproveraction*
    ;

alteridentityproveraction:
    PARAMETERS sconst
    | NAMESPACE sconst
    | IAM_ROLE sconst
    | AUTO_CREATE_ROLES (TRUE | FALSE) (groupfilter)?
    | ENABLE
    | DISABLE
    ;

groupfilter:
    (INCLUDE | EXCLUDE) GROUPS LIKE sconst
    ;

// Needed tokens: ALTER, IDENTITY, PROVIDER, PARAMETERS, NAMESPACE, IAM_ROLE, 
// AUTO_CREATE_ROLES, TRUE, FALSE, INCLUDE, EXCLUDE, GROUPS, LIKE, ENABLE, DISABLE