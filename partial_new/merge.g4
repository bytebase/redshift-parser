// MERGE command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_MERGE.html

mergeStatement
    : MERGE INTO targetTable USING sourceTable ON matchCondition
      whenClauseList?
      removeDuplicatesClause?
    ;

targetTable
    : tableName
    ;

sourceTable
    : tableName (AS? tableAlias)?
    | LEFT_PAREN selectStatement RIGHT_PAREN (AS? tableAlias)?
    ;

matchCondition
    : expression
    ;

whenClauseList
    : whenClause+
    ;

whenClause
    : whenMatchedClause
    | whenNotMatchedClause
    ;

whenMatchedClause
    : WHEN MATCHED THEN (updateAction | deleteAction)
    ;

whenNotMatchedClause
    : WHEN NOT MATCHED THEN insertAction
    ;

updateAction
    : UPDATE SET setClauseList
    ;

deleteAction
    : DELETE
    ;

insertAction
    : INSERT (LEFT_PAREN columnNameList RIGHT_PAREN)? VALUES LEFT_PAREN valuesList RIGHT_PAREN
    ;

setClauseList
    : setClause (COMMA setClause)*
    ;

setClause
    : columnName EQUALS expression
    ;

columnNameList
    : columnName (COMMA columnName)*
    ;

valuesList
    : expression (COMMA expression)*
    ;

removeDuplicatesClause
    : REMOVE DUPLICATES
    ;

// Supporting rules
tableName
    : identifier
    | identifier DOT identifier  // schema.table_name
    ;

tableAlias
    : identifier
    ;

columnName
    : identifier
    | tableAlias DOT identifier
    | tableName DOT identifier
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
    | LEFT_PAREN expression RIGHT_PAREN
    | expression AND expression
    | expression OR expression
    | NOT expression
    | CASE whenExpressionClauseList (ELSE expression)? END
    ;

whenExpressionClauseList
    : whenExpressionClause+
    ;

whenExpressionClause
    : WHEN expression THEN expression
    ;

columnReference
    : columnName
    | tableAlias DOT columnName
    | tableName DOT columnName
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
    : SELECT selectList FROM fromClause (whereClause)? (groupByClause)? (orderByClause)? (limitClause)?
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
    | tableReference joinClause*
    ;

tableReference
    : tableName (AS? tableAlias)?
    | LEFT_PAREN selectStatement RIGHT_PAREN (AS? tableAlias)?
    ;

joinClause
    : joinType? JOIN tableReference ON expression
    ;

joinType
    : INNER
    | LEFT (OUTER)?
    | RIGHT (OUTER)?
    | FULL (OUTER)?
    | CROSS
    ;

whereClause
    : WHERE expression
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

limitClause
    : LIMIT NUMBER
    ;

literal
    : NUMBER
    | STRING_LITERAL
    | BOOLEAN_LITERAL
    | NULL
    | CURRENT_DATE
    | CURRENT_TIME
    | CURRENT_TIMESTAMP
    | CURRENT_USER
    | SESSION_USER
    | USER
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
    | ALL | DISTINCT | GROUP | ORDER | BY
    | INNER | LEFT | RIGHT | FULL | OUTER | CROSS
    | CASE | WHEN | THEN | ELSE | END
    | CURRENT_DATE | CURRENT_TIME | CURRENT_TIMESTAMP
    | CURRENT_USER | SESSION_USER | USER
    | ESCAPE | EXISTS
    ;

// Keywords
MERGE: 'MERGE';
INTO: 'INTO';
USING: 'USING';
ON: 'ON';
WHEN: 'WHEN';
MATCHED: 'MATCHED';
NOT: 'NOT';
THEN: 'THEN';
UPDATE: 'UPDATE';
SET: 'SET';
DELETE: 'DELETE';
INSERT: 'INSERT';
VALUES: 'VALUES';
REMOVE: 'REMOVE';
DUPLICATES: 'DUPLICATES';
AS: 'AS';
AND: 'AND';
OR: 'OR';
IN: 'IN';
BETWEEN: 'BETWEEN';
IS: 'IS';
NULL: 'NULL';
LIKE: 'LIKE';
ESCAPE: 'ESCAPE';
EXISTS: 'EXISTS';
SELECT: 'SELECT';
FROM: 'FROM';
WHERE: 'WHERE';
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
LIMIT: 'LIMIT';
CASE: 'CASE';
WHEN: 'WHEN';
THEN: 'THEN';
ELSE: 'ELSE';
END: 'END';
INNER: 'INNER';
LEFT: 'LEFT';
RIGHT: 'RIGHT';
FULL: 'FULL';
OUTER: 'OUTER';
CROSS: 'CROSS';
JOIN: 'JOIN';
CURRENT_DATE: 'CURRENT_DATE';
CURRENT_TIME: 'CURRENT_TIME';
CURRENT_TIMESTAMP: 'CURRENT_TIMESTAMP';
CURRENT_USER: 'CURRENT_USER';
SESSION_USER: 'SESSION_USER';
USER: 'USER';

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