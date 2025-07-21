// SHOW DATABASES statement - Redshift-specific command

showdatabasesstmt:
    SHOW DATABASES showdatabasesfromclause? showlikepattern? limitClause?
    ;

showdatabasesfromclause:
    FROM DATA CATALOG showdatabasesaccountclause? showdatabasesiamroleclause?
    ;

showdatabasesaccountclause:
    ACCOUNT accountidlist
    ;

accountidlist:
    sconst (',' sconst)*
    ;

showdatabasesiamroleclause:
    IAM_ROLE (DEFAULT | SESSION | sconst)
    ;

showlikepattern:
    LIKE sconst
    ;

// Needed tokens: SHOW, DATABASES, FROM, DATA, CATALOG, ACCOUNT, IAM_ROLE, DEFAULT, 
// SESSION, LIKE