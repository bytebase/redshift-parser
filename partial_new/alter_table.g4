// ALTER TABLE Grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_TABLE.html

alterTableStatement
    : ALTER TABLE (IF EXISTS)? tableName alterTableAction (COMMA alterTableAction)*
    ;

alterTableAction
    : addColumnAction
    | dropColumnAction
    | alterColumnAction
    | renameColumnAction
    | renameTableAction
    | addConstraintAction
    | dropConstraintAction
    | alterDistkeyAction
    | alterDiststyleAction
    | alterSortkeyAction
    | alterEncodeAction
    | ownerToAction
    | rowLevelSecurityAction
    | setTableAttributesAction
    | appendFromAction
    | setLocationAction
    | setFileFormatAction
    | addPartitionAction
    | dropPartitionAction
    ;

// Column operations
addColumnAction
    : ADD COLUMN? columnDefinition (columnConstraint)*
    ;

dropColumnAction
    : DROP COLUMN? columnName (CASCADE | RESTRICT)?
    ;

alterColumnAction
    : ALTER COLUMN? columnName alterColumnOption
    ;

alterColumnOption
    : TYPE dataType (USING expression)?
    | SET DEFAULT expression
    | DROP DEFAULT
    | (SET | DROP) NOT NULL
    | SET ENCODE encoding
    | SET (MASKED | NOT MASKED)
    ;

renameColumnAction
    : RENAME COLUMN columnName TO newColumnName
    ;

renameTableAction
    : RENAME TO newTableName
    ;

// Constraint operations
addConstraintAction
    : ADD constraintDefinition
    ;

dropConstraintAction
    : DROP CONSTRAINT constraintName (CASCADE | RESTRICT)?
    ;

constraintDefinition
    : (CONSTRAINT constraintName)?
      ( uniqueConstraint
      | primaryKeyConstraint
      | foreignKeyConstraint
      | checkConstraint
      )
    ;

uniqueConstraint
    : UNIQUE LEFT_PAREN columnList RIGHT_PAREN
    ;

primaryKeyConstraint
    : PRIMARY KEY LEFT_PAREN columnList RIGHT_PAREN
    ;

foreignKeyConstraint
    : FOREIGN KEY LEFT_PAREN columnList RIGHT_PAREN
      REFERENCES referencedTable (LEFT_PAREN columnList RIGHT_PAREN)?
      (matchType)? (referentialAction)*
    ;

checkConstraint
    : CHECK LEFT_PAREN expression RIGHT_PAREN
    ;

matchType
    : MATCH (FULL | PARTIAL | SIMPLE)
    ;

referentialAction
    : ON (DELETE | UPDATE) (CASCADE | SET NULL | NO ACTION | RESTRICT | SET DEFAULT)
    ;

// Distribution and sort key operations
alterDistkeyAction
    : ALTER (DISTKEY columnName | DISTSTYLE KEY DISTKEY columnName)
    ;

alterDiststyleAction
    : ALTER DISTSTYLE (ALL | EVEN | KEY | AUTO | NONE)
    ;

alterSortkeyAction
    : ALTER sortKeyType? SORTKEY (LEFT_PAREN columnList RIGHT_PAREN | AUTO | NONE)
    ;

sortKeyType
    : COMPOUND
    | INTERLEAVED
    ;

// Encoding operations
alterEncodeAction
    : ALTER ENCODE AUTO (PRESERVE (YES | NO))?
    | ALTER COLUMN columnName ENCODE encoding
    ;

// Owner operations
ownerToAction
    : OWNER TO userName
    ;

// Row level security operations
rowLevelSecurityAction
    : ROW LEVEL SECURITY (ON | OFF)
    | CONJUNCTION TYPE (AND | OR)
    | MASKING FOR DATASHARES (ON | OFF)
    ;

// External table operations
setTableAttributesAction
    : SET TABLE PROPERTIES LEFT_PAREN propertyList RIGHT_PAREN
    ;

appendFromAction
    : APPEND FROM tableName (LEFT_PAREN columnList RIGHT_PAREN)?
      (IAM_ROLE iamRole)?
      (REGION awsRegion)?
      (FORMAT AS dataFormat)?
      (PARTITION LEFT_PAREN partitionSpec RIGHT_PAREN)?
    ;

setLocationAction
    : SET LOCATION locationPath
    ;

setFileFormatAction
    : SET FILE FORMAT dataFormat
    ;

addPartitionAction
    : ADD (IF NOT EXISTS)? PARTITION LEFT_PAREN partitionSpec RIGHT_PAREN
      LOCATION locationPath
    ;

dropPartitionAction
    : DROP PARTITION LEFT_PAREN partitionSpec RIGHT_PAREN
    ;

// Supporting rules
columnDefinition
    : columnName dataType (columnConstraint)*
    ;

columnConstraint
    : NOT NULL
    | NULL
    | UNIQUE
    | PRIMARY KEY
    | REFERENCES referencedTable (LEFT_PAREN columnName RIGHT_PAREN)?
    | DEFAULT expression
    | ENCODE encoding
    | DISTKEY
    | SORTKEY
    | MASKED
    ;

encoding
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

dataFormat
    : AVRO (STRING_LITERAL)?
    | JSON (STRING_LITERAL | AUTO)?
    | ORC
    | PARQUET
    | RCFILE
    | SEQUENCEFILE
    | TEXTFILE
    | CSV (DELIMITER STRING_LITERAL)?
    ;

partitionSpec
    : partitionColumn EQUALS partitionValue (COMMA partitionColumn EQUALS partitionValue)*
    ;

propertyList
    : property EQUALS propertyValue (COMMA property EQUALS propertyValue)*
    ;

// Identifiers and literals
tableName : identifier ;
columnName : identifier ;
newColumnName : identifier ;
newTableName : identifier ;
constraintName : identifier ;
referencedTable : identifier ;
userName : identifier ;
iamRole : STRING_LITERAL ;
awsRegion : STRING_LITERAL ;
locationPath : STRING_LITERAL ;
partitionColumn : identifier ;
partitionValue : literal ;
property : identifier ;
propertyValue : literal ;

columnList
    : columnName (COMMA columnName)*
    ;

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
    | NCHAR (LEFT_PAREN NUMBER RIGHT_PAREN)?
    | BPCHAR (LEFT_PAREN NUMBER RIGHT_PAREN)?
    | VARCHAR (LEFT_PAREN NUMBER RIGHT_PAREN)?
    | CHARACTER VARYING (LEFT_PAREN NUMBER RIGHT_PAREN)?
    | NVARCHAR (LEFT_PAREN NUMBER RIGHT_PAREN)?
    | TEXT | STRING
    | VARBYTE (LEFT_PAREN NUMBER RIGHT_PAREN)?
    | VARBINARY (LEFT_PAREN NUMBER RIGHT_PAREN)?
    | BINARY VARYING (LEFT_PAREN NUMBER RIGHT_PAREN)?
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
    ;

expression
    : literal
    | columnName
    | functionCall
    | expression operator expression
    | LEFT_PAREN expression RIGHT_PAREN
    ;

functionCall
    : functionName LEFT_PAREN (expression (COMMA expression)*)? RIGHT_PAREN
    ;

functionName : identifier ;

operator
    : PLUS | MINUS | STAR | SLASH | PERCENT
    | EQUALS | NOT_EQUALS | LESS_THAN | GREATER_THAN
    | LESS_THAN_OR_EQUAL | GREATER_THAN_OR_EQUAL
    | AND | OR | NOT
    ;

nonReservedKeyword
    : ACTION | ADD | ALL | ALTER | AND | AS | AUTO | AVRO
    | BIGINT | BINARY | BOOL | BOOLEAN | BPCHAR | BYTEDICT
    | CASCADE | CHAR | CHARACTER | CHECK | COLUMN | COMPOUND
    | CONJUNCTION | CONSTRAINT | CSV
    | DATA | DATASHARES | DATE | DECIMAL | DEFAULT | DELETE
    | DELTA | DELTA32K | DELIMITER | DISTKEY | DISTSTYLE
    | DOUBLE | DROP
    | ELSE | ENCODE | ENCODING | EVEN | EXISTS
    | FALSE | FILE | FLOAT | FLOAT4 | FLOAT8 | FOR | FOREIGN
    | FORMAT | FROM | FULL
    | GEOGRAPHY | GEOMETRY
    | HLLSKETCH
    | IAM_ROLE | IF | INT | INT2 | INT4 | INT8 | INTEGER
    | INTERLEAVED
    | JSON
    | KEY
    | LEVEL | LOCATION | LZO
    | MASKED | MASKING | MATCH | MOSTLY16 | MOSTLY32 | MOSTLY8
    | NO | NOT | NCHAR | NULL | NUMBER | NUMERIC | NVARCHAR
    | OFF | ON | OR | ORC | OWNER
    | PARQUET | PARTIAL | PARTITION | PRECISION | PRESERVE
    | PRIMARY | PROPERTIES
    | RAW | RCFILE | REAL | REFERENCES | REGION | RENAME
    | RESTRICT | ROW | RUNLENGTH
    | SECURITY | SEQUENCEFILE | SET | SIMPLE | SMALLINT
    | SORTKEY | STRING | SUPER
    | TABLE | TEXT | TEXT255 | TEXT32K | TEXTFILE | TIME
    | TIMESTAMP | TIMESTAMPTZ | TIMETZ | TO | TRUE | TYPE
    | UNIQUE | UPDATE | USING
    | VARBINARY | VARBYTE | VARCHAR | VARYING
    | WITHOUT | WITH
    | ZONE | ZSTD
    ;

// Lexer tokens
ALTER : 'ALTER' ;
TABLE : 'TABLE' ;
IF : 'IF' ;
EXISTS : 'EXISTS' ;
ADD : 'ADD' ;
DROP : 'DROP' ;
COLUMN : 'COLUMN' ;
RENAME : 'RENAME' ;
TO : 'TO' ;
CONSTRAINT : 'CONSTRAINT' ;
CASCADE : 'CASCADE' ;
RESTRICT : 'RESTRICT' ;
TYPE : 'TYPE' ;
SET : 'SET' ;
DEFAULT : 'DEFAULT' ;
NOT : 'NOT' ;
NULL : 'NULL' ;
ENCODE : 'ENCODE' ;
MASKED : 'MASKED' ;
UNIQUE : 'UNIQUE' ;
PRIMARY : 'PRIMARY' ;
KEY : 'KEY' ;
FOREIGN : 'FOREIGN' ;
REFERENCES : 'REFERENCES' ;
CHECK : 'CHECK' ;
MATCH : 'MATCH' ;
FULL : 'FULL' ;
PARTIAL : 'PARTIAL' ;
SIMPLE : 'SIMPLE' ;
ON : 'ON' ;
DELETE : 'DELETE' ;
UPDATE : 'UPDATE' ;
NO : 'NO' ;
ACTION : 'ACTION' ;
DISTKEY : 'DISTKEY' ;
DISTSTYLE : 'DISTSTYLE' ;
ALL : 'ALL' ;
EVEN : 'EVEN' ;
AUTO : 'AUTO' ;
NONE : 'NONE' ;
SORTKEY : 'SORTKEY' ;
COMPOUND : 'COMPOUND' ;
INTERLEAVED : 'INTERLEAVED' ;
PRESERVE : 'PRESERVE' ;
YES : 'YES' ;
OWNER : 'OWNER' ;
ROW : 'ROW' ;
LEVEL : 'LEVEL' ;
SECURITY : 'SECURITY' ;
OFF : 'OFF' ;
CONJUNCTION : 'CONJUNCTION' ;
AND : 'AND' ;
OR : 'OR' ;
MASKING : 'MASKING' ;
FOR : 'FOR' ;
DATASHARES : 'DATASHARES' ;
PROPERTIES : 'PROPERTIES' ;
APPEND : 'APPEND' ;
FROM : 'FROM' ;
IAM_ROLE : 'IAM_ROLE' ;
REGION : 'REGION' ;
FORMAT : 'FORMAT' ;
AS : 'AS' ;
PARTITION : 'PARTITION' ;
LOCATION : 'LOCATION' ;
FILE : 'FILE' ;
USING : 'USING' ;

// Encoding types
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

// Data formats
AVRO : 'AVRO' ;
JSON : 'JSON' ;
ORC : 'ORC' ;
PARQUET : 'PARQUET' ;
RCFILE : 'RCFILE' ;
SEQUENCEFILE : 'SEQUENCEFILE' ;
TEXTFILE : 'TEXTFILE' ;
CSV : 'CSV' ;
DELIMITER : 'DELIMITER' ;

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
WITH : 'WITH' ;
TIME : 'TIME' ;
ZONE : 'ZONE' ;
TIMESTAMPTZ : 'TIMESTAMPTZ' ;
TIMETZ : 'TIMETZ' ;
GEOMETRY : 'GEOMETRY' ;
GEOGRAPHY : 'GEOGRAPHY' ;
HLLSKETCH : 'HLLSKETCH' ;
SUPER : 'SUPER' ;

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

// Literals
TRUE : 'TRUE' ;
FALSE : 'FALSE' ;
ELSE : 'ELSE' ;
DATA : 'DATA' ;

// Delimiters
LEFT_PAREN : '(' ;
RIGHT_PAREN : ')' ;
COMMA : ',' ;

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