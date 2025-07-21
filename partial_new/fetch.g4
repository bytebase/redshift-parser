// FETCH command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_FETCH.html

fetchStmt
    : FETCH fetchDirection? FROM cursorName
    ;

fetchDirection
    : NEXT
    | ALL
    | FORWARD fetchCount?
    | FORWARD ALL
    ;

fetchCount
    : INTEGER_LITERAL
    | PARAMETER
    ;

cursorName
    : identifier
    ;

identifier
    : IDENTIFIER
    | quotedIdentifier
    | unreservedKeyword
    ;

quotedIdentifier
    : DOUBLE_QUOTED_IDENTIFIER
    ;

unreservedKeyword
    : ALL
    | NEXT
    | FORWARD
    | WORK
    | TRANSACTION
    | LEVEL
    | WRITE
    | ONLY
    | COMMITTED
    | UNCOMMITTED
    | REPEATABLE
    | SERIALIZABLE
    | FIRST
    | LAST
    | ASC
    | DESC
    | NULLS
    ;

// Keywords (these would typically be defined in the lexer)
FETCH: 'FETCH';
NEXT: 'NEXT';
ALL: 'ALL';
FORWARD: 'FORWARD';
FROM: 'FROM';
WORK: 'WORK';
TRANSACTION: 'TRANSACTION';
LEVEL: 'LEVEL';
WRITE: 'WRITE';
ONLY: 'ONLY';
COMMITTED: 'COMMITTED';
UNCOMMITTED: 'UNCOMMITTED';
REPEATABLE: 'REPEATABLE';
SERIALIZABLE: 'SERIALIZABLE';
FIRST: 'FIRST';
LAST: 'LAST';
ASC: 'ASC';
DESC: 'DESC';
NULLS: 'NULLS';

// Tokens
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_$]*;
DOUBLE_QUOTED_IDENTIFIER: '"' (~["\r\n] | '""')+ '"';
INTEGER_LITERAL: [0-9]+;
PARAMETER: '$' [0-9]+;