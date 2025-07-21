// SHOW TABLE statement
// Shows the definition of a table, including table attributes, table constraints, column attributes, and column constraints
// https://docs.aws.amazon.com/redshift/latest/dg/r_SHOW_TABLE.html

showTableStatement
    : SHOW TABLE showTableName
    ;

showTableName
    : (schema_name DOT)? table_name
    ;

// Required tokens (add to lexer if not already present)
// SHOW: 'SHOW';
// TABLE: 'TABLE';
// DOT: '.';