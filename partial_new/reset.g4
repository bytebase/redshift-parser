// RESET command grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_RESET.html

resetStmt
    : RESET (resetTarget | ALL)
    ;

resetTarget
    : parameterName
    | contextVariable
    ;

parameterName
    : identifier
    ;

contextVariable
    : identifier DOT identifier
    ;

identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    ;

// Keywords (these would typically be defined in the lexer)
RESET: 'RESET';
ALL: 'ALL';
DOT: '.';

// Identifiers
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
QUOTED_IDENTIFIER: '"' (~'"' | '""')* '"';

// Whitespace
WS: [ \t\r\n]+ -> skip;