// UPDATE command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_UPDATE.html

updateStatement
    : withClause? UPDATE targetTable setClauseList fromClause? whereClause?
    ;

withClause
    : WITH (RECURSIVE)? commonTableExpression (COMMA commonTableExpression)*
    ;

commonTableExpression
    : identifier (LEFT_PAREN columnList RIGHT_PAREN)? AS LEFT_PAREN selectStatement RIGHT_PAREN
    ;

targetTable
    : tableName tableAlias?
    | materializedViewName tableAlias?
    ;

setClauseList
    : SET setClause (COMMA setClause)*
    ;

setClause
    : columnName EQUALS expression
    | columnName EQUALS DEFAULT
    | LEFT_PAREN columnList RIGHT_PAREN EQUALS LEFT_PAREN expressionList RIGHT_PAREN
    | LEFT_PAREN columnList RIGHT_PAREN EQUALS LEFT_PAREN selectStatement RIGHT_PAREN
    ;

fromClause
    : FROM tableReference (COMMA tableReference)*
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
    | materializedViewName (AS? tableAlias)?
    | LEFT_PAREN selectStatement RIGHT_PAREN (AS? tableAlias)
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
    | caseExpression
    | expression operator expression
    | expression comparisonOperator expression
    | expression (NOT)? IN LEFT_PAREN (selectStatement | expressionList) RIGHT_PAREN
    | expression (NOT)? BETWEEN expression AND expression
    | expression IS (NOT)? NULL
    | expression (NOT)? LIKE expression (ESCAPE expression)?
    | expression (NOT)? ILIKE expression (ESCAPE expression)?
    | (NOT)? EXISTS LEFT_PAREN selectStatement RIGHT_PAREN
    | LEFT_PAREN expression RIGHT_PAREN
    | condition AND condition
    | condition OR condition
    | NOT condition
    | expression CONCAT expression
    | PLUS expression
    | MINUS expression
    ;

columnReference
    : columnName
    | tableName DOT columnName
    | tableAlias DOT columnName
    | identifier DOT identifier DOT identifier  // schema.table.column
    ;

functionCall
    : functionName LEFT_PAREN (DISTINCT | ALL)? (expressionList)? RIGHT_PAREN
    | functionName LEFT_PAREN STAR RIGHT_PAREN
    ;

functionName
    : identifier
    | identifier DOT identifier  // schema.function
    ;

caseExpression
    : CASE expression? whenClause+ elseClause? END
    ;

whenClause
    : WHEN expression THEN expression
    ;

elseClause
    : ELSE expression
    ;

expressionList
    : expression (COMMA expression)*
    ;

selectStatement
    : withClause? SELECT (DISTINCT | ALL)? selectList FROM fromClause 
      (whereClause)? (groupByClause)? (havingClause)? (orderByClause)? (limitClause)?
    ;

selectList
    : STAR
    | selectItem (COMMA selectItem)*
    ;

selectItem
    : expression (AS? identifier)?
    ;

groupByClause
    : GROUP BY expressionList
    ;

havingClause
    : HAVING condition
    ;

orderByClause
    : ORDER BY orderItem (COMMA orderItem)*
    ;

orderItem
    : expression (ASC | DESC)? (NULLS (FIRST | LAST))?
    ;

limitClause
    : LIMIT expression
    ;

literal
    : NUMBER
    | STRING_LITERAL
    | BOOLEAN_LITERAL
    | NULL
    | CURRENT_DATE
    | CURRENT_TIME
    | CURRENT_TIMESTAMP
    | DEFAULT
    ;

operator
    : PLUS | MINUS | MULTIPLY | DIVIDE | MODULO | CONCAT
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
    | ALL | DISTINCT | GROUP | ORDER | BY | HAVING
    | LIMIT | CASE | WHEN | THEN | ELSE | END
    | ESCAPE | RECURSIVE | CURRENT_DATE | CURRENT_TIME
    | CURRENT_TIMESTAMP
    ;

// Keywords and operators
UPDATE: 'UPDATE';
SET: 'SET';
FROM: 'FROM';
WHERE: 'WHERE';
WITH: 'WITH';
RECURSIVE: 'RECURSIVE';
AS: 'AS';
AND: 'AND';
OR: 'OR';
NOT: 'NOT';
IN: 'IN';
BETWEEN: 'BETWEEN';
IS: 'IS';
NULL: 'NULL';
LIKE: 'LIKE';
ILIKE: 'ILIKE';
ESCAPE: 'ESCAPE';
EXISTS: 'EXISTS';
SELECT: 'SELECT';
DISTINCT: 'DISTINCT';
ALL: 'ALL';
GROUP: 'GROUP';
BY: 'BY';
HAVING: 'HAVING';
ORDER: 'ORDER';
ASC: 'ASC';
DESC: 'DESC';
NULLS: 'NULLS';
FIRST: 'FIRST';
LAST: 'LAST';
LIMIT: 'LIMIT';
CASE: 'CASE';
WHEN: 'WHEN';
THEN: 'THEN';
ELSE: 'ELSE';
END: 'END';
DEFAULT: 'DEFAULT';
CURRENT_DATE: 'CURRENT_DATE';
CURRENT_TIME: 'CURRENT_TIME';
CURRENT_TIMESTAMP: 'CURRENT_TIMESTAMP';

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
CONCAT: '||';

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