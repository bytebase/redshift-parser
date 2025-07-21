alterProcedureStatement
    : ALTER PROCEDURE procedureName=functionName procedureArgumentList? alterProcedureAction
    ;

alterProcedureAction
    : RENAME TO newName=identifier
    | OWNER TO alterOwnerOption
    ;

alterOwnerOption
    : roleSpec
    | CURRENT_USER
    | SESSION_USER
    ;

procedureArgumentList
    : LEFT_PAREN (procedureArgument (COMMA procedureArgument)*)? RIGHT_PAREN
    ;

procedureArgument
    : (argName=identifier)? (argMode=argumentMode)? argType=dataType
    ;

argumentMode
    : IN
    | OUT  
    | INOUT
    ;