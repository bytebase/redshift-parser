// CREATE DATASHARE statement - Redshift-specific data sharing command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_DATASHARE.html
createdatasharestmt
    : CREATE DATASHARE colid createdatashareoptions?
    ;

createdatashareoptions
    : createdatashareoption (COMMA createdatashareoption)*
    ;

createdatashareoption
    : setpublicaccessibleoption
    | managedbyoption
    ;

setpublicaccessibleoption
    : SET? PUBLICACCESSIBLE (EQUAL? (TRUE | FALSE))?
    ;

managedbyoption
    : MANAGEDBY ADX
    ;