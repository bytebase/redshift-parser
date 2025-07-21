grammar select;

import RedshiftLexer, RedshiftParser;

// SELECT statement
selectStatement
    : withClause? selectClause fromClause? whereClause? connectByClause? 
      groupByClause? havingClause? qualifyClause? setOperationClause?
      orderByClause? limitClause? offsetClause? (FOR UPDATE lockingClause)?
    ;

// WITH clause (Common Table Expressions)
withClause
    : WITH RECURSIVE? commonTableExpression (COMMA commonTableExpression)*
    ;

commonTableExpression
    : identifier (LPAREN columnList RPAREN)? AS LPAREN selectStatement RPAREN
    ;

// SELECT clause
selectClause
    : SELECT setQuantifier? (topClause)? selectList
    ;

topClause
    : TOP NUMBER_LITERAL
    ;

setQuantifier
    : ALL
    | DISTINCT
    ;

selectList
    : selectListElement (COMMA selectListElement)*
    ;

selectListElement
    : ASTERISK (EXCLUDE LPAREN columnList RPAREN)?
    | expression (AS? columnAlias)?
    ;

// FROM clause
fromClause
    : FROM tableReference (COMMA tableReference)*
    ;

tableReference
    : tableOrViewName (AS? tableAlias)? (TABLESAMPLE samplingMethod)?
    | LPAREN selectStatement RPAREN (AS? tableAlias)?
    | tableReference joinType? JOIN tableReference (ON joinCondition | USING LPAREN columnList RPAREN)?
    | LPAREN tableReference RPAREN
    ;

joinType
    : INNER
    | LEFT OUTER?
    | RIGHT OUTER?
    | FULL OUTER?
    | CROSS
    ;

joinCondition
    : expression
    ;

samplingMethod
    : BERNOULLI LPAREN percentage RPAREN
    | SYSTEM LPAREN percentage RPAREN
    ;

// WHERE clause
whereClause
    : WHERE condition
    ;

// CONNECT BY clause (hierarchical queries)
connectByClause
    : (START WITH expression)? CONNECT BY NOCYCLE? expression
    ;

// GROUP BY clause
groupByClause
    : GROUP BY (ALL | groupingElement (COMMA groupingElement)*)
    ;

groupingElement
    : expression
    | LPAREN RPAREN
    | LPAREN expression (COMMA expression)* RPAREN
    | ROLLUP LPAREN expression (COMMA expression)* RPAREN
    | CUBE LPAREN expression (COMMA expression)* RPAREN
    | GROUPING SETS LPAREN groupingElement (COMMA groupingElement)* RPAREN
    ;

// HAVING clause
havingClause
    : HAVING condition
    ;

// QUALIFY clause
qualifyClause
    : QUALIFY condition
    ;

// Set operations
setOperationClause
    : (UNION ALL? | INTERSECT | EXCEPT | MINUS) selectStatement
    ;

// ORDER BY clause
orderByClause
    : ORDER BY orderByElement (COMMA orderByElement)*
    ;

orderByElement
    : expression (ASC | DESC)? (NULLS (FIRST | LAST))?
    ;

// LIMIT clause
limitClause
    : LIMIT (NUMBER_LITERAL | ALL)
    ;

// OFFSET clause
offsetClause
    : OFFSET NUMBER_LITERAL (ROW | ROWS)?
    ;

// FOR UPDATE clause
lockingClause
    : (OF tableOrViewName (COMMA tableOrViewName)*)?
      (NOWAIT | SKIP LOCKED)?
    ;

// Basic elements
expression
    : literal
    | columnReference
    | functionCall
    | caseExpression
    | expression operator expression
    | LPAREN expression RPAREN
    | expression BETWEEN expression AND expression
    | expression NOT? IN LPAREN (expressionList | selectStatement) RPAREN
    | expression NOT? LIKE expression (ESCAPE expression)?
    | expression IS NOT? NULL
    | NOT expression
    | EXISTS LPAREN selectStatement RPAREN
    | LPAREN selectStatement RPAREN
    | aggregateFunction
    | windowFunction
    ;

columnReference
    : (tableAlias DOT)? identifier
    ;

functionCall
    : identifier LPAREN (DISTINCT? expressionList)? RPAREN
    ;

caseExpression
    : CASE expression? (WHEN expression THEN expression)+ (ELSE expression)? END
    ;

aggregateFunction
    : (COUNT | SUM | AVG | MIN | MAX | STDDEV | VARIANCE) LPAREN (DISTINCT? expression | ASTERISK) RPAREN
    | LISTAGG LPAREN DISTINCT? expression (COMMA STRING_LITERAL)? RPAREN (WITHIN GROUP LPAREN orderByClause RPAREN)?
    ;

windowFunction
    : functionCall OVER LPAREN partitionByClause? orderByClause? windowFrame? RPAREN
    ;

partitionByClause
    : PARTITION BY expression (COMMA expression)*
    ;

windowFrame
    : (ROWS | RANGE) (BETWEEN frameBound AND frameBound | frameBound)
    ;

frameBound
    : UNBOUNDED PRECEDING
    | NUMBER_LITERAL PRECEDING
    | CURRENT ROW
    | NUMBER_LITERAL FOLLOWING
    | UNBOUNDED FOLLOWING
    ;

condition
    : expression
    ;

expressionList
    : expression (COMMA expression)*
    ;

columnList
    : identifier (COMMA identifier)*
    ;

tableOrViewName
    : (schemaName DOT)? identifier
    ;

schemaName
    : identifier
    ;

tableAlias
    : identifier
    ;

columnAlias
    : identifier | STRING_LITERAL
    ;

identifier
    : IDENTIFIER
    | nonReservedWord
    ;

literal
    : NUMBER_LITERAL
    | STRING_LITERAL
    | BOOLEAN_LITERAL
    | NULL
    ;

operator
    : PLUS | MINUS | ASTERISK | DIVIDE | MODULO
    | EQUAL | NOT_EQUAL | LESS_THAN | GREATER_THAN 
    | LESS_THAN_EQUAL | GREATER_THAN_EQUAL
    | AND | OR
    | CONCAT
    ;

percentage
    : NUMBER_LITERAL
    ;

nonReservedWord
    : // Add non-reserved keywords that can be used as identifiers
    ;

// Lexer rules would be imported from RedshiftLexer.g4