// SHOW EXTERNAL TABLE statement - Redshift-specific command

showexternaltablestmt:
    SHOW EXTERNAL TABLE qualified_name (PARTITION)?
    ;

// Needed tokens: SHOW, EXTERNAL, TABLE, PARTITION