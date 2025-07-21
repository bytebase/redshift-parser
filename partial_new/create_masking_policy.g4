// CREATE MASKING POLICY statement - Redshift-specific security command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_MASKING_POLICY.html
createmaskingpolicystmt
    : CREATE MASKING POLICY opt_if_not_exists? policy_name=colid
      WITH '(' inputcolumnlist ')'
      USING '(' maskingexpression ')'
    ;

inputcolumnlist
    : inputcolumn (',' inputcolumn)*
    ;

inputcolumn
    : column_name=colid typename
    ;

maskingexpression
    : a_expr
    ;