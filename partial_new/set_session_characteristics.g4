// SET SESSION CHARACTERISTICS command grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_SET_SESSION_CHARACTERISTICS.html
// Note: This command is deprecated in Redshift but included for compatibility

setSessionCharacteristicsStmt
    : SET SESSION CHARACTERISTICS AS TRANSACTION transactionCharacteristics
    ;

transactionCharacteristics
    : transactionMode (',' transactionMode)*
    ;

transactionMode
    : isolationLevel
    | accessMode
    | deferrableMode
    ;

isolationLevel
    : ISOLATION LEVEL isolationLevelValue
    ;

isolationLevelValue
    : READ UNCOMMITTED
    | READ COMMITTED
    | REPEATABLE READ
    | SERIALIZABLE
    ;

accessMode
    : READ WRITE
    | READ ONLY
    ;

deferrableMode
    : DEFERRABLE
    | NOT DEFERRABLE
    ;

// Keywords
AS: 'AS';
CHARACTERISTICS: 'CHARACTERISTICS';
COMMITTED: 'COMMITTED';
DEFERRABLE: 'DEFERRABLE';
ISOLATION: 'ISOLATION';
LEVEL: 'LEVEL';
NOT: 'NOT';
ONLY: 'ONLY';
READ: 'READ';
REPEATABLE: 'REPEATABLE';
SERIALIZABLE: 'SERIALIZABLE';
SESSION: 'SESSION';
SET: 'SET';
TRANSACTION: 'TRANSACTION';
UNCOMMITTED: 'UNCOMMITTED';
WRITE: 'WRITE';

// Whitespace and comments
WS: [ \t\r\n]+ -> skip;
COMMENT: '--' ~[\r\n]* -> skip;
BLOCK_COMMENT: '/*' .*? '*/' -> skip;