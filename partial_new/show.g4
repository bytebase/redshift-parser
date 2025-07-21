// SHOW command - Shows the value of a runtime parameter or session context variable
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_SHOW.html

showStmt
    : SHOW showTarget
    ;

showTarget
    : ALL                           // Show all parameters
    | parameterName                 // Show specific parameter
    | sessionContextVariable        // Show session context variable
    ;

parameterName
    : identifier
    ;

sessionContextVariable
    : identifier DOT identifier     // e.g., app_context.user_id
    ;