// SHOW TABLES statement - Redshift-specific command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_SHOW_TABLE.html
showtablesstmt
    : SHOW TABLES FROM SCHEMA database_name=colid '.' schema_name=colid
      (LIKE pattern=sconst)?
      (LIMIT limit_value=iconst)?
    ;