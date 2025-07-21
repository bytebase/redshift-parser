// ALTER TABLE APPEND statement - Redshift-specific command

altertableappendstmt:
    ALTER TABLE qualified_name APPEND FROM qualified_name altertableappendoption?
    ;

altertableappendoption:
    IGNOREEXTRA | FILLTARGET
    ;

// Needed tokens: ALTER, TABLE, APPEND, FROM, IGNOREEXTRA, FILLTARGET