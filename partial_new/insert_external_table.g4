grammar InsertExternalTable;

// Parser rules for INSERT into external tables

insertExternalTableStatement
    : INSERT INTO externalTableReference selectStatement
    ;

externalTableReference
    : schemaName DOT tableName
    ;

schemaName
    : identifier
    ;

tableName
    : identifier
    ;

selectStatement
    : SELECT selectList FROM tableReference (whereClause)? (groupByClause)? (havingClause)? (orderByClause)?
    | SELECT selectList FROM tableReference joinClause+ (whereClause)? (groupByClause)? (havingClause)? (orderByClause)?
    ;

selectList
    : selectItem (COMMA selectItem)*
    | STAR
    ;

selectItem
    : expression (AS? columnAlias)?
    | tableName DOT STAR
    ;

expression
    : literal
    | columnReference
    | functionCall
    | expression operator expression
    | LPAREN expression RPAREN
    ;

columnReference
    : (tableName DOT)? columnName
    ;

columnName
    : identifier
    ;

columnAlias
    : identifier
    ;

functionCall
    : functionName LPAREN (expression (COMMA expression)*)? RPAREN
    ;

functionName
    : identifier
    ;

tableReference
    : tableName (AS? tableAlias)?
    | LPAREN selectStatement RPAREN AS? tableAlias
    ;

tableAlias
    : identifier
    ;

joinClause
    : joinType? JOIN tableReference ON joinCondition
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

literal
    : numberLiteral
    | stringLiteral
    | booleanLiteral
    | NULL
    ;

numberLiteral
    : INTEGER
    | DECIMAL
    ;

stringLiteral
    : STRING
    ;

booleanLiteral
    : TRUE
    | FALSE
    ;

operator
    : EQ | NEQ | LT | GT | LTE | GTE
    | PLUS | MINUS | STAR | DIV | MOD
    | AND | OR | NOT
    ;

identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    | nonReservedKeyword
    ;

nonReservedKeyword
    : SELECT | FROM | WHERE | GROUP | BY | HAVING | ORDER
    | ASC | DESC | NULLS | FIRST | LAST
    | JOIN | ON | INNER | LEFT | RIGHT | FULL | OUTER | CROSS
    | AS | AND | OR | NOT | NULL | TRUE | FALSE
    ;

// Lexer rules

// Keywords
INSERT : I N S E R T;
INTO : I N T O;
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
JOIN : J O I N;
ON : O N;
INNER : I N N E R;
LEFT : L E F T;
RIGHT : R I G H T;
FULL : F U L L;
OUTER : O U T E R;
CROSS : C R O S S;
AS : A S;
AND : A N D;
OR : O R;
NOT : N O T;
NULL : N U L L;
TRUE : T R U E;
FALSE : F A L S E;

// Operators
EQ : '=';
NEQ : '<>' | '!=';
LT : '<';
GT : '>';
LTE : '<=';
GTE : '>=';
PLUS : '+';
MINUS : '-';
STAR : '*';
DIV : '/';
MOD : '%';

// Delimiters
DOT : '.';
COMMA : ',';
LPAREN : '(';
RPAREN : ')';

// Identifiers and literals
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

QUOTED_IDENTIFIER
    : '"' (~["])+ '"'
    ;

INTEGER
    : [0-9]+
    ;

DECIMAL
    : [0-9]+ '.' [0-9]+
    ;

STRING
    : '\'' (~['])* '\''
    ;

// Whitespace and comments
WS
    : [ \t\r\n]+ -> skip
    ;

COMMENT
    : '--' ~[\r\n]* -> skip
    ;

MULTILINE_COMMENT
    : '/*' .*? '*/' -> skip
    ;

// Case-insensitive matching fragments
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