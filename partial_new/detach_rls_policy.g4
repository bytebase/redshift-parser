// DETACH RLS POLICY statement - Redshift-specific command

detachrlspolicystmt:
    DETACH RLS POLICY colid ON TABLE? tablelist FROM detachtargetlist
    ;

tablelist:
    qualified_name (',' qualified_name)*
    ;

detachtargetlist:
    detachtarget (',' detachtarget)*
    ;

detachtarget:
    colid
    | ROLE colid
    | PUBLIC
    ;

// Needed tokens: DETACH, RLS, POLICY, ON, TABLE, FROM, ROLE, PUBLIC