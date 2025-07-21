// END command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_END.html

endStmt
    : END (WORK | TRANSACTION)?
    ;

// Keywords (these would typically be defined in the lexer)
END: 'END';
WORK: 'WORK';
TRANSACTION: 'TRANSACTION';