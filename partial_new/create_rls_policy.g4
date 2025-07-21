// CREATE RLS POLICY statement - Redshift-specific command

createrlspolicystmt:
    CREATE RLS POLICY colid
    (WITH '(' columndeflist ')' (AS? colid)?)?
    USING '(' a_expr ')'
    ;

columndeflist:
    columndef (',' columndef)*
    ;

columndef:
    colid typename
    ;

// Needed tokens: CREATE, RLS, POLICY, WITH, AS, USING