// DROP PROCEDURE grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_DROP_PROCEDURE.html

grammar DropProcedure;

// Main DROP PROCEDURE statement
dropProcedureStmt
    : DROP PROCEDURE (IF EXISTS)? procedureName LPAREN procedureArgumentList? RPAREN (CASCADE | RESTRICT)?
    ;

// Procedure name (can be schema-qualified)
procedureName
    : identifier (DOT identifier)?
    ;

// Procedure argument list for signature matching (up to 32 input parameters)
procedureArgumentList
    : procedureArgument (COMMA procedureArgument)*
    ;

// Procedure argument (argument name is optional and ignored, mode is optional)
procedureArgument
    : (identifier)? (parameterMode)? dataType     // [arg_name] [mode] arg_type
    | (parameterMode)? (identifier)? dataType     // [mode] [arg_name] arg_type
    ;

// Parameter modes (IN, OUT, INOUT)
parameterMode
    : IN
    | OUT  
    | INOUT
    ;

// Data types supported (must match CREATE PROCEDURE types)
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
    | TEXT
    | SUPER
    | GEOMETRY
    | GEOGRAPHY
    | HLLSKETCH
    | identifier          // Custom types
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
DROP: D R O P;
PROCEDURE: P R O C E D U R E;
IF: I F;
EXISTS: E X I S T S;
CASCADE: C A S C A D E;
RESTRICT: R E S T R I C T;

// Parameter modes
IN: I N;
OUT: O U T;
INOUT: I N O U T;

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
TEXT: T E X T;
SUPER: S U P E R;
GEOMETRY: G E O M E T R Y;
GEOGRAPHY: G E O G R A P H Y;
HLLSKETCH: H L L S K E T C H;

// Punctuation
LPAREN: '(';
RPAREN: ')';
COMMA: ',';
SEMICOLON: ';';
DOT: '.';

// Literals
INTEGER_LITERAL: [0-9]+;

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