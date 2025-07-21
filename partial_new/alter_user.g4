// ALTER USER statement - Redshift-specific command

alteruserstmt:
    ALTER USER rolespec (WITH)? alteruseroptionlist
    ;

alteruseroptionlist:
    alteruseroption (',' alteruseroption)*
    ;

alteruseroption:
    CREATEDB | NOCREATEDB
    | CREATEUSER | NOCREATEUSER
    | SYSLOG ACCESS (RESTRICTED | UNRESTRICTED)
    | PASSWORD passoption
    | VALID UNTIL sconst
    | RENAME TO colid
    | CONNECTION LIMIT (signediconst | UNLIMITED)
    | SESSION TIMEOUT signediconst
    | RESET SESSION TIMEOUT
    | SET colid opt_equal def_elem
    | RESET colid
    | EXTERNALID sconst
    ;

passoption:
    sconst | DISABLE | NULL
    ;

// Needed tokens: ALTER, USER, WITH, CREATEDB, NOCREATEDB, CREATEUSER, NOCREATEUSER,
// SYSLOG, ACCESS, RESTRICTED, UNRESTRICTED, PASSWORD, VALID, UNTIL, RENAME, TO,
// CONNECTION, LIMIT, UNLIMITED, SESSION, TIMEOUT, RESET, SET, EXTERNALID, DISABLE