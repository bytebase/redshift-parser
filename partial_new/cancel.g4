// CANCEL statement
// https://docs.aws.amazon.com/redshift/latest/dg/r_CANCEL.html

// Rule to be included in RedshiftParser.g4
cancelStmt
    : CANCEL processId=INTEGER_LITERAL (message=STRING_LITERAL)?
    ;

// Tokens to be included in RedshiftLexer.g4 (if not already present)
// CANCEL: 'CANCEL';