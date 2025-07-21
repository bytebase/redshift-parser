// INSERT EXTERNAL TABLE statement - Redshift-specific command

insertexternaltablestmt:
    INSERT INTO qualified_name selectstmt
    ;

// Needed tokens: INSERT, INTO