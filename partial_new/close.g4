// CLOSE command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CLOSE.html

closeStmt
    : CLOSE cursorName
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
    | WORK
    | TRANSACTION
    | LEVEL
    | WRITE
    | ONLY
    | COMMITTED
    | UNCOMMITTED
    | REPEATABLE
    | SERIALIZABLE
    ;

// Keywords (these would typically be defined in the lexer)
CLOSE: 'CLOSE';
ALL: 'ALL';
WORK: 'WORK';
TRANSACTION: 'TRANSACTION';
LEVEL: 'LEVEL';
WRITE: 'WRITE';
ONLY: 'ONLY';
COMMITTED: 'COMMITTED';
UNCOMMITTED: 'UNCOMMITTED';
REPEATABLE: 'REPEATABLE';
SERIALIZABLE: 'SERIALIZABLE';

// Tokens
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_$]*;
DOUBLE_QUOTED_IDENTIFIER: '"' (~["\r\n] | '""')+ '"';