// ATTACH MASKING POLICY statement - Redshift-specific command

attachmaskingpolicystmt:
    ATTACH MASKING POLICY colid ON qualified_name '(' outputcolumnlist ')'
    (USING '(' inputcolumnlist ')')?
    TO attachtarget
    (PRIORITY iconst)?
    ;

outputcolumnlist:
    outputcolumn (',' outputcolumn)*
    ;

outputcolumn:
    colid | qualified_name
    ;

inputcolumnlist:
    inputcolumn (',' inputcolumn)*
    ;

inputcolumn:
    colid | qualified_name
    ;

attachtarget:
    colid
    | ROLE colid
    | PUBLIC
    ;

// Needed tokens: ATTACH, MASKING, POLICY, ON, USING, TO, PRIORITY, ROLE, PUBLIC