// CREATE MASKING POLICY grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_MASKING_POLICY.html

grammar CreateMaskingPolicy;

// Parser Rules
createMaskingPolicyStatement
    : CREATE MASKING POLICY (IF NOT EXISTS)? policyName=identifier
      WITH LPAREN inputColumnList RPAREN
      USING LPAREN maskingExpression RPAREN SEMI?
    ;

inputColumnList
    : inputColumn (COMMA inputColumn)*
    ;

inputColumn
    : columnName=identifier dataType
    ;

maskingExpression
    : expression
    ;

expression
    : primaryExpression                                         # primaryExpr
    | functionCall                                             # functionExpr
    | expression op=(STAR | DIV | MOD) expression             # binaryArithmetic
    | expression op=(PLUS | MINUS) expression                 # binaryArithmetic
    | expression op=(LT | LTE | GT | GTE) expression         # comparison
    | expression op=(EQ | NEQ) expression                     # comparison
    | expression IS NOT? NULL                                  # nullPredicate
    | expression AND expression                               # logicalBinary
    | expression OR expression                                # logicalBinary
    | NOT expression                                          # logicalNot
    | LPAREN expression RPAREN                                # parenthesizedExpression
    | CASE expression? whenClause+ (ELSE elseExpression=expression)? END  # caseExpression
    | CAST LPAREN expression AS dataType RPAREN              # castExpression
    | expression TYPECAST dataType                            # castExpression
    | expression CONCAT expression                            # concatenation
    | SUBSTRING LPAREN expression FROM expression (FOR expression)? RPAREN  # substringFunction
    ;

primaryExpression
    : NULL                                                     # nullLiteral
    | number                                                   # numericLiteral
    | booleanValue                                            # booleanLiteral
    | string                                                   # stringLiteral
    | identifier                                               # columnReference
    ;

functionCall
    : identifier LPAREN (expression (COMMA expression)*)? RPAREN
    ;

whenClause
    : WHEN condition=expression THEN result=expression
    ;

dataType
    : SMALLINT
    | INTEGER | INT
    | BIGINT
    | DECIMAL (LPAREN precision (COMMA scale)? RPAREN)?
    | NUMERIC (LPAREN precision (COMMA scale)? RPAREN)?
    | REAL
    | DOUBLE PRECISION?
    | FLOAT (LPAREN precision RPAREN)?
    | BOOLEAN | BOOL
    | CHAR (LPAREN length RPAREN)?
    | CHARACTER (LPAREN length RPAREN)?
    | VARCHAR (LPAREN length RPAREN)?
    | CHARACTER VARYING (LPAREN length RPAREN)?
    | TEXT
    | DATE
    | TIMESTAMP (LPAREN precision RPAREN)? (WITH TIME ZONE | WITHOUT TIME ZONE)?
    | TIMESTAMPTZ (LPAREN precision RPAREN)?
    | TIME (LPAREN precision RPAREN)? (WITH TIME ZONE | WITHOUT TIME ZONE)?
    | TIMETZ (LPAREN precision RPAREN)?
    | SUPER
    | GEOMETRY
    | GEOGRAPHY
    | HLLSKETCH
    | identifier          // Custom types
    ;

precision
    : INTEGER_VALUE
    ;

scale
    : INTEGER_VALUE
    ;

length
    : INTEGER_VALUE
    ;

identifier
    : IDENTIFIER
    | nonReserved
    | DELIMITED_IDENTIFIER
    ;

nonReserved
    : CREATE | MASKING | POLICY | IF | NOT | EXISTS | WITH | USING
    | SMALLINT | INTEGER | INT | BIGINT | DECIMAL | NUMERIC | REAL | DOUBLE
    | PRECISION | FLOAT | BOOLEAN | BOOL | CHAR | CHARACTER | VARCHAR | VARYING
    | TEXT | DATE | TIMESTAMP | TIMESTAMPTZ | TIME | TIMETZ | ZONE | WITHOUT
    | SUPER | GEOMETRY | GEOGRAPHY | HLLSKETCH | SUBSTRING | FROM | FOR
    ;

number
    : DECIMAL_VALUE
    | DOUBLE_VALUE
    | INTEGER_VALUE
    ;

booleanValue
    : TRUE | FALSE
    ;

string
    : STRING
    ;

// Lexer Rules
CREATE: C R E A T E;
MASKING: M A S K I N G;
POLICY: P O L I C Y;
IF: I F;
NOT: N O T;
EXISTS: E X I S T S;
WITH: W I T H;
USING: U S I N G;
LPAREN: '(';
RPAREN: ')';
SEMI: ';';
COMMA: ',';
STAR: '*';
DIV: '/';
MOD: '%';
PLUS: '+';
MINUS: '-';
LT: '<';
LTE: '<=';
GT: '>';
GTE: '>=';
EQ: '=';
NEQ: '<>' | '!=';
IS: I S;
NULL: N U L L;
AND: A N D;
OR: O R;
CASE: C A S E;
WHEN: W H E N;
THEN: T H E N;
ELSE: E L S E;
END: E N D;
CAST: C A S T;
AS: A S;
TYPECAST: '::';
CONCAT: '||';
SUBSTRING: S U B S T R I N G;
FROM: F R O M;
FOR: F O R;
TRUE: T R U E;
FALSE: F A L S E;

// Data type keywords
SMALLINT: S M A L L I N T;
INTEGER: I N T E G E R;
INT: I N T;
BIGINT: B I G I N T;
DECIMAL: D E C I M A L;
NUMERIC: N U M E R I C;
REAL: R E A L;
DOUBLE: D O U B L E;
PRECISION: P R E C I S I O N;
FLOAT: F L O A T;
BOOLEAN: B O O L E A N;
BOOL: B O O L;
CHAR: C H A R;
CHARACTER: C H A R A C T E R;
VARCHAR: V A R C H A R;
VARYING: V A R Y I N G;
TEXT: T E X T;
DATE: D A T E;
TIMESTAMP: T I M E S T A M P;
TIMESTAMPTZ: T I M E S T A M P T Z;
TIME: T I M E;
TIMETZ: T I M E T Z;
ZONE: Z O N E;
WITHOUT: W I T H O U T;
SUPER: S U P E R;
GEOMETRY: G E O M E T R Y;
GEOGRAPHY: G E O G R A P H Y;
HLLSKETCH: H L L S K E T C H;

// Identifiers and Literals
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

DELIMITED_IDENTIFIER
    : '"' (~["] | '""')* '"'
    ;

INTEGER_VALUE
    : DIGIT+
    ;

DECIMAL_VALUE
    : DIGIT+ '.' DIGIT*
    | '.' DIGIT+
    ;

DOUBLE_VALUE
    : DIGIT+ ('.' DIGIT*)? [eE] [+-]? DIGIT+
    ;

STRING
    : '\'' (~['] | '\'\'')* '\''
    ;

// Fragments
fragment DIGIT: [0-9];
fragment A: [aA];
fragment B: [bB];
fragment C: [cC];
fragment D: [dD];
fragment E: [eE];
fragment F: [fF];
fragment G: [gG];
fragment H: [hH];
fragment I: [iI];
fragment J: [jJ];
fragment K: [kK];
fragment L: [lL];
fragment M: [mM];
fragment N: [nN];
fragment O: [oO];
fragment P: [pP];
fragment Q: [qQ];
fragment R: [rR];
fragment S: [sS];
fragment T: [tT];
fragment U: [uU];
fragment V: [vV];
fragment W: [wW];
fragment X: [xX];
fragment Y: [yY];
fragment Z: [zZ];

// Whitespace and Comments
WS: [ \t\r\n]+ -> skip;
COMMENT: '--' ~[\r\n]* -> skip;
MULTILINE_COMMENT: '/*' .*? '*/' -> skip;