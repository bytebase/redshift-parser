// CREATE TABLE Grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_TABLE.html

createTableStatement
    : CREATE (LOCAL? (TEMPORARY | TEMP))? TABLE (IF NOT EXISTS)? tableName
      (LEFT_PAREN columnDefinitionList RIGHT_PAREN)?
      tableOptionList?
    | CREATE TABLE (IF NOT EXISTS)? tableName
      (LEFT_PAREN columnDefinitionList RIGHT_PAREN)?
      tableOptionList?
      AS selectStatement
    ;

columnDefinitionList
    : columnDefinition (COMMA columnDefinition)*
    ;

columnDefinition
    : columnName dataType columnConstraintList?
    ;

columnConstraintList
    : columnConstraint+
    ;

columnConstraint
    : NOT NULL
    | NULL
    | DEFAULT defaultExpression
    | IDENTITY LEFT_PAREN seedValue COMMA stepValue RIGHT_PAREN
    | GENERATED (ALWAYS | BY DEFAULT) AS IDENTITY (LEFT_PAREN identityOptions RIGHT_PAREN)?
    | PRIMARY KEY
    | UNIQUE
    | REFERENCES referencedTable (LEFT_PAREN referencedColumn RIGHT_PAREN)?
      (MATCH (FULL | PARTIAL | SIMPLE))?
      (ON DELETE referentialAction)?
      (ON UPDATE referentialAction)?
    | CHECK LEFT_PAREN checkExpression RIGHT_PAREN
    | ENCODE encodingType
    | DISTKEY
    | SORTKEY
    | COLLATE collationName
    ;

identityOptions
    : identityOption (COMMA identityOption)*
    ;

identityOption
    : START WITH startValue
    | INCREMENT BY incrementValue
    | MINVALUE minValue
    | MAXVALUE maxValue
    | NO (MINVALUE | MAXVALUE)
    | CACHE cacheValue
    | NO CACHE
    | CYCLE
    | NO CYCLE
    ;

referentialAction
    : CASCADE
    | SET NULL
    | SET DEFAULT
    | RESTRICT
    | NO ACTION
    ;

tableOptionList
    : tableOption+
    ;

tableOption
    : BACKUP (YES | NO)
    | DISTSTYLE (ALL | EVEN | KEY | AUTO)
    | DISTKEY LEFT_PAREN columnName RIGHT_PAREN
    | sortKeyClause
    | ENCODE AUTO
    | tableConstraintClause
    ;

sortKeyClause
    : sortKeyType? SORTKEY LEFT_PAREN columnNameList RIGHT_PAREN
    ;

sortKeyType
    : COMPOUND
    | INTERLEAVED
    ;

tableConstraintClause
    : CONSTRAINT constraintName? tableConstraint
    | tableConstraint
    ;

tableConstraint
    : PRIMARY KEY LEFT_PAREN columnNameList RIGHT_PAREN
    | UNIQUE LEFT_PAREN columnNameList RIGHT_PAREN
    | FOREIGN KEY LEFT_PAREN columnNameList RIGHT_PAREN
      REFERENCES referencedTable (LEFT_PAREN columnNameList RIGHT_PAREN)?
      (MATCH (FULL | PARTIAL | SIMPLE))?
      (ON DELETE referentialAction)?
      (ON UPDATE referentialAction)?
    | CHECK LEFT_PAREN checkExpression RIGHT_PAREN
    ;

// Data Types for Redshift
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
    | GEOMETRY
    | GEOGRAPHY
    | HLLSKETCH
    | SUPER
    ;

// Encoding types for Redshift
encodingType
    : AUTO
    | RAW
    | AZ64
    | BYTEDICT
    | DELTA
    | DELTA32K
    | LZO
    | MOSTLY8
    | MOSTLY16
    | MOSTLY32
    | RUNLENGTH
    | TEXT255
    | TEXT32K
    | ZSTD
    ;

// Supporting rules
columnNameList
    : columnName (COMMA columnName)*
    ;

defaultExpression
    : literal
    | functionCall
    | expression
    ;

checkExpression
    : expression
    ;

expression
    : literal
    | columnName
    | functionCall
    | expression operator expression
    | LEFT_PAREN expression RIGHT_PAREN
    | CASE whenClauseList (ELSE expression)? END
    ;

whenClauseList
    : whenClause+
    ;

whenClause
    : WHEN expression THEN expression
    ;

functionCall
    : functionName LEFT_PAREN (expression (COMMA expression)*)? RIGHT_PAREN
    ;

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
    : STAR
    | selectItem (COMMA selectItem)*
    ;

selectItem
    : expression (AS? columnAlias)?
    ;

fromClause
    : tableReference (COMMA tableReference)*
    ;

tableReference
    : tableName (AS? tableAlias)?
    | LEFT_PAREN selectStatement RIGHT_PAREN (AS? tableAlias)?
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
    : expression (ASC | DESC)? (NULLS (FIRST | LAST))?
    ;

limitClause
    : NUMBER
    ;

// Identifiers and literals
tableName : qualifiedName ;
columnName : identifier ;
referencedTable : qualifiedName ;
referencedColumn : identifier ;
constraintName : identifier ;
collationName : identifier ;
functionName : identifier ;
columnAlias : identifier ;
tableAlias : identifier ;

qualifiedName
    : identifier (DOT identifier)*
    ;

identifier
    : IDENTIFIER
    | DOUBLE_QUOTED_STRING
    | nonReservedKeyword
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

precision : NUMBER ;
scale : NUMBER ;
length : NUMBER ;
seedValue : NUMBER ;
stepValue : NUMBER ;
startValue : NUMBER ;
incrementValue : NUMBER ;
minValue : NUMBER ;
maxValue : NUMBER ;
cacheValue : NUMBER ;

operator
    : PLUS | MINUS | STAR | SLASH | PERCENT | CONCAT
    | EQUALS | NOT_EQUALS | LESS_THAN | GREATER_THAN
    | LESS_THAN_OR_EQUAL | GREATER_THAN_OR_EQUAL
    | AND | OR | NOT
    | IS | IS NOT | IN | NOT IN | LIKE | NOT LIKE
    | BETWEEN | NOT BETWEEN | EXISTS | NOT EXISTS
    ;

nonReservedKeyword
    : ACTION | ADD | ALL | ALWAYS | AND | AS | ASC | AUTO | AVRO
    | BACKUP | BETWEEN | BIGINT | BINARY | BOOL | BOOLEAN | BPCHAR | BY | BYTEDICT
    | CACHE | CASCADE | CASE | CHAR | CHARACTER | CHECK | COLLATE | COLUMN | COMPOUND
    | CONSTRAINT | CSV | CURRENT_DATE | CURRENT_TIME | CURRENT_TIMESTAMP | CURRENT_USER | CYCLE
    | DATA | DATE | DECIMAL | DEFAULT | DELETE | DELTA | DELTA32K | DESC | DISTKEY | DISTSTYLE
    | DOUBLE | DROP
    | ELSE | ENCODE | END | EVEN | EXISTS | EXTRACT
    | FALSE | FIRST | FLOAT | FLOAT4 | FLOAT8 | FOR | FOREIGN | FROM | FULL
    | GENERATED | GEOGRAPHY | GEOMETRY | GROUP
    | HAVING | HLLSKETCH
    | IDENTITY | IF | IN | INCREMENT | INT | INT2 | INT4 | INT8 | INTEGER | INTERLEAVED | IS
    | JSON
    | KEY
    | LAST | LIKE | LIMIT | LOCAL | LZO
    | MATCH | MAXVALUE | MINVALUE | MOSTLY16 | MOSTLY32 | MOSTLY8
    | NO | NOT | NCHAR | NULL | NULLS | NUMBER | NUMERIC | NVARCHAR
    | OF | ON | OR | ORDER | ORC
    | PARQUET | PARTIAL | PRECISION | PRIMARY
    | RAW | RCFILE | REAL | REFERENCES | RESTRICT | RUNLENGTH
    | SCALE | SELECT | SEQUENCEFILE | SESSION_USER | SET | SIMPLE | SMALLINT
    | SORTKEY | START | STRING | SUPER
    | TABLE | TEMP | TEMPORARY | TEXT | TEXT255 | TEXT32K | TEXTFILE | THEN | TIME
    | TIMESTAMP | TIMESTAMPTZ | TIMETZ | TO | TRUE | TYPE
    | UNIQUE | UPDATE | USER | USING
    | VARBINARY | VARBYTE | VARCHAR | VARYING
    | WHEN | WHERE | WITH | WITHOUT
    | YES
    | ZONE | ZSTD
    ;

// Lexer tokens
CREATE : 'CREATE' ;
LOCAL : 'LOCAL' ;
TEMPORARY : 'TEMPORARY' ;
TEMP : 'TEMP' ;
TABLE : 'TABLE' ;
IF : 'IF' ;
NOT : 'NOT' ;
EXISTS : 'EXISTS' ;
AS : 'AS' ;
NULL : 'NULL' ;
DEFAULT : 'DEFAULT' ;
IDENTITY : 'IDENTITY' ;
GENERATED : 'GENERATED' ;
ALWAYS : 'ALWAYS' ;
BY : 'BY' ;
PRIMARY : 'PRIMARY' ;
KEY : 'KEY' ;
UNIQUE : 'UNIQUE' ;
REFERENCES : 'REFERENCES' ;
MATCH : 'MATCH' ;
FULL : 'FULL' ;
PARTIAL : 'PARTIAL' ;
SIMPLE : 'SIMPLE' ;
ON : 'ON' ;
DELETE : 'DELETE' ;
UPDATE : 'UPDATE' ;
CASCADE : 'CASCADE' ;
SET : 'SET' ;
RESTRICT : 'RESTRICT' ;
NO : 'NO' ;
ACTION : 'ACTION' ;
CHECK : 'CHECK' ;
ENCODE : 'ENCODE' ;
DISTKEY : 'DISTKEY' ;
SORTKEY : 'SORTKEY' ;
COLLATE : 'COLLATE' ;
START : 'START' ;
WITH : 'WITH' ;
INCREMENT : 'INCREMENT' ;
MINVALUE : 'MINVALUE' ;
MAXVALUE : 'MAXVALUE' ;
CACHE : 'CACHE' ;
CYCLE : 'CYCLE' ;
BACKUP : 'BACKUP' ;
YES : 'YES' ;
DISTSTYLE : 'DISTSTYLE' ;
ALL : 'ALL' ;
EVEN : 'EVEN' ;
AUTO : 'AUTO' ;
COMPOUND : 'COMPOUND' ;
INTERLEAVED : 'INTERLEAVED' ;
CONSTRAINT : 'CONSTRAINT' ;
FOREIGN : 'FOREIGN' ;

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

// Encoding type keywords
RAW : 'RAW' ;
AZ64 : 'AZ64' ;
BYTEDICT : 'BYTEDICT' ;
DELTA : 'DELTA' ;
DELTA32K : 'DELTA32K' ;
LZO : 'LZO' ;
MOSTLY8 : 'MOSTLY8' ;
MOSTLY16 : 'MOSTLY16' ;
MOSTLY32 : 'MOSTLY32' ;
RUNLENGTH : 'RUNLENGTH' ;
TEXT255 : 'TEXT255' ;
TEXT32K : 'TEXT32K' ;
ZSTD : 'ZSTD' ;

// SQL keywords
SELECT : 'SELECT' ;
FROM : 'FROM' ;
WHERE : 'WHERE' ;
GROUP : 'GROUP' ;
HAVING : 'HAVING' ;
ORDER : 'ORDER' ;
LIMIT : 'LIMIT' ;
ASC : 'ASC' ;
DESC : 'DESC' ;
NULLS : 'NULLS' ;
FIRST : 'FIRST' ;
LAST : 'LAST' ;
CASE : 'CASE' ;
WHEN : 'WHEN' ;
THEN : 'THEN' ;
ELSE : 'ELSE' ;
END : 'END' ;
AND : 'AND' ;
OR : 'OR' ;
IS : 'IS' ;
IN : 'IN' ;
LIKE : 'LIKE' ;
BETWEEN : 'BETWEEN' ;
TRUE : 'TRUE' ;
FALSE : 'FALSE' ;
CURRENT_DATE : 'CURRENT_DATE' ;
CURRENT_TIME : 'CURRENT_TIME' ;
CURRENT_TIMESTAMP : 'CURRENT_TIMESTAMP' ;
CURRENT_USER : 'CURRENT_USER' ;
SESSION_USER : 'SESSION_USER' ;
USER : 'USER' ;

// Data format keywords (inherited from external table)
AVRO : 'AVRO' ;
JSON : 'JSON' ;
ORC : 'ORC' ;
PARQUET : 'PARQUET' ;
RCFILE : 'RCFILE' ;
SEQUENCEFILE : 'SEQUENCEFILE' ;
TEXTFILE : 'TEXTFILE' ;
CSV : 'CSV' ;
DATA : 'DATA' ;

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

// Delimiters
LEFT_PAREN : '(' ;
RIGHT_PAREN : ')' ;
COMMA : ',' ;
DOT : '.' ;

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