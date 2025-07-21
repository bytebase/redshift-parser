// SELECT INTO statement - Redshift-specific command

selectintostmt:
    select_clause intoClause from_clause? where_clause? group_clause? having_clause? 
    orderby_clause? limitClause?
    ;

intoClause:
    INTO opt_temp TABLE? qualified_name
    ;

opt_temp:
    TEMPORARY | TEMP | /* empty */
    ;

// Needed tokens: INTO, TEMPORARY, TEMP, TABLE