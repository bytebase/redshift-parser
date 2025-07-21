// CREATE TABLE AS Grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_TABLE_AS.html

createTableAsStatement
    : CREATE (LOCAL? (TEMPORARY | TEMP))? TABLE (IF NOT EXISTS)? tableName
      (LEFT_PAREN columnNameList RIGHT_PAREN)?
      (BACKUP (YES | NO))?
      tableAttributeList?
      AS selectStatement
      (WITH NO SCHEMA BINDING)?
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

// Support both column list and SELECT statement
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
    | tableFunction (AS? tableAlias)?
    | LATERAL tableReference
    ;

joinClause
    : joinType? JOIN tableReference (ON joinCondition | USING LEFT_PAREN columnNameList RIGHT_PAREN)?
    ;

joinType
    : INNER
    | LEFT (OUTER)?
    | RIGHT (OUTER)?
    | FULL (OUTER)?
    | CROSS
    ;

tableFunction
    : functionName LEFT_PAREN (functionArgument (COMMA functionArgument)*)? RIGHT_PAREN
    ;

functionArgument
    : expression
    | NAMED parameterName ARROW expression
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

// Expression handling for complex queries
expression
    : literal
    | columnReference
    | functionCall
    | caseExpression
    | windowFunction
    | aggregateFunction
    | castExpression
    | extractFunction
    | intervalExpression
    | expression operator expression
    | unaryOperator expression
    | LEFT_PAREN expression RIGHT_PAREN
    | expression IS (NOT)? NULL
    | expression IS (NOT)? DISTINCT FROM expression
    | expression (NOT)? IN LEFT_PAREN (expressionList | selectStatement) RIGHT_PAREN
    | expression (NOT)? LIKE expression (ESCAPE expression)?
    | expression (NOT)? ILIKE expression (ESCAPE expression)?
    | expression (NOT)? SIMILAR TO expression (ESCAPE expression)?
    | expression (NOT)? BETWEEN expression AND expression
    | (NOT)? EXISTS LEFT_PAREN selectStatement RIGHT_PAREN
    | expression comparisonOperator (ALL | SOME | ANY) LEFT_PAREN selectStatement RIGHT_PAREN
    | arrayExpression
    | jsonExpression
    ;

columnReference
    : columnName
    | tableName DOT columnName
    | tableAlias DOT columnName
    | schemaName DOT tableName DOT columnName
    ;

functionCall
    : functionName LEFT_PAREN (DISTINCT | ALL)? (functionArgument (COMMA functionArgument)*)? RIGHT_PAREN
      (FILTER LEFT_PAREN WHERE expression RIGHT_PAREN)?
      (OVER windowSpecification)?
    ;

aggregateFunction
    : COUNT LEFT_PAREN (STAR | (DISTINCT | ALL)? expression) RIGHT_PAREN
    | (SUM | AVG | MIN | MAX) LEFT_PAREN (DISTINCT | ALL)? expression RIGHT_PAREN
    | (STDDEV | STDDEV_POP | STDDEV_SAMP | VARIANCE | VAR_POP | VAR_SAMP) LEFT_PAREN expression RIGHT_PAREN
    | (ARRAY_AGG | STRING_AGG) LEFT_PAREN (DISTINCT)? expression (COMMA expression)? (ORDER BY orderByClause)? RIGHT_PAREN
    | (PERCENTILE_CONT | PERCENTILE_DISC) LEFT_PAREN expression RIGHT_PAREN WITHIN GROUP LEFT_PAREN ORDER BY orderByItem RIGHT_PAREN
    | (APPROX_COUNT_DISTINCT | HLL_COUNT_DISTINCT) LEFT_PAREN expression RIGHT_PAREN
    ;

windowFunction
    : (ROW_NUMBER | RANK | DENSE_RANK | PERCENT_RANK | CUME_DIST) LEFT_PAREN RIGHT_PAREN OVER windowSpecification
    | (FIRST_VALUE | LAST_VALUE) LEFT_PAREN expression RIGHT_PAREN OVER windowSpecification
    | (LAG | LEAD) LEFT_PAREN expression (COMMA NUMBER (COMMA expression)?)? RIGHT_PAREN OVER windowSpecification
    | NTH_VALUE LEFT_PAREN expression COMMA NUMBER RIGHT_PAREN OVER windowSpecification
    | NTILE LEFT_PAREN NUMBER RIGHT_PAREN OVER windowSpecification
    ;

windowSpecification
    : LEFT_PAREN (PARTITION BY partitionByList)? (ORDER BY orderByClause)? (frameClause)? RIGHT_PAREN
    ;

partitionByList
    : expression (COMMA expression)*
    ;

frameClause
    : (RANGE | ROWS) frameBound
    | (RANGE | ROWS) BETWEEN frameBound AND frameBound
    ;

frameBound
    : UNBOUNDED (PRECEDING | FOLLOWING)
    | CURRENT ROW
    | expression (PRECEDING | FOLLOWING)
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

extractFunction
    : EXTRACT LEFT_PAREN extractField FROM expression RIGHT_PAREN
    ;

extractField
    : CENTURY | DECADE | YEAR | QUARTER | MONTH | WEEK | DAY | DAYOFWEEK | DAYOFYEAR
    | HOUR | MINUTE | SECOND | MILLISECOND | MICROSECOND
    | DOW | DOY | EPOCH | TIMEZONE | TIMEZONE_HOUR | TIMEZONE_MINUTE
    ;

intervalExpression
    : INTERVAL expression intervalField
    ;

intervalField
    : YEAR | MONTH | DAY | HOUR | MINUTE | SECOND
    | YEAR TO MONTH | DAY TO HOUR | DAY TO MINUTE | DAY TO SECOND
    | HOUR TO MINUTE | HOUR TO SECOND | MINUTE TO SECOND
    ;

arrayExpression
    : ARRAY LEFT_BRACKET (expressionList)? RIGHT_BRACKET
    | arrayExpression LEFT_BRACKET expression RIGHT_BRACKET
    ;

jsonExpression
    : expression ARROW expression
    | expression DOUBLE_ARROW expression
    | expression HASH_ARROW expression
    | expression HASH_DOUBLE_ARROW expression
    | expression AT_QUESTION expression
    | expression AT_AT expression
    ;

expressionList
    : expression (COMMA expression)*
    ;

// Data Types for CAST operations
dataType
    : SMALLINT
    | INTEGER | INT | INT2 | INT4 | INT8
    | BIGINT
    | DECIMAL (LEFT_PAREN precision (COMMA scale)? RIGHT_PAREN)?
    | NUMERIC (LEFT_PAREN precision (COMMA scale)? RIGHT_PAREN)?
    | REAL | FLOAT4
    | DOUBLE PRECISION | FLOAT8 | FLOAT
    | BOOLEAN | BOOL
    | CHAR (LEFT_PAREN length RIGHT_PAREN)?
    | CHARACTER (LEFT_PAREN length RIGHT_PAREN)?
    | NCHAR (LEFT_PAREN length RIGHT_PAREN)?
    | BPCHAR (LEFT_PAREN length RIGHT_PAREN)?
    | VARCHAR (LEFT_PAREN length RIGHT_PAREN)?
    | CHARACTER VARYING (LEFT_PAREN length RIGHT_PAREN)?
    | NVARCHAR (LEFT_PAREN length RIGHT_PAREN)?
    | TEXT | STRING
    | VARBYTE (LEFT_PAREN length RIGHT_PAREN)?
    | VARBINARY (LEFT_PAREN length RIGHT_PAREN)?
    | BINARY VARYING (LEFT_PAREN length RIGHT_PAREN)?
    | DATE
    | TIMESTAMP (WITHOUT TIME ZONE)?
    | TIMESTAMP WITH TIME ZONE | TIMESTAMPTZ
    | TIME (WITHOUT TIME ZONE)?
    | TIME WITH TIME ZONE | TIMETZ
    | INTERVAL
    | GEOMETRY
    | GEOGRAPHY
    | HLLSKETCH
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

joinCondition
    : expression
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
parameterName : identifier ;
schemaName : identifier ;

qualifiedName
    : identifier (DOT identifier)*
    ;

identifier
    : IDENTIFIER
    | DOUBLE_QUOTED_STRING
    | nonReservedKeyword
    ;

precision : NUMBER ;
scale : NUMBER ;
length : NUMBER ;

nonReservedKeyword
    : ACTION | ADD | ALL | ALWAYS | AND | AS | ASC | AUTO | AVRO
    | BACKUP | BETWEEN | BIGINT | BINARY | BOOL | BOOLEAN | BPCHAR | BY | BYTEDICT
    | CACHE | CASCADE | CASE | CHAR | CHARACTER | CHECK | COLLATE | COLUMN | COMPOUND
    | CONSTRAINT | COUNT | CSV | CUBE | CURRENT_DATE | CURRENT_TIME | CURRENT_TIMESTAMP | CURRENT_USER | CYCLE
    | DATA | DATE | DECIMAL | DEFAULT | DELETE | DELTA | DELTA32K | DESC | DISTINCT | DISTKEY | DISTSTYLE
    | DOUBLE | DROP
    | ELSE | ENCODE | END | EVEN | EXISTS | EXTRACT
    | FALSE | FILTER | FIRST | FLOAT | FLOAT4 | FLOAT8 | FOR | FOREIGN | FROM | FULL
    | GENERATED | GEOGRAPHY | GEOMETRY | GROUP | GROUPING
    | HAVING | HLLSKETCH
    | IDENTITY | IF | IN | INCREMENT | INNER | INT | INT2 | INT4 | INT8 | INTEGER | INTERLEAVED | INTERVAL | IS
    | JOIN | JSON
    | KEY
    | LAST | LATERAL | LEFT | LIKE | LIMIT | LOCAL | LZO
    | MATCH | MAXVALUE | MINVALUE | MOSTLY16 | MOSTLY32 | MOSTLY8
    | NAMED | NO | NOT | NCHAR | NULL | NULLS | NUMBER | NUMERIC | NVARCHAR
    | OF | OFFSET | ON | OR | ORDER | OUTER | OVER | ORC
    | PARTITION | PARQUET | PARTIAL | PRECISION | PRIMARY
    | RANGE | RANK | RAW | RCFILE | REAL | RECURSIVE | REFERENCES | RESTRICT | RIGHT | ROLLUP | ROW | ROWS | RUNLENGTH
    | SCALE | SCHEMA | SELECT | SEQUENCEFILE | SESSION_USER | SET | SETS | SIMPLE | SMALLINT
    | SOME | SORTKEY | START | STRING | SUPER
    | TABLE | TEMP | TEMPORARY | TEXT | TEXT255 | TEXT32K | TEXTFILE | THEN | TIME
    | TIMESTAMP | TIMESTAMPTZ | TIMETZ | TO | TRUE | TYPE
    | UNBOUNDED | UNION | UNIQUE | UPDATE | USER | USING
    | VARBINARY | VARBYTE | VARCHAR | VARYING
    | WHEN | WHERE | WINDOW | WITH | WITHIN | WITHOUT
    | YES
    | ZONE | ZSTD
    ;

// Lexer tokens (comprehensive set for CREATE TABLE AS)
CREATE : 'CREATE' ;
LOCAL : 'LOCAL' ;
TEMPORARY : 'TEMPORARY' ;
TEMP : 'TEMP' ;
TABLE : 'TABLE' ;
IF : 'IF' ;
NOT : 'NOT' ;
EXISTS : 'EXISTS' ;
AS : 'AS' ;
BACKUP : 'BACKUP' ;
YES : 'YES' ;
NO : 'NO' ;
DISTSTYLE : 'DISTSTYLE' ;
ALL : 'ALL' ;
EVEN : 'EVEN' ;
KEY : 'KEY' ;
AUTO : 'AUTO' ;
DISTKEY : 'DISTKEY' ;
SORTKEY : 'SORTKEY' ;
COMPOUND : 'COMPOUND' ;
INTERLEAVED : 'INTERLEAVED' ;
ENCODE : 'ENCODE' ;
WITH : 'WITH' ;
SCHEMA : 'SCHEMA' ;
BINDING : 'BINDING' ;

// SQL keywords
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
RECURSIVE : 'RECURSIVE' ;

// Join keywords
JOIN : 'JOIN' ;
INNER : 'INNER' ;
LEFT : 'LEFT' ;
RIGHT : 'RIGHT' ;
FULL : 'FULL' ;
OUTER : 'OUTER' ;
CROSS : 'CROSS' ;
ON : 'ON' ;
USING : 'USING' ;
LATERAL : 'LATERAL' ;

// Function keywords
COUNT : 'COUNT' ;
SUM : 'SUM' ;
AVG : 'AVG' ;
MIN : 'MIN' ;
MAX : 'MAX' ;
STDDEV : 'STDDEV' ;
STDDEV_POP : 'STDDEV_POP' ;
STDDEV_SAMP : 'STDDEV_SAMP' ;
VARIANCE : 'VARIANCE' ;
VAR_POP : 'VAR_POP' ;
VAR_SAMP : 'VAR_SAMP' ;
ARRAY_AGG : 'ARRAY_AGG' ;
STRING_AGG : 'STRING_AGG' ;
PERCENTILE_CONT : 'PERCENTILE_CONT' ;
PERCENTILE_DISC : 'PERCENTILE_DISC' ;
WITHIN : 'WITHIN' ;
APPROX_COUNT_DISTINCT : 'APPROX_COUNT_DISTINCT' ;
HLL_COUNT_DISTINCT : 'HLL_COUNT_DISTINCT' ;

// Window function keywords
ROW_NUMBER : 'ROW_NUMBER' ;
RANK : 'RANK' ;
DENSE_RANK : 'DENSE_RANK' ;
PERCENT_RANK : 'PERCENT_RANK' ;
CUME_DIST : 'CUME_DIST' ;
FIRST_VALUE : 'FIRST_VALUE' ;
LAST_VALUE : 'LAST_VALUE' ;
LAG : 'LAG' ;
LEAD : 'LEAD' ;
NTH_VALUE : 'NTH_VALUE' ;
NTILE : 'NTILE' ;
OVER : 'OVER' ;
PARTITION : 'PARTITION' ;
WINDOW : 'WINDOW' ;
RANGE : 'RANGE' ;
ROWS : 'ROWS' ;
UNBOUNDED : 'UNBOUNDED' ;
PRECEDING : 'PRECEDING' ;
FOLLOWING : 'FOLLOWING' ;
CURRENT : 'CURRENT' ;
ROW : 'ROW' ;

// Grouping keywords
ROLLUP : 'ROLLUP' ;
CUBE : 'CUBE' ;
GROUPING : 'GROUPING' ;
SETS : 'SETS' ;

// Expression keywords
CASE : 'CASE' ;
WHEN : 'WHEN' ;
THEN : 'THEN' ;
ELSE : 'ELSE' ;
END : 'END' ;
CAST : 'CAST' ;
EXTRACT : 'EXTRACT' ;
INTERVAL : 'INTERVAL' ;
ARRAY : 'ARRAY' ;
IS : 'IS' ;
IN : 'IN' ;
LIKE : 'LIKE' ;
ILIKE : 'ILIKE' ;
SIMILAR : 'SIMILAR' ;
BETWEEN : 'BETWEEN' ;
AND : 'AND' ;
OR : 'OR' ;
SOME : 'SOME' ;
ANY : 'ANY' ;
FILTER : 'FILTER' ;
ESCAPE : 'ESCAPE' ;
NAMED : 'NAMED' ;

// Extract fields
CENTURY : 'CENTURY' ;
DECADE : 'DECADE' ;
YEAR : 'YEAR' ;
QUARTER : 'QUARTER' ;
MONTH : 'MONTH' ;
WEEK : 'WEEK' ;
DAY : 'DAY' ;
DAYOFWEEK : 'DAYOFWEEK' ;
DAYOFYEAR : 'DAYOFYEAR' ;
HOUR : 'HOUR' ;
MINUTE : 'MINUTE' ;
SECOND : 'SECOND' ;
MILLISECOND : 'MILLISECOND' ;
MICROSECOND : 'MICROSECOND' ;
DOW : 'DOW' ;
DOY : 'DOY' ;
EPOCH : 'EPOCH' ;
TIMEZONE : 'TIMEZONE' ;
TIMEZONE_HOUR : 'TIMEZONE_HOUR' ;
TIMEZONE_MINUTE : 'TIMEZONE_MINUTE' ;

// Sort order
ASC : 'ASC' ;
DESC : 'DESC' ;
NULLS : 'NULLS' ;
FIRST : 'FIRST' ;
LAST : 'LAST' ;

// Data type keywords
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
NCHAR : 'NCHAR' ;
BPCHAR : 'BPCHAR' ;
VARCHAR : 'VARCHAR' ;
VARYING : 'VARYING' ;
NVARCHAR : 'NVARCHAR' ;
TEXT : 'TEXT' ;
STRING : 'STRING' ;
VARBYTE : 'VARBYTE' ;
VARBINARY : 'VARBINARY' ;
BINARY : 'BINARY' ;
DATE : 'DATE' ;
TIMESTAMP : 'TIMESTAMP' ;
WITHOUT : 'WITHOUT' ;
TIME : 'TIME' ;
ZONE : 'ZONE' ;
TIMESTAMPTZ : 'TIMESTAMPTZ' ;
TIMETZ : 'TIMETZ' ;
GEOMETRY : 'GEOMETRY' ;
GEOGRAPHY : 'GEOGRAPHY' ;
HLLSKETCH : 'HLLSKETCH' ;
SUPER : 'SUPER' ;

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

// Other keywords
ACTION : 'ACTION' ;
ADD : 'ADD' ;
ALWAYS : 'ALWAYS' ;
AVRO : 'AVRO' ;
BYTEDICT : 'BYTEDICT' ;
CACHE : 'CACHE' ;
CASCADE : 'CASCADE' ;
CHECK : 'CHECK' ;
COLLATE : 'COLLATE' ;
COLUMN : 'COLUMN' ;
CONSTRAINT : 'CONSTRAINT' ;
CSV : 'CSV' ;
CURRENT : 'CURRENT' ;
CYCLE : 'CYCLE' ;
DATA : 'DATA' ;
DEFAULT : 'DEFAULT' ;
DELETE : 'DELETE' ;
DELTA : 'DELTA' ;
DELTA32K : 'DELTA32K' ;
DROP : 'DROP' ;
FOR : 'FOR' ;
FOREIGN : 'FOREIGN' ;
GENERATED : 'GENERATED' ;
IDENTITY : 'IDENTITY' ;
INCREMENT : 'INCREMENT' ;
JSON : 'JSON' ;
LZO : 'LZO' ;
MATCH : 'MATCH' ;
MAXVALUE : 'MAXVALUE' ;
MINVALUE : 'MINVALUE' ;
MOSTLY8 : 'MOSTLY8' ;
MOSTLY16 : 'MOSTLY16' ;
MOSTLY32 : 'MOSTLY32' ;
NUMBER : 'NUMBER' ;
OF : 'OF' ;
ORC : 'ORC' ;
PARQUET : 'PARQUET' ;
PARTIAL : 'PARTIAL' ;
PRIMARY : 'PRIMARY' ;
RAW : 'RAW' ;
RCFILE : 'RCFILE' ;
REFERENCES : 'REFERENCES' ;
RESTRICT : 'RESTRICT' ;
RUNLENGTH : 'RUNLENGTH' ;
SCALE : 'SCALE' ;
SEQUENCEFILE : 'SEQUENCEFILE' ;
SET : 'SET' ;
SIMPLE : 'SIMPLE' ;
START : 'START' ;
TEXT255 : 'TEXT255' ;
TEXT32K : 'TEXT32K' ;
TEXTFILE : 'TEXTFILE' ;
TO : 'TO' ;
TYPE : 'TYPE' ;
UNIQUE : 'UNIQUE' ;
UPDATE : 'UPDATE' ;
ZSTD : 'ZSTD' ;

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
ARROW : '->' ;
DOUBLE_ARROW : '->>' ;
HASH_ARROW : '#>' ;
HASH_DOUBLE_ARROW : '#>>' ;
AT_QUESTION : '@?' ;
AT_AT : '@@' ;
DOUBLE_COLON : '::' ;

// Delimiters
LEFT_PAREN : '(' ;
RIGHT_PAREN : ')' ;
LEFT_BRACKET : '[' ;
RIGHT_BRACKET : ']' ;
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