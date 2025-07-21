// CREATE EXTERNAL VIEW command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_EXTERNAL_VIEW.html

createExternalViewStatement
    : CREATE EXTERNAL (PROTECTED)? VIEW (IF_P NOT EXISTS)? viewName
      AS selectStatement
    ;

viewName
    : schemaName DOT identifier DOT identifier  // catalog_name.schema_name.view_name
    | identifier DOT identifier DOT identifier  // awsdatacatalog.dbname.view_name  
    | identifier DOT identifier                  // external_schema_name.view_name
    | identifier                                 // simple view name
    ;

schemaName
    : identifier
    ;

// SELECT statement can be complex - this is a simplified version
// In a full implementation, this would reference the main parser's selectStatement rule
selectStatement
    : SELECT selectList
      (FROM fromClause)?
      (WHERE whereClause)?
      (GROUP BY groupByClause)?
      (HAVING havingClause)?
      (ORDER BY orderByClause)?
      (LIMIT limitClause)?
    ;

selectList
    : selectItem (COMMA selectItem)*
    | ASTERISK
    ;

selectItem
    : expression (AS? columnAlias)?
    ;

fromClause
    : tableRef (COMMA tableRef)*
    ;

tableRef
    : qualifiedName (AS? tableAlias)?
    | OPEN_PAREN selectStatement CLOSE_PAREN (AS? tableAlias)?
    ;

qualifiedName
    : identifier (DOT identifier)*
    ;

whereClause
    : expression
    ;

groupByClause
    : expression (COMMA expression)*
    ;

havingClause
    : expression
    ;

orderByClause
    : orderByItem (COMMA orderByItem)*
    ;

orderByItem
    : expression (ASC | DESC)?
    ;

limitClause
    : INTEGER_LITERAL
    ;

expression
    : identifier
    | STRING_LITERAL
    | INTEGER_LITERAL
    | DECIMAL_LITERAL
    | qualifiedName
    | expression OPERATOR expression
    | OPEN_PAREN expression CLOSE_PAREN
    | functionCall
    ;

functionCall
    : identifier OPEN_PAREN (expression (COMMA expression)*)? CLOSE_PAREN
    ;

columnAlias
    : identifier
    | STRING_LITERAL
    ;

tableAlias
    : identifier
    ;

// Tokens (these would typically be in the lexer file)
CREATE: 'CREATE';
EXTERNAL: 'EXTERNAL';
PROTECTED: 'PROTECTED';
VIEW: 'VIEW';
IF_P: 'IF';
NOT: 'NOT';
EXISTS: 'EXISTS';
AS: 'AS';
SELECT: 'SELECT';
FROM: 'FROM';
WHERE: 'WHERE';
GROUP: 'GROUP';
BY: 'BY';
HAVING: 'HAVING';
ORDER: 'ORDER';
LIMIT: 'LIMIT';
ASC: 'ASC';
DESC: 'DESC';
DOT: '.';
COMMA: ',';
ASTERISK: '*';
OPEN_PAREN: '(';
CLOSE_PAREN: ')';

// Operators
OPERATOR: '=' | '<>' | '!=' | '<' | '<=' | '>' | '>=' | '+' | '-' | '*' | '/' | '%' | 'AND' | 'OR' | 'LIKE' | 'IN' | 'IS' | 'NULL';

// Rules referenced from main parser (placeholders for this partial grammar)
identifier: ID;

// Basic tokens
ID: [a-zA-Z_][a-zA-Z0-9_]*;
INTEGER_LITERAL: [0-9]+;
DECIMAL_LITERAL: [0-9]+ '.' [0-9]*;
STRING_LITERAL: '\'' (~['\r\n] | '\'\'')* '\'';
WS: [ \t\r\n]+ -> skip;