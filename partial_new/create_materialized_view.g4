// CREATE MATERIALIZED VIEW grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/materialized-view-create-sql-command.html

createMaterializedViewStatement
    : CREATE MATERIALIZED VIEW qualifiedName
      (backupClause)?
      (tableAttributes)*
      (autoRefreshClause)?
      AS selectStatement
    ;

backupClause
    : BACKUP (YES | NO)
    ;

tableAttributes
    : distStyleClause
    | distKeyClause
    | sortKeyClause
    ;

distStyleClause
    : DISTSTYLE (ALL | EVEN | KEY)
    ;

distKeyClause
    : DISTKEY LEFT_PAREN columnName RIGHT_PAREN
    ;

sortKeyClause
    : (COMPOUND | INTERLEAVED)? SORTKEY LEFT_PAREN columnList RIGHT_PAREN
    ;

autoRefreshClause
    : AUTO REFRESH (YES | NO)
    ;

// SELECT statement - simplified for materialized view context
// In a full implementation, this would reference the main parser's selectStatement rule
selectStatement
    : SELECT (ALL | DISTINCT)?
      selectList
      (fromClause)?
      (whereClause)?
      (groupByClause)?
      (havingClause)?
      (unionClause)*
    ;

selectList
    : selectItem (COMMA selectItem)*
    | ASTERISK
    ;

selectItem
    : expression (AS? columnAlias)?
    ;

fromClause
    : FROM tableRef (joinClause)*
    ;

tableRef
    : qualifiedName (AS? tableAlias)?
    | LEFT_PAREN selectStatement RIGHT_PAREN (AS? tableAlias)?
    ;

joinClause
    : (INNER | LEFT | RIGHT | FULL)? (OUTER)? JOIN tableRef joinCondition
    | CROSS JOIN tableRef
    ;

joinCondition
    : ON expression
    | USING LEFT_PAREN columnList RIGHT_PAREN
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

unionClause
    : UNION (ALL | DISTINCT)? selectStatement
    ;

expression
    : identifier
    | STRING_LITERAL
    | INTEGER_LITERAL
    | DECIMAL_LITERAL
    | qualifiedName
    | expression OPERATOR expression
    | LEFT_PAREN expression RIGHT_PAREN
    | functionCall
    | caseExpression
    | expression IS (NOT)? NULL
    | expression (NOT)? IN LEFT_PAREN (expression (COMMA expression)* | selectStatement) RIGHT_PAREN
    | expression (NOT)? BETWEEN expression AND expression
    | expression (NOT)? LIKE expression
    | (NOT)? EXISTS LEFT_PAREN selectStatement RIGHT_PAREN
    ;

functionCall
    : identifier LEFT_PAREN (DISTINCT? expression (COMMA expression)* | ASTERISK)? RIGHT_PAREN
    | aggregateFunction
    ;

aggregateFunction
    : (COUNT | SUM | AVG | MIN | MAX) LEFT_PAREN (DISTINCT? expression | ASTERISK) RIGHT_PAREN
    ;

caseExpression
    : CASE (expression)? (whenClause)+ (elseClause)? END
    ;

whenClause
    : WHEN expression THEN expression
    ;

elseClause
    : ELSE expression
    ;

// Common elements
qualifiedName
    : (schemaName DOT)? identifier
    | (databaseName DOT schemaName DOT)? identifier
    | (catalogName DOT databaseName DOT schemaName DOT)? identifier
    ;

schemaName
    : identifier
    ;

databaseName
    : identifier
    ;

catalogName
    : identifier
    ;

columnName
    : identifier
    ;

columnList
    : columnName (COMMA columnName)*
    ;

columnAlias
    : identifier
    | STRING_LITERAL
    ;

tableAlias
    : identifier
    ;

identifier
    : IDENTIFIER
    | nonReservedWord
    | quotedIdentifier
    ;

quotedIdentifier
    : DOUBLE_QUOTE_ID
    ;

nonReservedWord
    : // This would include all non-reserved keywords from keywords.go
      BACKUP | AUTO | REFRESH | DISTKEY | DISTSTYLE | SORTKEY | COMPOUND | INTERLEAVED
    | ALL | EVEN | KEY | YES | NO | DISTINCT | INNER | LEFT | RIGHT | FULL | OUTER
    | CROSS | JOIN | ON | USING | GROUP | HAVING | UNION | CASE | WHEN | THEN | ELSE | END
    | COUNT | SUM | AVG | MIN | MAX | IS | NULL | NOT | IN | BETWEEN | AND | OR | LIKE | EXISTS
    ;

// Lexer rules that would be defined in RedshiftLexer.g4
CREATE : C R E A T E;
MATERIALIZED : M A T E R I A L I Z E D;
VIEW : V I E W;
BACKUP : B A C K U P;
YES : Y E S;
NO : N O;
AUTO : A U T O;
REFRESH : R E F R E S H;
DISTSTYLE : D I S T S T Y L E;
ALL : A L L;
EVEN : E V E N;
KEY : K E Y;
DISTKEY : D I S T K E Y;
SORTKEY : S O R T K E Y;
COMPOUND : C O M P O U N D;
INTERLEAVED : I N T E R L E A V E D;
AS : A S;
SELECT : S E L E C T;
DISTINCT : D I S T I N C T;
FROM : F R O M;
WHERE : W H E R E;
GROUP : G R O U P;
BY : B Y;
HAVING : H A V I N G;
UNION : U N I O N;
INNER : I N N E R;
LEFT : L E F T;
RIGHT : R I G H T;
FULL : F U L L;
OUTER : O U T E R;
CROSS : C R O S S;
JOIN : J O I N;
ON : O N;
USING : U S I N G;
CASE : C A S E;
WHEN : W H E N;
THEN : T H E N;
ELSE : E L S E;
END : E N D;
COUNT : C O U N T;
SUM : S U M;
AVG : A V G;
MIN : M I N;
MAX : M A X;
IS : I S;
NULL : N U L L;
NOT : N O T;
IN : I N;
BETWEEN : B E T W E E N;
AND : A N D;
OR : O R;
LIKE : L I K E;
EXISTS : E X I S T S;

DOT : '.';
COMMA : ',';
LEFT_PAREN : '(';
RIGHT_PAREN : ')';
ASTERISK : '*';

// Operators
OPERATOR: '=' | '<>' | '!=' | '<' | '<=' | '>' | '>=' | '+' | '-' | '*' | '/' | '%';

IDENTIFIER : [a-zA-Z_][a-zA-Z0-9_]*;
DOUBLE_QUOTE_ID : '"' (~["])+ '"';
INTEGER_LITERAL : [0-9]+;
DECIMAL_LITERAL : [0-9]+ '.' [0-9]*;
STRING_LITERAL : '\'' (~['\r\n] | '\'\'')* '\'';

// Case-insensitive letter fragments
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