// DROP EXTERNAL VIEW statement - Redshift-specific command

dropexternalviewstmt:
    DROP EXTERNAL VIEW opt_if_exists any_name
    ;

// Needed tokens: DROP, EXTERNAL, VIEW