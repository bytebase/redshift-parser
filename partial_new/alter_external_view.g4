// ALTER EXTERNAL VIEW statement - Redshift-specific command

alterexternalviewstmt:
    ALTER EXTERNAL VIEW any_name (FORCE)? 
    (AS '(' selectstmt ')' | REMOVE DEFINITION)
    ;

// Needed tokens: ALTER, EXTERNAL, VIEW, FORCE, AS, REMOVE, DEFINITION