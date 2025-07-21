// DROP PROCEDURE statement - Redshift-specific command

dropprocedurestmt:
    DROP PROCEDURE opt_if_exists func_name func_args_with_defaults
    opt_drop_behavior
    ;

func_args_with_defaults:
    '(' func_args_list? ')'
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

// Needed tokens: DROP, PROCEDURE, IN, OUT, INOUT