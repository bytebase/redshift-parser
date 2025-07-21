// SET SESSION AUTHORIZATION statement - Redshift-specific command

setsessionauthorizationstmt:
    SET (LOCAL)? SESSION AUTHORIZATION (rolespec | DEFAULT)
    ;

// Needed tokens: SET, LOCAL, SESSION, AUTHORIZATION, DEFAULT