// ALTER EXTERNAL VIEW command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_EXTERNAL_VIEW.html

alterExternalViewStatement
    : ALTER EXTERNAL VIEW viewReference 
      (FORCE)? 
      (
          AS '(' selectStatement ')'
        | REMOVE DEFINITION
      )
    ;

viewReference
    : (catalogName=identifier '.')? schemaName=identifier '.' viewName=identifier
    | AWSDATACATALOG '.' dbName=identifier '.' viewName=identifier
    | externalSchemaName=identifier '.' viewName=identifier
    ;

// Tokens (these would typically be in the lexer file)
ALTER: 'ALTER';
EXTERNAL: 'EXTERNAL';
VIEW: 'VIEW';
FORCE: 'FORCE';
AS: 'AS';
REMOVE: 'REMOVE';
DEFINITION: 'DEFINITION';
AWSDATACATALOG: 'AWSDATACATALOG';

// Rules referenced from main parser (placeholders for this partial grammar)
identifier: ID;
selectStatement: SELECT .*? ';';  // Simplified for partial grammar

// Basic tokens
ID: [a-zA-Z_][a-zA-Z0-9_]*;
SELECT: 'SELECT';
WS: [ \t\r\n]+ -> skip;