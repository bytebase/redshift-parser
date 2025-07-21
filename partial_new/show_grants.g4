// SHOW GRANTS statement - Redshift-specific command

showgrantsstmt:
    SHOW GRANTS (showgrantsobject | showgrantsforprincipal)
    ;

showgrantsobject:
    ON showgrantsobjecttype showgrantsforclause? limitClause?
    ;

showgrantsforprincipal:
    FOR showgrantsprincipal limitClause?
    ;

showgrantsobjecttype:
    DATABASE colid
    | FUNCTION func_name
    | SCHEMA any_name  
    | TABLE? qualified_name
    ;

showgrantsforclause:
    FOR showgrantsprincipal
    ;

showgrantsprincipal:
    rolespec
    | ROLE rolespec
    | PUBLIC
    ;

// Needed tokens: SHOW, GRANTS, ON, FOR, DATABASE, FUNCTION, SCHEMA, TABLE, ROLE, PUBLIC