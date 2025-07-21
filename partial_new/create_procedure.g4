// CREATE PROCEDURE statement - Redshift-specific command

createprocedurestmt:
    CREATE opt_or_replace PROCEDURE func_name '(' proc_args_list? ')'
    (NONATOMIC)?
    AS sconst
    LANGUAGE colid
    (security_clause)?
    (proc_config_clause)*
    ;

proc_args_list:
    proc_arg (',' proc_arg)*
    ;

proc_arg:
    (colid)? (param_mode)? typename
    ;

param_mode:
    IN | OUT | INOUT
    ;

security_clause:
    SECURITY (INVOKER | DEFINER)
    ;

proc_config_clause:
    SET colid opt_equal def_elem
    ;

// Needed tokens: CREATE, PROCEDURE, NONATOMIC, AS, LANGUAGE, IN, OUT, INOUT,
// SECURITY, INVOKER, DEFINER, SET