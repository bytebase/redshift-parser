// SHOW SCHEMAS statement - Redshift-specific command

showschemasstmt:
    SHOW SCHEMAS showschemasfromclause showlikepattern? limitClause?
    ;

showschemasfromclause:
    FROM DATABASE colid
    ;

showlikepattern:
    LIKE sconst
    ;

// Needed tokens: SHOW, SCHEMAS, FROM, DATABASE, LIKE