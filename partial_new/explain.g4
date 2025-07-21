// EXPLAIN command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_EXPLAIN.html

explainStatement
    : EXPLAIN (VERBOSE)? query
    ;

// Query statements that can be explained
query
    : selectStatement
    | selectIntoStatement
    | createTableAsStatement
    | insertStatement
    | updateStatement
    | deleteStatement
    ;

// Basic SELECT statement structure
selectStatement
    : SELECT selectList
      (FROM fromClause)?
      (WHERE whereClause)?
      (GROUP BY groupByClause)?
      (HAVING havingClause)?
      (ORDER BY orderByClause)?
      (LIMIT limitClause)?
      (OFFSET offsetClause)?
    | LEFT_PAREN selectStatement RIGHT_PAREN
    | selectStatement UNION (ALL | DISTINCT)? selectStatement
    | selectStatement INTERSECT (ALL | DISTINCT)? selectStatement
    | selectStatement EXCEPT (ALL | DISTINCT)? selectStatement
    | withClause selectStatement
    ;

// SELECT INTO statement
selectIntoStatement
    : SELECT selectList INTO tableName
      (FROM fromClause)?
      (WHERE whereClause)?
      (GROUP BY groupByClause)?
      (HAVING havingClause)?
      (ORDER BY orderByClause)?
      (LIMIT limitClause)?
    ;

// CREATE TABLE AS statement
createTableAsStatement
    : CREATE (LOCAL? (TEMPORARY | TEMP))? TABLE (IF NOT EXISTS)? tableName
      (LEFT_PAREN columnNameList RIGHT_PAREN)?
      (BACKUP (YES | NO))?
      tableAttributeList?
      AS selectStatement
      (WITH NO SCHEMA BINDING)?
    ;

// INSERT statement
insertStatement
    : INSERT INTO tableName (LEFT_PAREN columnNameList RIGHT_PAREN)?
      (VALUES LEFT_PAREN valuesList RIGHT_PAREN (COMMA LEFT_PAREN valuesList RIGHT_PAREN)*
      | selectStatement)
    ;

// UPDATE statement
updateStatement
    : UPDATE tableName 
      SET updateItem (COMMA updateItem)*
      (FROM fromClause)?
      (WHERE whereClause)?
    ;

// DELETE statement
deleteStatement
    : DELETE FROM tableName
      (USING fromClause)?
      (WHERE whereClause)?
    ;

// Supporting clauses
withClause
    : WITH (RECURSIVE)? cteList
    ;

cteList
    : cte (COMMA cte)*
    ;

cte
    : cteName (LEFT_PAREN columnNameList RIGHT_PAREN)? AS LEFT_PAREN selectStatement RIGHT_PAREN
    ;

selectList
    : STAR
    | selectItem (COMMA selectItem)*
    ;

selectItem
    : expression (AS? columnAlias)?
    | tableName DOT STAR
    ;

fromClause
    : tableReference (COMMA tableReference)*
    | tableReference joinClause*
    ;

tableReference
    : tableName (AS? tableAlias)?
    | LEFT_PAREN selectStatement RIGHT_PAREN (AS? tableAlias)?
    | functionCall (AS? tableAlias)?
    ;

joinClause
    : joinType? JOIN tableReference (ON expression | USING LEFT_PAREN columnNameList RIGHT_PAREN)?
    ;

joinType
    : INNER
    | LEFT (OUTER)?
    | RIGHT (OUTER)?
    | FULL (OUTER)?
    | CROSS
    ;

whereClause
    : expression
    ;

groupByClause
    : groupByItem (COMMA groupByItem)*
    ;

groupByItem
    : expression
    | ROLLUP LEFT_PAREN expressionList RIGHT_PAREN
    | CUBE LEFT_PAREN expressionList RIGHT_PAREN
    | GROUPING SETS LEFT_PAREN groupingSetsItem (COMMA groupingSetsItem)* RIGHT_PAREN
    ;

groupingSetsItem
    : LEFT_PAREN expressionList? RIGHT_PAREN
    | expression
    ;

havingClause
    : expression
    ;

orderByClause
    : orderByItem (COMMA orderByItem)*
    ;

orderByItem
    : expression (ASC | DESC)? (NULLS (FIRST | LAST))?
    ;

limitClause
    : NUMBER
    | ALL
    ;

offsetClause
    : NUMBER
    ;

tableAttributeList
    : tableAttribute+
    ;

tableAttribute
    : DISTSTYLE (ALL | EVEN | KEY | AUTO)
    | DISTKEY LEFT_PAREN columnName RIGHT_PAREN
    | sortKeyClause
    | ENCODE AUTO
    ;

sortKeyClause
    : sortKeyType? SORTKEY LEFT_PAREN columnNameList RIGHT_PAREN
    ;

sortKeyType
    : COMPOUND
    | INTERLEAVED
    ;

updateItem
    : columnName EQUALS expression
    ;

valuesList
    : expression (COMMA expression)*
    ;

// Expression handling
expression
    : literal
    | columnReference
    | functionCall
    | caseExpression
    | castExpression
    | expression operator expression
    | unaryOperator expression
    | LEFT_PAREN expression RIGHT_PAREN
    | expression IS (NOT)? NULL
    | expression IS (NOT)? DISTINCT FROM expression
    | expression (NOT)? IN LEFT_PAREN (expressionList | selectStatement) RIGHT_PAREN
    | expression (NOT)? LIKE expression (ESCAPE expression)?
    | expression (NOT)? BETWEEN expression AND expression
    | (NOT)? EXISTS LEFT_PAREN selectStatement RIGHT_PAREN
    | expression comparisonOperator (ALL | SOME | ANY) LEFT_PAREN selectStatement RIGHT_PAREN
    ;

columnReference
    : columnName
    | tableName DOT columnName
    | tableAlias DOT columnName
    | schemaName DOT tableName DOT columnName
    ;

functionCall
    : functionName LEFT_PAREN (DISTINCT | ALL)? (functionArgument (COMMA functionArgument)*)? RIGHT_PAREN
    ;

functionArgument
    : expression
    ;

caseExpression
    : CASE expression? whenClauseList (ELSE expression)? END
    ;

whenClauseList
    : whenClause+
    ;

whenClause
    : WHEN expression THEN expression
    ;

castExpression
    : CAST LEFT_PAREN expression AS dataType RIGHT_PAREN
    | expression DOUBLE_COLON dataType
    ;

expressionList
    : expression (COMMA expression)*
    ;

// Data Types
dataType
    : SMALLINT
    | INTEGER | INT | INT2 | INT4 | INT8
    | BIGINT
    | DECIMAL (LEFT_PAREN NUMBER (COMMA NUMBER)? RIGHT_PAREN)?
    | NUMERIC (LEFT_PAREN NUMBER (COMMA NUMBER)? RIGHT_PAREN)?
    | REAL | FLOAT4
    | DOUBLE PRECISION | FLOAT8 | FLOAT
    | BOOLEAN | BOOL
    | CHAR (LEFT_PAREN NUMBER RIGHT_PAREN)?
    | CHARACTER (LEFT_PAREN NUMBER RIGHT_PAREN)?
    | VARCHAR (LEFT_PAREN NUMBER RIGHT_PAREN)?
    | CHARACTER VARYING (LEFT_PAREN NUMBER RIGHT_PAREN)?
    | TEXT | STRING
    | DATE
    | TIMESTAMP (WITHOUT TIME ZONE)?
    | TIMESTAMP WITH TIME ZONE | TIMESTAMPTZ
    | TIME (WITHOUT TIME ZONE)?
    | TIME WITH TIME ZONE | TIMETZ
    | INTERVAL
    | SUPER
    ;

// Operators
operator
    : PLUS | MINUS | STAR | SLASH | PERCENT | CONCAT
    | EQUALS | NOT_EQUALS | LESS_THAN | GREATER_THAN
    | LESS_THAN_OR_EQUAL | GREATER_THAN_OR_EQUAL
    | AND | OR
    ;

unaryOperator
    : PLUS | MINUS | NOT
    ;

comparisonOperator
    : EQUALS | NOT_EQUALS | LESS_THAN | GREATER_THAN
    | LESS_THAN_OR_EQUAL | GREATER_THAN_OR_EQUAL
    ;

// Supporting rules
columnNameList
    : columnName (COMMA columnName)*
    ;

literal
    : STRING_LITERAL
    | NUMBER
    | TRUE
    | FALSE
    | NULL
    | CURRENT_DATE
    | CURRENT_TIME
    | CURRENT_TIMESTAMP
    | CURRENT_USER
    | SESSION_USER
    | USER
    ;

// Identifiers
tableName : qualifiedName ;
columnName : identifier ;
columnAlias : identifier ;
tableAlias : identifier ;
cteName : identifier ;
functionName : identifier ;
schemaName : identifier ;

qualifiedName
    : identifier (DOT identifier)*
    ;

identifier
    : IDENTIFIER
    | DOUBLE_QUOTED_STRING
    ;

// Keywords
EXPLAIN : 'EXPLAIN' ;
VERBOSE : 'VERBOSE' ;
SELECT : 'SELECT' ;
FROM : 'FROM' ;
WHERE : 'WHERE' ;
GROUP : 'GROUP' ;
BY : 'BY' ;
HAVING : 'HAVING' ;
ORDER : 'ORDER' ;
LIMIT : 'LIMIT' ;
OFFSET : 'OFFSET' ;
UNION : 'UNION' ;
INTERSECT : 'INTERSECT' ;
EXCEPT : 'EXCEPT' ;
DISTINCT : 'DISTINCT' ;
ALL : 'ALL' ;
INTO : 'INTO' ;
CREATE : 'CREATE' ;
LOCAL : 'LOCAL' ;
TEMPORARY : 'TEMPORARY' ;
TEMP : 'TEMP' ;
TABLE : 'TABLE' ;
IF : 'IF' ;
NOT : 'NOT' ;
EXISTS : 'EXISTS' ;
AS : 'AS' ;
WITH : 'WITH' ;
RECURSIVE : 'RECURSIVE' ;
NO : 'NO' ;
SCHEMA : 'SCHEMA' ;
BINDING : 'BINDING' ;
BACKUP : 'BACKUP' ;
YES : 'YES' ;
INSERT : 'INSERT' ;
VALUES : 'VALUES' ;
UPDATE : 'UPDATE' ;
SET : 'SET' ;
DELETE : 'DELETE' ;
USING : 'USING' ;

// Table attributes
DISTSTYLE : 'DISTSTYLE' ;
EVEN : 'EVEN' ;
KEY : 'KEY' ;
AUTO : 'AUTO' ;
DISTKEY : 'DISTKEY' ;
SORTKEY : 'SORTKEY' ;
COMPOUND : 'COMPOUND' ;
INTERLEAVED : 'INTERLEAVED' ;
ENCODE : 'ENCODE' ;

// Join types
JOIN : 'JOIN' ;
INNER : 'INNER' ;
LEFT : 'LEFT' ;
RIGHT : 'RIGHT' ;
FULL : 'FULL' ;
OUTER : 'OUTER' ;
CROSS : 'CROSS' ;
ON : 'ON' ;

// Grouping
ROLLUP : 'ROLLUP' ;
CUBE : 'CUBE' ;
GROUPING : 'GROUPING' ;
SETS : 'SETS' ;

// Sort order
ASC : 'ASC' ;
DESC : 'DESC' ;
NULLS : 'NULLS' ;
FIRST : 'FIRST' ;
LAST : 'LAST' ;

// Data types
SMALLINT : 'SMALLINT' ;
INTEGER : 'INTEGER' ;
INT : 'INT' ;
INT2 : 'INT2' ;
INT4 : 'INT4' ;
INT8 : 'INT8' ;
BIGINT : 'BIGINT' ;
DECIMAL : 'DECIMAL' ;
NUMERIC : 'NUMERIC' ;
REAL : 'REAL' ;
FLOAT4 : 'FLOAT4' ;
DOUBLE : 'DOUBLE' ;
PRECISION : 'PRECISION' ;
FLOAT8 : 'FLOAT8' ;
FLOAT : 'FLOAT' ;
BOOLEAN : 'BOOLEAN' ;
BOOL : 'BOOL' ;
CHAR : 'CHAR' ;
CHARACTER : 'CHARACTER' ;
VARCHAR : 'VARCHAR' ;
VARYING : 'VARYING' ;
TEXT : 'TEXT' ;
STRING : 'STRING' ;
DATE : 'DATE' ;
TIMESTAMP : 'TIMESTAMP' ;
WITHOUT : 'WITHOUT' ;
TIME : 'TIME' ;
ZONE : 'ZONE' ;
TIMESTAMPTZ : 'TIMESTAMPTZ' ;
TIMETZ : 'TIMETZ' ;
INTERVAL : 'INTERVAL' ;
SUPER : 'SUPER' ;

// Expression keywords
CASE : 'CASE' ;
WHEN : 'WHEN' ;
THEN : 'THEN' ;
ELSE : 'ELSE' ;
END : 'END' ;
CAST : 'CAST' ;
IS : 'IS' ;
IN : 'IN' ;
LIKE : 'LIKE' ;
BETWEEN : 'BETWEEN' ;
AND : 'AND' ;
OR : 'OR' ;
SOME : 'SOME' ;
ANY : 'ANY' ;
ESCAPE : 'ESCAPE' ;

// Literals
TRUE : 'TRUE' ;
FALSE : 'FALSE' ;
NULL : 'NULL' ;
CURRENT_DATE : 'CURRENT_DATE' ;
CURRENT_TIME : 'CURRENT_TIME' ;
CURRENT_TIMESTAMP : 'CURRENT_TIMESTAMP' ;
CURRENT_USER : 'CURRENT_USER' ;
SESSION_USER : 'SESSION_USER' ;
USER : 'USER' ;

// Operators
EQUALS : '=' ;
NOT_EQUALS : '<>' | '!=' ;
LESS_THAN : '<' ;
GREATER_THAN : '>' ;
LESS_THAN_OR_EQUAL : '<=' ;
GREATER_THAN_OR_EQUAL : '>=' ;
PLUS : '+' ;
MINUS : '-' ;
STAR : '*' ;
SLASH : '/' ;
PERCENT : '%' ;
CONCAT : '||' ;
DOUBLE_COLON : '::' ;

// Delimiters
LEFT_PAREN : '(' ;
RIGHT_PAREN : ')' ;
COMMA : ',' ;
DOT : '.' ;
SEMICOLON : ';' ;

// Identifiers and strings
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

DOUBLE_QUOTED_STRING
    : '"' (~["] | '""')* '"'
    ;

STRING_LITERAL
    : '\'' (~['] | '\'\'')* '\''
    ;

NUMBER
    : [0-9]+ ('.' [0-9]+)?
    ;

// Whitespace and comments
WS : [ \t\r\n]+ -> skip ;
COMMENT : '--' ~[\r\n]* -> skip ;
BLOCK_COMMENT : '/*' .*? '*/' -> skip ;