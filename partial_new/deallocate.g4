// DEALLOCATE command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_DEALLOCATE.html

deallocateStmt
    : DEALLOCATE prepareKeyword? deallocateTarget
    ;

prepareKeyword
    : PREPARE
    ;

deallocateTarget
    : statementName
    | ALL
    ;

statementName
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
    | PREPARE
    | WORK
    | TRANSACTION
    | LEVEL
    | WRITE
    | ONLY
    | COMMITTED
    | UNCOMMITTED
    | REPEATABLE
    | SERIALIZABLE
    | CURSOR
    | BINARY
    | INSENSITIVE
    | SCROLL
    ;

// Keywords (these would typically be defined in the lexer)
DEALLOCATE: 'DEALLOCATE';
PREPARE: 'PREPARE';
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
CURSOR: 'CURSOR';
BINARY: 'BINARY';
INSENSITIVE: 'INSENSITIVE';
SCROLL: 'SCROLL';

// Tokens
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_$]*;
DOUBLE_QUOTED_IDENTIFIER: '"' (~["\r\n] | '""')+ '"';