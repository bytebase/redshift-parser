// COMMIT command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_COMMIT.html

commitStmt
    : COMMIT (WORK | TRANSACTION)?
    | END (WORK | TRANSACTION)?
    ;

// Keywords (these would typically be defined in the lexer)
COMMIT: 'COMMIT';
END: 'END';
TRANSACTION: 'TRANSACTION';
WORK: 'WORK';