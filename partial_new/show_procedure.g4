// SHOW PROCEDURE statement - Redshift-specific command

showprocedurestmt:
    SHOW PROCEDURE func_name ('(' func_args_list? ')')?
    ;

func_args_list:
    func_arg (',' func_arg)*
    ;

func_arg:
    (colid)? (param_mode)? typename
    ;

param_mode:
    IN | OUT | INOUT
    ;

// Needed tokens: SHOW, PROCEDURE, IN, OUT, INOUT