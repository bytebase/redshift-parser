// DECLARE command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_DECLARE.html
// Reference: https://www.postgresql.org/docs/current/sql-declare.html

declareStmt
    : DECLARE cursorName cursorOptions* CURSOR holdOption? FOR query
    ;

cursorName
    : identifier
    ;

cursorOptions
    : BINARY
    | ASENSITIVE
    | INSENSITIVE
    | scrollOption
    ;

scrollOption
    : SCROLL
    | NO SCROLL
    ;

holdOption
    : WITH HOLD
    | WITHOUT HOLD
    ;

query
    : selectStmt
    | withStmt
    | valuesStmt
    | tableStmt
    ;

selectStmt
    : SELECT selectList FROM tableExpression whereClause? groupByClause? havingClause? orderByClause? limitClause?
    | SELECT selectList whereClause? groupByClause? havingClause? orderByClause? limitClause?
    ;

withStmt
    : WITH cteList selectStmt
    ;

valuesStmt
    : VALUES valuesList
    ;

tableStmt
    : TABLE tableName
    ;

selectList
    : ASTERISK
    | selectItem (COMMA selectItem)*
    ;

selectItem
    : expression (AS? identifier)?
    | expression
    ;

tableExpression
    : tableName (AS? identifier)?
    | LPAREN query RPAREN (AS? identifier)?
    ;

whereClause
    : WHERE expression
    ;

groupByClause
    : GROUP BY expression (COMMA expression)*
    ;

havingClause
    : HAVING expression
    ;

orderByClause
    : ORDER BY orderByItem (COMMA orderByItem)*
    ;

orderByItem
    : expression (ASC | DESC)? (NULLS (FIRST | LAST))?
    ;

limitClause
    : LIMIT expression (OFFSET expression)?
    ;

cteList
    : cteItem (COMMA cteItem)*
    ;

cteItem
    : identifier AS LPAREN query RPAREN
    ;

valuesList
    : LPAREN expression (COMMA expression)* RPAREN (COMMA LPAREN expression (COMMA expression)* RPAREN)*
    ;

expression
    : primaryExpression
    | expression binaryOperator expression
    | unaryOperator expression
    | expression IS (NOT)? NULL
    | expression (NOT)? IN LPAREN (expression (COMMA expression)* | query) RPAREN
    | expression (NOT)? BETWEEN expression AND expression
    | expression (NOT)? LIKE expression
    | CASE whenClause+ (ELSE expression)? END
    | functionCall
    | LPAREN query RPAREN
    | LPAREN expression RPAREN
    ;

primaryExpression
    : literal
    | identifier
    | parameter
    | columnReference
    ;

functionCall
    : functionName LPAREN (DISTINCT | ALL)? (expression (COMMA expression)*)? RPAREN
    ;

whenClause
    : WHEN expression THEN expression
    ;

binaryOperator
    : PLUS | MINUS | ASTERISK | SLASH | PERCENT | PIPE_PIPE
    | EQ | NE | LT | LE | GT | GE
    | AND | OR
    ;

unaryOperator
    : NOT | PLUS | MINUS
    ;

literal
    : stringLiteral
    | numericLiteral
    | booleanLiteral
    | NULL
    ;

stringLiteral
    : STRING_LITERAL
    ;

numericLiteral
    : INTEGER_LITERAL
    | DECIMAL_LITERAL
    ;

booleanLiteral
    : TRUE
    | FALSE
    ;

identifier
    : IDENTIFIER
    | quotedIdentifier
    | unreservedKeyword
    ;

quotedIdentifier
    : DOUBLE_QUOTED_IDENTIFIER
    ;

tableName
    : identifier (DOT identifier)?
    ;

columnReference
    : identifier (DOT identifier)*
    ;

functionName
    : identifier
    ;

parameter
    : PARAMETER
    ;

unreservedKeyword
    : ALL
    | ASC
    | DESC
    | FIRST
    | LAST
    | NULLS
    | WORK
    | TRANSACTION
    | LEVEL
    | WRITE
    | ONLY
    | COMMITTED
    | UNCOMMITTED
    | REPEATABLE
    | SERIALIZABLE
    | DISTINCT
    | TABLE
    | VALUES
    | CASE
    | WHEN
    | THEN
    | ELSE
    | END
    | TRUE
    | FALSE
    ;

// Keywords (these would typically be defined in the lexer)
DECLARE: 'DECLARE';
CURSOR: 'CURSOR';
FOR: 'FOR';
WITH: 'WITH';
WITHOUT: 'WITHOUT';
HOLD: 'HOLD';
BINARY: 'BINARY';
ASENSITIVE: 'ASENSITIVE';
INSENSITIVE: 'INSENSITIVE';
SCROLL: 'SCROLL';
NO: 'NO';
SELECT: 'SELECT';
FROM: 'FROM';
WHERE: 'WHERE';
GROUP: 'GROUP';
BY: 'BY';
HAVING: 'HAVING';
ORDER: 'ORDER';
LIMIT: 'LIMIT';
OFFSET: 'OFFSET';
AS: 'AS';
TABLE: 'TABLE';
VALUES: 'VALUES';
ALL: 'ALL';
DISTINCT: 'DISTINCT';
ASC: 'ASC';
DESC: 'DESC';
NULLS: 'NULLS';
FIRST: 'FIRST';
LAST: 'LAST';
IS: 'IS';
NULL: 'NULL';
NOT: 'NOT';
IN: 'IN';
BETWEEN: 'BETWEEN';
AND: 'AND';
OR: 'OR';
LIKE: 'LIKE';
CASE: 'CASE';
WHEN: 'WHEN';
THEN: 'THEN';
ELSE: 'ELSE';
END: 'END';
TRUE: 'TRUE';
FALSE: 'FALSE';
WORK: 'WORK';
TRANSACTION: 'TRANSACTION';
LEVEL: 'LEVEL';
WRITE: 'WRITE';
ONLY: 'ONLY';
COMMITTED: 'COMMITTED';
UNCOMMITTED: 'UNCOMMITTED';
REPEATABLE: 'REPEATABLE';
SERIALIZABLE: 'SERIALIZABLE';

// Operators
EQ: '=';
NE: '<>' | '!=';
LT: '<';
LE: '<=';
GT: '>';
GE: '>=';
PLUS: '+';
MINUS: '-';
ASTERISK: '*';
SLASH: '/';
PERCENT: '%';
PIPE_PIPE: '||';

// Punctuation
COMMA: ',';
DOT: '.';
LPAREN: '(';
RPAREN: ')';
SEMICOLON: ';';

// Tokens
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_$]*;
DOUBLE_QUOTED_IDENTIFIER: '"' (~["\r\n] | '""')+ '"';
STRING_LITERAL: '\'' (~['\r\n] | '\'\'')* '\'';
INTEGER_LITERAL: [0-9]+;
DECIMAL_LITERAL: [0-9]+ '.' [0-9]+;
PARAMETER: '$' [0-9]+;