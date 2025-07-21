// CREATE DATASHARE grammar rules for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_DATASHARE.html

createDatashareStmt
    : CREATE DATASHARE identifier createDatashareOptions? SEMI
    ;

createDatashareOptions
    : createDatashareOption (COMMA createDatashareOption)*
    ;

createDatashareOption
    : setPublicAccessibleOption
    | managedByOption
    ;

setPublicAccessibleOption
    : SET? PUBLICACCESSIBLE (EQUAL? (TRUE | FALSE))?
    ;

managedByOption
    : MANAGEDBY ADX
    ;