// USE command
// Changes the current database
// https://docs.aws.amazon.com/redshift/latest/dg/r_USE.html

useStmt
    : USE database_name=schemaName
    ;