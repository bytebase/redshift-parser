// SET SESSION CHARACTERISTICS statement - Redshift-specific command

setsessioncharacteristicsstmt:
    SET SESSION CHARACTERISTICS AS TRANSACTION transactioncharacteristics
    ;

transactioncharacteristics:
    transactionmode (',' transactionmode)*
    ;

transactionmode:
    isolationlevel | accessmode | deferrablemode
    ;

isolationlevel:
    ISOLATION LEVEL isolationlevelvalue
    ;

isolationlevelvalue:
    READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ | SERIALIZABLE
    ;

accessmode:
    READ WRITE | READ ONLY
    ;

deferrablemode:
    DEFERRABLE | NOT DEFERRABLE
    ;

// Needed tokens: SET, SESSION, CHARACTERISTICS, AS, TRANSACTION, ISOLATION, LEVEL,
// READ, UNCOMMITTED, COMMITTED, REPEATABLE, SERIALIZABLE, WRITE, ONLY, DEFERRABLE, NOT