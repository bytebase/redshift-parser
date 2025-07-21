// DESC DATASHARE statement - Redshift-specific data sharing command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_DESC_DATASHARE.html
descdatasharestmt
    : (DESC | DESCRIBE) DATASHARE datashare_name=colid (OF (ACCOUNT account_id=sconst)? NAMESPACE namespace_guid=sconst)?
    ;