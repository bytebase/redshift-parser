// CANCEL statement - Redshift-specific command

cancelstmt:
    CANCEL iconst (sconst)?
    ;

// Needed tokens: CANCEL