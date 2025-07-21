// DELETE command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_DELETE.html

deleteStatement
    : withClause? DELETE (FROM)? targetTable usingClause? whereClause?
    ;

withClause
    : WITH (RECURSIVE)? commonTableExpression (COMMA commonTableExpression)*
    ;

commonTableExpression
    : identifier (LEFT_PAREN columnList RIGHT_PAREN)? AS LEFT_PAREN selectStatement RIGHT_PAREN
    ;

targetTable
    : tableName
    | materializedViewName
    ;

usingClause
    : USING tableReference (COMMA tableReference)*
    ;

whereClause
    : WHERE condition
    ;

// Supporting rules
tableName
    : identifier
    | identifier DOT identifier  // schema.table_name
    ;

materializedViewName
    : identifier
    | identifier DOT identifier  // schema.mv_name
    ;

tableReference
    : tableName (AS? tableAlias)?
    ;

tableAlias
    : identifier
    ;

columnList
    : columnName (COMMA columnName)*
    ;

columnName
    : identifier
    ;

condition
    : expression
    ;

expression
    : literal
    | columnReference
    | functionCall
    | expression operator expression
    | expression comparisonOperator expression
    | expression (NOT)? IN LEFT_PAREN (selectStatement | expressionList) RIGHT_PAREN
    | expression (NOT)? BETWEEN expression AND expression
    | expression IS (NOT)? NULL
    | expression (NOT)? LIKE expression (ESCAPE expression)?
    | (NOT)? EXISTS LEFT_PAREN selectStatement RIGHT_PAREN
    | LEFT_PAREN condition RIGHT_PAREN
    | condition AND condition
    | condition OR condition
    | NOT condition
    ;

columnReference
    : columnName
    | tableName DOT columnName
    | tableAlias DOT columnName
    ;

functionCall
    : functionName LEFT_PAREN (DISTINCT | ALL)? (expressionList)? RIGHT_PAREN
    ;

functionName
    : identifier
    ;

expressionList
    : expression (COMMA expression)*
    ;

selectStatement
    : SELECT selectList FROM fromClause (whereClause)? (groupByClause)? (orderByClause)?
    ;

selectList
    : STAR
    | selectItem (COMMA selectItem)*
    ;

selectItem
    : expression (AS? identifier)?
    ;

fromClause
    : tableReference (COMMA tableReference)*
    ;

groupByClause
    : GROUP BY expressionList
    ;

orderByClause
    : ORDER BY orderItem (COMMA orderItem)*
    ;

orderItem
    : expression (ASC | DESC)? (NULLS (FIRST | LAST))?
    ;

literal
    : NUMBER
    | STRING_LITERAL
    | BOOLEAN_LITERAL
    | NULL
    ;

operator
    : PLUS | MINUS | MULTIPLY | DIVIDE | MODULO
    ;

comparisonOperator
    : EQUALS | NOT_EQUALS | LESS_THAN | GREATER_THAN 
    | LESS_THAN_OR_EQUAL | GREATER_THAN_OR_EQUAL
    ;

identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    | nonReservedKeyword
    ;

nonReservedKeyword
    : AS | ASC | DESC | FIRST | LAST | NULLS
    | ALL | DISTINCT | GROUP | ORDER | BY
    ;

// Keywords and operators
DELETE: 'DELETE';
FROM: 'FROM';
WITH: 'WITH';
RECURSIVE: 'RECURSIVE';
USING: 'USING';
WHERE: 'WHERE';
AS: 'AS';
AND: 'AND';
OR: 'OR';
NOT: 'NOT';
IN: 'IN';
BETWEEN: 'BETWEEN';
IS: 'IS';
NULL: 'NULL';
LIKE: 'LIKE';
ESCAPE: 'ESCAPE';
EXISTS: 'EXISTS';
SELECT: 'SELECT';
DISTINCT: 'DISTINCT';
ALL: 'ALL';
GROUP: 'GROUP';
BY: 'BY';
ORDER: 'ORDER';
ASC: 'ASC';
DESC: 'DESC';
NULLS: 'NULLS';
FIRST: 'FIRST';
LAST: 'LAST';

// Operators
EQUALS: '=';
NOT_EQUALS: '<>' | '!=';
LESS_THAN: '<';
GREATER_THAN: '>';
LESS_THAN_OR_EQUAL: '<=';
GREATER_THAN_OR_EQUAL: '>=';
PLUS: '+';
MINUS: '-';
MULTIPLY: '*';
DIVIDE: '/';
MODULO: '%';

// Delimiters
LEFT_PAREN: '(';
RIGHT_PAREN: ')';
COMMA: ',';
DOT: '.';
STAR: '*';

// Literals
NUMBER: [0-9]+ ('.' [0-9]+)?;
STRING_LITERAL: '\'' (~'\'' | '\'\'')* '\'';
BOOLEAN_LITERAL: 'TRUE' | 'FALSE' | 'true' | 'false';

// Identifiers
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
QUOTED_IDENTIFIER: '"' (~'"' | '""')* '"';

// Whitespace and comments
WS: [ \t\r\n]+ -> skip;
COMMENT: '--' ~[\r\n]* -> skip;
BLOCK_COMMENT: '/*' .*? '*/' -> skip;