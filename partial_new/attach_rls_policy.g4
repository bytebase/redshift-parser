// ATTACH RLS POLICY statement - Redshift-specific command

attachrlspolicystmt:
    ATTACH RLS POLICY colid ON TABLE? tablelist TO attachtargetlist
    ;

tablelist:
    qualified_name (',' qualified_name)*
    ;

attachtargetlist:
    attachtarget (',' attachtarget)*
    ;

attachtarget:
    colid
    | ROLE colid
    | PUBLIC
    ;

// Needed tokens: ATTACH, RLS, POLICY, ON, TABLE, TO, ROLE, PUBLIC