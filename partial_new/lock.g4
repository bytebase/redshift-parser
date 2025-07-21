// LOCK command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_LOCK.html

lockStmt
    : LOCK (TABLE)? tableNameList (IN lockMode MODE)? (NOWAIT)?
    ;

tableNameList
    : tableName (',' tableName)*
    ;

tableName
    : IDENTIFIER ('.' IDENTIFIER)?
    ;

lockMode
    : ACCESS SHARE
    | ROW SHARE
    | ROW EXCLUSIVE
    | SHARE UPDATE EXCLUSIVE
    | SHARE ROW EXCLUSIVE
    | SHARE
    | EXCLUSIVE
    | ACCESS EXCLUSIVE
    ;

// Keywords (these would typically be defined in the lexer)
LOCK: 'LOCK';
TABLE: 'TABLE';
IN: 'IN';
MODE: 'MODE';
NOWAIT: 'NOWAIT';
ACCESS: 'ACCESS';
SHARE: 'SHARE';
ROW: 'ROW';
EXCLUSIVE: 'EXCLUSIVE';
UPDATE: 'UPDATE';
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;