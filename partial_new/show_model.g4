// SHOW MODEL statement grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_SHOW_MODEL.html

showModelStmt
    : SHOW MODEL (ALL | modelName)
    ;

modelName
    : identifier
    ;