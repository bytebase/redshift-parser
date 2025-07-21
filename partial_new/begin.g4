// BEGIN command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_BEGIN.html

beginStmt
    : BEGIN (WORK | TRANSACTION)? isolationLevel? accessMode?
    | START TRANSACTION isolationLevel? accessMode?
    ;

isolationLevel
    : ISOLATION LEVEL isolationLevelOption
    ;

isolationLevelOption
    : SERIALIZABLE
    | READ UNCOMMITTED
    | READ COMMITTED  
    | REPEATABLE READ
    ;

accessMode
    : READ WRITE
    | READ ONLY
    ;

// Keywords (these would typically be defined in the lexer)
BEGIN: 'BEGIN';
START: 'START';
TRANSACTION: 'TRANSACTION';
WORK: 'WORK';
ISOLATION: 'ISOLATION';
LEVEL: 'LEVEL';
SERIALIZABLE: 'SERIALIZABLE';
READ: 'READ';
UNCOMMITTED: 'UNCOMMITTED';
COMMITTED: 'COMMITTED';
REPEATABLE: 'REPEATABLE';
WRITE: 'WRITE';
ONLY: 'ONLY';