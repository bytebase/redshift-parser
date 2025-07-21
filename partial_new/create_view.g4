// CREATE VIEW command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_VIEW.html

createViewStatement
    : CREATE (OR REPLACE)? VIEW viewName
      (OPEN_PAREN columnNameList CLOSE_PAREN)?
      AS selectStatement
      (WITH NO SCHEMA BINDING)?
    ;

viewName
    : qualifiedName
    ;

columnNameList
    : columnName (COMMA columnName)*
    ;

columnName
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
      (UNION unionClause)*
    ;

selectList
    : selectItem (COMMA selectItem)*
    | ASTERISK
    ;

selectItem
    : expression (AS? columnAlias)?
    ;

fromClause
    : tableRef (joinClause)*
    | tableRef (COMMA tableRef)*
    ;

tableRef
    : qualifiedName (AS? tableAlias)?
    | OPEN_PAREN selectStatement CLOSE_PAREN (AS? tableAlias)?
    ;

joinClause
    : joinType? JOIN tableRef (ON expression)?
    ;

joinType
    : INNER
    | LEFT (OUTER)?
    | RIGHT (OUTER)?
    | FULL (OUTER)?
    | CROSS
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

unionClause
    : UNION (ALL)? selectStatement
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
    | caseExpression
    | expression IS (NOT)? NULL
    | expression (NOT)? IN OPEN_PAREN (expression (COMMA expression)* | selectStatement) CLOSE_PAREN
    | expression (NOT)? BETWEEN expression AND expression
    | expression (NOT)? LIKE expression
    | (NOT)? EXISTS OPEN_PAREN selectStatement CLOSE_PAREN
    ;

functionCall
    : identifier OPEN_PAREN (expression (COMMA expression)*)? CLOSE_PAREN
    | aggregateFunction
    | windowFunction
    ;

aggregateFunction
    : (COUNT | SUM | AVG | MIN | MAX) OPEN_PAREN (DISTINCT | ALL)? expression CLOSE_PAREN
    | COUNT OPEN_PAREN ASTERISK CLOSE_PAREN
    ;

windowFunction
    : (ROW_NUMBER | RANK | DENSE_RANK) OPEN_PAREN CLOSE_PAREN OVER OPEN_PAREN windowSpec CLOSE_PAREN
    ;

windowSpec
    : (PARTITION BY expression (COMMA expression)*)?
      (ORDER BY orderByItem (COMMA orderByItem)*)?
    ;

caseExpression
    : CASE (expression)? (WHEN expression THEN expression)+ (ELSE expression)? END
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
OR: 'OR';
REPLACE: 'REPLACE';
VIEW: 'VIEW';
AS: 'AS';
WITH: 'WITH';
NO: 'NO';
SCHEMA: 'SCHEMA';
BINDING: 'BINDING';
SELECT: 'SELECT';
FROM: 'FROM';
WHERE: 'WHERE';
GROUP: 'GROUP';
BY: 'BY';
HAVING: 'HAVING';
ORDER: 'ORDER';
LIMIT: 'LIMIT';
UNION: 'UNION';
ALL: 'ALL';
JOIN: 'JOIN';
INNER: 'INNER';
LEFT: 'LEFT';
RIGHT: 'RIGHT';
FULL: 'FULL';
OUTER: 'OUTER';
CROSS: 'CROSS';
ON: 'ON';
AND: 'AND';
IS: 'IS';
NOT: 'NOT';
NULL: 'NULL';
IN: 'IN';
BETWEEN: 'BETWEEN';
LIKE: 'LIKE';
EXISTS: 'EXISTS';
CASE: 'CASE';
WHEN: 'WHEN';
THEN: 'THEN';
ELSE: 'ELSE';
END: 'END';
COUNT: 'COUNT';
SUM: 'SUM';
AVG: 'AVG';
MIN: 'MIN';
MAX: 'MAX';
DISTINCT: 'DISTINCT';
ROW_NUMBER: 'ROW_NUMBER';
RANK: 'RANK';
DENSE_RANK: 'DENSE_RANK';
OVER: 'OVER';
PARTITION: 'PARTITION';
ASC: 'ASC';
DESC: 'DESC';
DOT: '.';
COMMA: ',';
ASTERISK: '*';
OPEN_PAREN: '(';
CLOSE_PAREN: ')';

// Operators
OPERATOR: '=' | '<>' | '!=' | '<' | '<=' | '>' | '>=' | '+' | '-' | '*' | '/' | '%' | 'AND' | 'OR';

// Rules referenced from main parser (placeholders for this partial grammar)
identifier: ID;

// Basic tokens
ID: [a-zA-Z_][a-zA-Z0-9_]*;
INTEGER_LITERAL: [0-9]+;
DECIMAL_LITERAL: [0-9]+ '.' [0-9]*;
STRING_LITERAL: '\'' (~['\r\n] | '\'\'')* '\'';
WS: [ \t\r\n]+ -> skip;