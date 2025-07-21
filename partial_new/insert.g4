// INSERT statement grammar for Amazon Redshift
// Based on: https://docs.aws.amazon.com/redshift/latest/dg/r_INSERT.html

grammar Insert;

// Main INSERT statement rule
insertStatement
    : INSERT INTO tableName columnList? (
        valuesClause
        | selectStatement
        | DEFAULT VALUES
      )
    ;

// Table name with optional schema
tableName
    : (schemaName '.')? identifier
    ;

// Schema name
schemaName
    : identifier
    ;

// Column list in parentheses
columnList
    : '(' columnName (',' columnName)* ')'
    ;

// Column name
columnName
    : identifier
    ;

// VALUES clause with one or more value lists
valuesClause
    : VALUES valueList (',' valueList)*
    ;

// List of values in parentheses
valueList
    : '(' value (',' value)* ')'
    ;

// Individual value types
value
    : literal
    | DEFAULT
    | NULL
    ;

// Literal values
literal
    : numericLiteral
    | stringLiteral
    | booleanLiteral
    | dateLiteral
    | timestampLiteral
    ;

// Numeric literal
numericLiteral
    : DECIMAL_VALUE
    | INTEGER_VALUE
    ;

// String literal
stringLiteral
    : STRING_LITERAL
    ;

// Boolean literal
booleanLiteral
    : TRUE
    | FALSE
    ;

// Date literal
dateLiteral
    : DATE STRING_LITERAL
    ;

// Timestamp literal
timestampLiteral
    : TIMESTAMP STRING_LITERAL
    ;

// Basic SELECT statement (simplified for INSERT context)
selectStatement
    : SELECT selectList FROM tableReference whereClause? groupByClause? havingClause? orderByClause? limitClause?
    ;

// SELECT list
selectList
    : selectItem (',' selectItem)*
    | '*'
    ;

// SELECT item
selectItem
    : expression (AS? columnAlias)?
    ;

// Table reference
tableReference
    : tableName (AS? tableAlias)?
    ;

// Column/table alias
columnAlias
    : identifier
    ;

tableAlias
    : identifier
    ;

// WHERE clause
whereClause
    : WHERE expression
    ;

// GROUP BY clause
groupByClause
    : GROUP BY expression (',' expression)*
    ;

// HAVING clause
havingClause
    : HAVING expression
    ;

// ORDER BY clause
orderByClause
    : ORDER BY orderByItem (',' orderByItem)*
    ;

// ORDER BY item
orderByItem
    : expression (ASC | DESC)? (NULLS (FIRST | LAST))?
    ;

// LIMIT clause
limitClause
    : LIMIT INTEGER_VALUE
    ;

// Expression (simplified)
expression
    : columnName
    | literal
    | expression operator expression
    | '(' expression ')'
    | functionCall
    ;

// Function call
functionCall
    : functionName '(' (expression (',' expression)*)? ')'
    ;

// Function name
functionName
    : identifier
    ;

// Operators
operator
    : '=' | '!=' | '<>' | '<' | '>' | '<=' | '>='
    | '+' | '-' | '*' | '/'
    | AND | OR | NOT
    ;

// Identifier (table names, column names, etc.)
identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    | nonReservedWord
    ;

// Non-reserved words that can be used as identifiers
nonReservedWord
    : DATE
    | TIMESTAMP
    | FIRST
    | LAST
    ;

// Keywords
INSERT : I N S E R T;
INTO : I N T O;
VALUES : V A L U E S;
DEFAULT : D E F A U L T;
SELECT : S E L E C T;
FROM : F R O M;
WHERE : W H E R E;
GROUP : G R O U P;
BY : B Y;
HAVING : H A V I N G;
ORDER : O R D E R;
ASC : A S C;
DESC : D E S C;
NULLS : N U L L S;
FIRST : F I R S T;
LAST : L A S T;
LIMIT : L I M I T;
AS : A S;
AND : A N D;
OR : O R;
NOT : N O T;
NULL : N U L L;
TRUE : T R U E;
FALSE : F A L S E;
DATE : D A T E;
TIMESTAMP : T I M E S T A M P;

// Identifiers
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

QUOTED_IDENTIFIER
    : '"' (~["])+ '"'
    ;

// Literals
INTEGER_VALUE
    : [0-9]+
    ;

DECIMAL_VALUE
    : [0-9]+ '.' [0-9]+
    ;

STRING_LITERAL
    : '\'' (~['])* '\''
    ;

// Comments and whitespace
COMMENT
    : '--' ~[\r\n]* -> skip
    ;

BLOCK_COMMENT
    : '/*' .*? '*/' -> skip
    ;

WS
    : [ \t\r\n]+ -> skip
    ;

// Case-insensitive matching
fragment A : [aA];
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment H : [hH];
fragment I : [iI];
fragment J : [jJ];
fragment K : [kK];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment Q : [qQ];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment V : [vV];
fragment W : [wW];
fragment X : [xX];
fragment Y : [yY];
fragment Z : [zZ];