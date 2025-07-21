// SHOW DATASHARES statement - Redshift-specific command

showdatasharesstmt:
    SHOW DATASHARES showlikepattern?
    ;

showlikepattern:
    LIKE sconst
    ;

// Needed tokens: SHOW, DATASHARES, LIKE