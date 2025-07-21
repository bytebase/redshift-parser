// START TRANSACTION grammar rules for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_START_TRANSACTION.html
// START TRANSACTION is a synonym of BEGIN in Redshift

start_transaction_stmt
    : START TRANSACTION transaction_mode_list?
    ;

// Transaction modes can be specified in any order
transaction_mode_list
    : transaction_mode_item+
    ;

transaction_mode_item
    : isolation_level
    | read_write_mode
    ;

isolation_level
    : ISOLATION LEVEL isolation_level_spec
    ;

isolation_level_spec
    : SERIALIZABLE
    | READ UNCOMMITTED
    | READ COMMITTED  
    | REPEATABLE READ
    ;

read_write_mode
    : READ WRITE
    | READ ONLY
    ;

// Keywords (to be added to lexer)
START: S T A R T;
TRANSACTION: T R A N S A C T I O N;
ISOLATION: I S O L A T I O N;
LEVEL: L E V E L;
SERIALIZABLE: S E R I A L I Z A B L E;
READ: R E A D;
UNCOMMITTED: U N C O M M I T T E D;
COMMITTED: C O M M I T T E D;
REPEATABLE: R E P E A T A B L E;
WRITE: W R I T E;
ONLY: O N L Y;

// Case-insensitive letter fragments
fragment A: [aA];
fragment B: [bB];
fragment C: [cC];
fragment D: [dD];
fragment E: [eE];
fragment F: [fF];
fragment G: [gG];
fragment H: [hH];
fragment I: [iI];
fragment J: [jJ];
fragment K: [kK];
fragment L: [lL];
fragment M: [mM];
fragment N: [nN];
fragment O: [oO];
fragment P: [pP];
fragment Q: [qQ];
fragment R: [rR];
fragment S: [sS];
fragment T: [tT];
fragment U: [uU];
fragment V: [vV];
fragment W: [wW];
fragment X: [xX];
fragment Y: [yY];
fragment Z: [zZ];