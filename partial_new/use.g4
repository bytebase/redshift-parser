// USE statement - Redshift-specific database switching command
// https://docs.aws.amazon.com/redshift/latest/dg/r_USE.html
usestmt
    : USE database_name=colid
    ;