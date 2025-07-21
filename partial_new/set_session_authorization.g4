// SET SESSION AUTHORIZATION statement
// https://docs.aws.amazon.com/redshift/latest/dg/r_SET_SESSION_AUTHORIZATION.html

setSessionAuthorizationStmt
    : SET (LOCAL)? SESSION AUTHORIZATION (userName | DEFAULT)
    ;

userName
    : Identifier
    | StringConstant
    ;