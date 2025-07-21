// CREATE FUNCTION grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_FUNCTION.html

grammar CreateFunction;

// Main CREATE FUNCTION statement
createFunctionStmt
    : CREATE (OR REPLACE)? FUNCTION functionName LPAREN functionParameterList? RPAREN
      RETURNS dataType
      functionVolatility
      AS dollarQuotedBody
      LANGUAGE functionLanguage
    ;

// Function name (recommended to start with 'f_')
functionName
    : identifier
    ;

// Function parameter list (max 32 parameters)
functionParameterList
    : functionParameter (COMMA functionParameter)*
    ;

// Function parameter
functionParameter
    : pythonParameter     // For Python UDFs: py_arg_name py_arg_data_type
    | sqlParameter        // For SQL UDFs: just the data type
    ;

// Python parameter with name and type
pythonParameter
    : identifier dataType
    ;

// SQL parameter with just type
sqlParameter
    : dataType
    ;

// Data types supported
dataType
    : SMALLINT
    | INTEGER | INT
    | BIGINT
    | DECIMAL (LPAREN precision (COMMA scale)? RPAREN)?
    | NUMERIC (LPAREN precision (COMMA scale)? RPAREN)?
    | REAL
    | DOUBLE PRECISION
    | FLOAT (LPAREN precision RPAREN)?
    | BOOLEAN | BOOL
    | CHAR (LPAREN length RPAREN)?
    | CHARACTER (LPAREN length RPAREN)?
    | VARCHAR (LPAREN length RPAREN)?
    | CHARACTER VARYING (LPAREN length RPAREN)?
    | DATE
    | TIMESTAMP (LPAREN precision RPAREN)? (WITH TIME ZONE | WITHOUT TIME ZONE)?
    | TIMESTAMPTZ (LPAREN precision RPAREN)?
    | TIME (LPAREN precision RPAREN)? (WITH TIME ZONE | WITHOUT TIME ZONE)?
    | TIMETZ (LPAREN precision RPAREN)?
    | ANYELEMENT
    | TEXT
    | SUPER
    | GEOMETRY
    | GEOGRAPHY
    | HLLSKETCH
    | identifier          // Custom types
    ;

// Function volatility
functionVolatility
    : VOLATILE
    | STABLE
    | IMMUTABLE
    ;

// Dollar-quoted function body
dollarQuotedBody
    : dollarQuoteStart functionBody dollarQuoteEnd
    ;

dollarQuoteStart
    : DOLLAR_QUOTE_START
    ;

dollarQuoteEnd
    : DOLLAR_QUOTE_END
    ;

// Function body content (Python program or SQL SELECT clause)
functionBody
    : pythonProgram
    | sqlSelectClause
    ;

// Python program body
pythonProgram
    : PYTHON_BODY
    ;

// SQL SELECT clause
sqlSelectClause
    : SELECT selectList (FROM fromClause)? (WHERE whereClause)?
    | CASE caseExpression
    | functionBodyExpression
    ;

// Simple expressions for function bodies
functionBodyExpression
    : parameterReference
    | literal
    | functionCall
    | arithmeticExpression
    | conditionalExpression
    | LPAREN functionBodyExpression RPAREN
    ;

// Parameter references ($1, $2, etc. for SQL UDFs)
parameterReference
    : DOLLAR INTEGER_LITERAL
    | identifier  // For Python UDFs
    ;

// Function language
functionLanguage
    : SQL
    | PLPYTHONU
    ;

// Supporting rules
selectList
    : selectItem (COMMA selectItem)*
    ;

selectItem
    : functionBodyExpression (AS? identifier)?
    | ASTERISK
    ;

fromClause
    : tableReference (COMMA tableReference)*
    ;

tableReference
    : identifier (AS? identifier)?
    ;

whereClause
    : functionBodyExpression
    ;

caseExpression
    : WHEN functionBodyExpression THEN functionBodyExpression (ELSE functionBodyExpression)? END
    ;

functionCall
    : identifier LPAREN (functionBodyExpression (COMMA functionBodyExpression)*)? RPAREN
    ;

arithmeticExpression
    : functionBodyExpression (PLUS | MINUS | ASTERISK | SLASH) functionBodyExpression
    ;

conditionalExpression
    : functionBodyExpression (GT | LT | GTE | LTE | EQ | NE) functionBodyExpression
    ;

literal
    : INTEGER_LITERAL
    | DECIMAL_LITERAL
    | STRING_LITERAL
    | BOOLEAN_LITERAL
    | NULL
    ;

precision
    : INTEGER_LITERAL
    ;

scale
    : INTEGER_LITERAL
    ;

length
    : INTEGER_LITERAL
    ;

identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    ;

// Tokens
CREATE: C R E A T E;
OR: O R;
REPLACE: R E P L A C E;
FUNCTION: F U N C T I O N;
RETURNS: R E T U R N S;
AS: A S;
LANGUAGE: L A N G U A G E;

// Volatility keywords
VOLATILE: V O L A T I L E;
STABLE: S T A B L E;
IMMUTABLE: I M M U T A B L E;

// Language keywords
SQL: S Q L;
PLPYTHONU: P L P Y T H O N U;

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
DATE: D A T E;
TIMESTAMP: T I M E S T A M P;
TIMESTAMPTZ: T I M E S T A M P T Z;
TIME: T I M E;
TIMETZ: T I M E T Z;
ZONE: Z O N E;
WITH: W I T H;
WITHOUT: W I T H O U T;
ANYELEMENT: A N Y E L E M E N T;
TEXT: T E X T;
SUPER: S U P E R;
GEOMETRY: G E O M E T R Y;
GEOGRAPHY: G E O G R A P H Y;
HLLSKETCH: H L L S K E T C H;

// SQL keywords
SELECT: S E L E C T;
FROM: F R O M;
WHERE: W H E R E;
CASE: C A S E;
WHEN: W H E N;
THEN: T H E N;
ELSE: E L S E;
END: E N D;
NULL: N U L L;

// Operators
PLUS: '+';
MINUS: '-';
ASTERISK: '*';
SLASH: '/';
GT: '>';
LT: '<';
GTE: '>=';
LTE: '<=';
EQ: '=';
NE: '!=' | '<>';

// Punctuation
LPAREN: '(';
RPAREN: ')';
COMMA: ',';
SEMICOLON: ';';
DOT: '.';
DOLLAR: '$';

// Dollar quoting
DOLLAR_QUOTE_START: '$$';
DOLLAR_QUOTE_END: '$$';

// Literals
INTEGER_LITERAL: [0-9]+;
DECIMAL_LITERAL: [0-9]+ '.' [0-9]+;
STRING_LITERAL: '\'' (~['\r\n] | '\'\'')* '\'';
BOOLEAN_LITERAL: 'TRUE' | 'true' | 'FALSE' | 'false';

// Python body (everything between $$ tags for Python functions)
PYTHON_BODY: ~[\r\n$]+;

// Identifiers
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
QUOTED_IDENTIFIER: '"' (~["\r\n] | '""')* '"';

// Case-insensitive fragments
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

// Whitespace and comments
WS: [ \t\r\n]+ -> skip;
LINE_COMMENT: '--' ~[\r\n]* -> skip;
BLOCK_COMMENT: '/*' .*? '*/' -> skip;