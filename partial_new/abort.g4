// ABORT statement
// ABORT stops the current transaction and is equivalent to ROLLBACK
// Syntax: ABORT [ WORK | TRANSACTION ]
abortstmt
    : ABORT (WORK | TRANSACTION)?
    ;