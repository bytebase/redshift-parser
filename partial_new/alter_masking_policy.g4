// ALTER MASKING POLICY grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_MASKING_POLICY.html

grammar AlterMaskingPolicy;

// Parser Rules
alterMaskingPolicyStatement
    : ALTER MASKING POLICY policyName=identifier USING LPAREN maskingExpression RPAREN SEMI?
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
    : baseType=identifier (LPAREN typeParameter (COMMA typeParameter)? RPAREN)?
    ;

typeParameter
    : INTEGER_VALUE
    ;

identifier
    : IDENTIFIER
    | nonReserved
    | DELIMITED_IDENTIFIER
    ;

nonReserved
    : ALTER | MASKING | POLICY | USING
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
ALTER: A L T E R;
MASKING: M A S K I N G;
POLICY: P O L I C Y;
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
NOT: N O T;
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
TRUE: T R U E;
FALSE: F A L S E;

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