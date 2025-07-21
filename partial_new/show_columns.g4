// SHOW COLUMNS statement - Redshift-specific command

showcolumnsstmt:
    SHOW COLUMNS FROM TABLE qualified_name showlikepattern? limitClause?
    ;

showlikepattern:
    LIKE sconst
    ;

// Needed tokens: SHOW, COLUMNS, FROM, TABLE, LIKE