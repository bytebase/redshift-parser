// SHOW PROCEDURE command
// Shows the source code of a stored procedure
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_SHOW_PROCEDURE.html

showProcedureStmt
    : SHOW PROCEDURE procedureName=identifier (LPAREN procedureArguments? RPAREN)?
    ;

procedureArguments
    : procedureArgument (COMMA procedureArgument)*
    ;

procedureArgument
    : (argName=identifier)? (argMode)? argType=dataType
    ;

argMode
    : IN
    | OUT
    | INOUT
    ;