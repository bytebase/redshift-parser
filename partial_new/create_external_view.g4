// CREATE EXTERNAL VIEW statement - Redshift-specific command

createexternalviewstmt:
    CREATE EXTERNAL (PROTECTED)? VIEW opt_if_not_exists any_name AS selectstmt
    ;

// Needed tokens: CREATE, EXTERNAL, PROTECTED, VIEW, AS