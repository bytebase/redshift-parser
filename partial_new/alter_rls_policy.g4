// ALTER RLS POLICY statement - Redshift-specific command

alterrlspolicystmt:
    ALTER RLS POLICY colid USING '(' a_expr ')'
    ;

// Needed tokens: ALTER, RLS, POLICY, USING