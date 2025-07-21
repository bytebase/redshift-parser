// ALTER FUNCTION command for Amazon Redshift
// Based on: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_FUNCTION.html
// This file contains grammar rules for ALTER FUNCTION statement
// Supports:
// - RENAME TO new_name
// - OWNER TO { new_owner | CURRENT_USER | SESSION_USER }

// Main ALTER FUNCTION statement
alterFunctionStmt
    : ALTER FUNCTION function_with_argtypes alterFunctionAction
    ;

// Function specification with arguments
// Both function name and argument data types are required in Redshift
function_with_argtypes
    : func_name func_args
    ;

// Function name (can be schema-qualified)
func_name
    : colid
    | colid DOT colid
    ;

// Function arguments - required for identifying the function
// Supports both SQL-style and Python-style arguments
func_args
    : OPEN_PAREN func_args_list? CLOSE_PAREN
    ;

func_args_list
    : func_arg (COMMA func_arg)*
    ;

// Individual function argument
// Can be either:
// - SQL style: just the data type
// - Python style: parameter_name parameter_type
func_arg
    : func_arg_with_default_list
    | typename
    ;

func_arg_with_default_list
    : func_arg_with_default (COMMA func_arg_with_default)*
    ;

func_arg_with_default
    : param_name=colid param_type=typename
    ;

// ALTER FUNCTION actions
alterFunctionAction
    : renameFunctionAction
    | changeOwnerAction
    ;

// RENAME TO action
renameFunctionAction
    : RENAME TO new_name=colid
    ;

// OWNER TO action
changeOwnerAction
    : OWNER TO rolespec
    ;

// Role specification for OWNER TO
// Supports: username, CURRENT_USER, SESSION_USER
rolespec
    : colid
    | CURRENT_USER
    | SESSION_USER
    ;

// Note: The following tokens are expected to be defined in RedshiftLexer.g4:
// ALTER, FUNCTION, RENAME, TO, OWNER, CURRENT_USER, SESSION_USER,
// OPEN_PAREN, CLOSE_PAREN, COMMA, DOT

// Note: The following rules are expected to be defined elsewhere:
// - colid (identifier)
// - typename (data type specification)