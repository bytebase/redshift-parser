// DROP MODEL statement - Redshift-specific command

dropmodelstmt:
    DROP MODEL opt_if_exists qualified_name
    ;

// Needed tokens: DROP, MODEL