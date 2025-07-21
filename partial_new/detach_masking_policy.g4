// DETACH MASKING POLICY statement - Redshift-specific command

detachmaskingpolicystmt:
    DETACH MASKING POLICY colid ON qualified_name '(' outputcolumnlist ')' FROM detachtarget
    ;

outputcolumnlist:
    outputcolumn (',' outputcolumn)*
    ;

outputcolumn:
    colid | qualified_name
    ;

detachtarget:
    colid
    | ROLE colid
    | PUBLIC
    ;

// Needed tokens: DETACH, MASKING, POLICY, ON, FROM, ROLE, PUBLIC