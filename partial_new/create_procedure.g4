// CREATE PROCEDURE grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_PROCEDURE.html

grammar CreateProcedure;

// Main CREATE PROCEDURE statement
createProcedureStmt
    : CREATE (OR REPLACE)? PROCEDURE procedureName LPAREN procedureParameterList? RPAREN
      (NONATOMIC)?
      AS dollarQuotedBody
      LANGUAGE procedureLanguage
      (securityClause)?
      (setConfigurationClause)*
    ;

// Procedure name
procedureName
    : identifier
    ;

// Procedure parameter list (max 32 input and 32 output parameters)
procedureParameterList
    : procedureParameter (COMMA procedureParameter)*
    ;

// Procedure parameter with optional name and mode
procedureParameter
    : (identifier)? (parameterMode)? dataType
    ;

// Parameter modes
parameterMode
    : IN
    | OUT  
    | INOUT
    ;

// Data types supported in procedures
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

// Security clause
securityClause
    : SECURITY securityMode
    ;

securityMode
    : INVOKER
    | DEFINER
    ;

// SET configuration parameter clause
setConfigurationClause
    : SET configurationParameter (TO | EQ) configurationValue
    ;

configurationParameter
    : identifier
    ;

configurationValue
    : identifier
    | STRING_LITERAL
    | INTEGER_LITERAL
    | DECIMAL_LITERAL
    ;

// Dollar-quoted procedure body
dollarQuotedBody
    : dollarQuoteStart procedureBody dollarQuoteEnd
    ;

dollarQuoteStart
    : DOLLAR_QUOTE_START
    ;

dollarQuoteEnd
    : DOLLAR_QUOTE_END
    ;

// Procedure body content (PL/pgSQL code)
procedureBody
    : plpgsqlBlock
    ;

// PL/pgSQL block structure
plpgsqlBlock
    : (declareSection)?
      BEGIN
      statementList
      (exceptionSection)?
      END
    ;

// DECLARE section for variables
declareSection
    : DECLARE variableDeclaration*
    ;

variableDeclaration
    : identifier dataType (DEFAULT defaultValue)? SEMICOLON
    | identifier CONSTANT dataType (DEFAULT | ASSIGN) defaultValue SEMICOLON
    | identifier CURSOR (LPAREN parameterList RPAREN)? (FOR selectStatement)? SEMICOLON
    | recordDeclaration SEMICOLON
    ;

recordDeclaration
    : identifier identifier PERCENT ROWTYPE
    | identifier RECORD
    ;

parameterList
    : identifier (COMMA identifier)*
    ;

defaultValue
    : literal
    | identifier
    | functionCall
    | expression
    ;

// Statement list
statementList
    : statement*
    ;

// PL/pgSQL statements
statement
    : assignmentStatement SEMICOLON
    | sqlStatement SEMICOLON
    | controlStatement SEMICOLON
    | raiseStatement SEMICOLON
    | returnStatement SEMICOLON
    | nullStatement SEMICOLON
    | labeledStatement
    | blockStatement
    ;

// Assignment statement
assignmentStatement
    : identifier ASSIGN expression
    | identifier DOT identifier ASSIGN expression
    ;

// SQL statements
sqlStatement
    : selectStatement
    | insertStatement
    | updateStatement
    | deleteStatement
    | createStatement
    | dropStatement
    | alterStatement
    | truncateStatement
    | performStatement
    | executeStatement
    ;

// Control flow statements
controlStatement
    : ifStatement
    | loopStatement
    | whileStatement
    | forStatement
    | exitStatement
    | continueStatement
    | caseStatement
    ;

// IF statement
ifStatement
    : IF condition THEN statementList
      (ELSIF condition THEN statementList)*
      (ELSE statementList)?
      END IF
    ;

// LOOP statement
loopStatement
    : (identifier COLON)? LOOP statementList END LOOP (identifier)?
    ;

// WHILE statement
whileStatement
    : (identifier COLON)? WHILE condition LOOP statementList END LOOP (identifier)?
    ;

// FOR statement
forStatement
    : (identifier COLON)? FOR identifier IN forRange LOOP statementList END LOOP (identifier)?
    | (identifier COLON)? FOR identifier IN selectStatement LOOP statementList END LOOP (identifier)?
    ;

forRange
    : expression DOT DOT expression (BY expression)?
    | REVERSE expression DOT DOT expression (BY expression)?
    ;

// EXIT and CONTINUE statements
exitStatement
    : EXIT (identifier)? (WHEN condition)?
    ;

continueStatement
    : CONTINUE (identifier)? (WHEN condition)?
    ;

// CASE statement
caseStatement
    : CASE (expression)?
      (WHEN whenExpression THEN statementList)+
      (ELSE statementList)?
      END CASE
    ;

whenExpression
    : expression
    | condition
    ;

// RAISE statement
raiseStatement
    : RAISE (logLevel)? (formatString (COMMA expression)*)?
    | RAISE (logLevel)? EXCEPTION (formatString (COMMA expression)*)?
    | RAISE (logLevel)? (SQLSTATE sqlStateValue)? (USING raiseOption (COMMA raiseOption)*)?
    ;

logLevel
    : DEBUG
    | LOG
    | INFO
    | NOTICE
    | WARNING
    | EXCEPTION
    ;

formatString
    : STRING_LITERAL
    ;

sqlStateValue
    : STRING_LITERAL
    ;

raiseOption
    : MESSAGE EQ expression
    | DETAIL EQ expression
    | HINT EQ expression
    | ERRCODE EQ expression
    | COLUMN EQ expression
    | CONSTRAINT EQ expression
    | DATATYPE EQ expression
    | TABLE EQ expression
    | SCHEMA EQ expression
    ;

// RETURN statement
returnStatement
    : RETURN (expression)?
    | RETURN NEXT expression
    | RETURN QUERY selectStatement
    ;

// NULL statement
nullStatement
    : NULL
    ;

// Labeled statement
labeledStatement
    : LT LT identifier GT GT
    ;

// Block statement
blockStatement
    : (identifier COLON)? (declareSection)? BEGIN statementList (exceptionSection)? END (identifier)?
    ;

// Exception handling
exceptionSection
    : EXCEPTION (whenClause)+
    ;

whenClause
    : WHEN exceptionName (OR exceptionName)* THEN statementList
    ;

exceptionName
    : identifier
    | OTHERS
    | SQLSTATE STRING_LITERAL
    ;

// Procedure language
procedureLanguage
    : PLPGSQL
    ;

// Basic SQL statements (simplified)
selectStatement
    : SELECT selectList (INTO intoClause)? (FROM fromClause)? (WHERE whereClause)? (GROUP BY groupByClause)? (HAVING havingClause)? (ORDER BY orderByClause)? (LIMIT limitClause)?
    ;

intoClause
    : (STRICT)? identifier (COMMA identifier)*
    ;

selectList
    : selectItem (COMMA selectItem)*
    | ASTERISK
    ;

selectItem
    : expression (AS? identifier)?
    ;

fromClause
    : tableReference (COMMA tableReference)*
    ;

tableReference
    : identifier (AS? identifier)?
    | LPAREN selectStatement RPAREN (AS? identifier)?
    ;

whereClause
    : condition
    ;

groupByClause
    : expression (COMMA expression)*
    ;

havingClause
    : condition
    ;

orderByClause
    : orderByItem (COMMA orderByItem)*
    ;

orderByItem
    : expression (ASC | DESC)? (NULLS (FIRST | LAST))?
    ;

limitClause
    : INTEGER_LITERAL
    | ALL
    ;

insertStatement
    : INSERT INTO identifier (LPAREN columnList RPAREN)? (VALUES valuesList | selectStatement)
    ;

columnList
    : identifier (COMMA identifier)*
    ;

valuesList
    : LPAREN expression (COMMA expression)* RPAREN (COMMA LPAREN expression (COMMA expression)* RPAREN)*
    ;

updateStatement
    : UPDATE identifier SET updateItem (COMMA updateItem)* (WHERE condition)?
    ;

updateItem
    : identifier EQ expression
    ;

deleteStatement
    : DELETE FROM identifier (WHERE condition)?
    ;

createStatement
    : CREATE (TEMP | TEMPORARY)? TABLE identifier (LPAREN columnDefinition (COMMA columnDefinition)* RPAREN)? (AS selectStatement)?
    ;

columnDefinition
    : identifier dataType (NOT NULL)? (DEFAULT defaultValue)?
    ;

dropStatement
    : DROP TABLE (IF EXISTS)? identifier (CASCADE | RESTRICT)?
    ;

alterStatement
    : ALTER TABLE identifier alterAction (COMMA alterAction)*
    ;

alterAction
    : ADD (COLUMN)? columnDefinition
    | DROP (COLUMN)? identifier (CASCADE | RESTRICT)?
    | ALTER (COLUMN)? identifier (SET DEFAULT defaultValue | DROP DEFAULT)
    ;

truncateStatement
    : TRUNCATE TABLE identifier
    ;

performStatement
    : PERFORM expression
    ;

executeStatement
    : EXECUTE expression (INTO intoClause)? (USING expression (COMMA expression)*)?
    ;

// Expressions and conditions
condition
    : expression comparisonOperator expression
    | expression IS (NOT)? NULL
    | expression (NOT)? IN LPAREN (expression (COMMA expression)* | selectStatement) RPAREN
    | expression (NOT)? BETWEEN expression AND expression
    | expression (NOT)? LIKE expression (ESCAPE expression)?
    | EXISTS LPAREN selectStatement RPAREN
    | NOT condition
    | condition AND condition
    | condition OR condition
    | LPAREN condition RPAREN
    | expression
    ;

expression
    : literal
    | identifier
    | identifier DOT identifier
    | functionCall
    | caseExpression
    | LPAREN expression RPAREN
    | expression arithmeticOperator expression
    | unaryOperator expression
    | expression CONCAT expression
    | castExpression
    | arrayExpression
    | parameterReference
    ;

functionCall
    : identifier LPAREN (functionArgument (COMMA functionArgument)*)? RPAREN
    | identifier LPAREN ASTERISK RPAREN
    | identifier LPAREN DISTINCT expression RPAREN
    ;

functionArgument
    : expression
    | identifier ARROW expression
    ;

caseExpression
    : CASE (expression)? (WHEN expression THEN expression)+ (ELSE expression)? END
    ;

castExpression
    : CAST LPAREN expression AS dataType RPAREN
    | expression DOUBLE_COLON dataType
    ;

arrayExpression
    : ARRAY LBRACKET expression (COMMA expression)* RBRACKET
    | LBRACKET expression (COMMA expression)* RBRACKET
    ;

parameterReference
    : DOLLAR INTEGER_LITERAL
    ;

comparisonOperator
    : EQ | NE | LT | LE | GT | GE
    ;

arithmeticOperator
    : PLUS | MINUS | ASTERISK | SLASH | PERCENT | CARET | PIPE_PIPE
    ;

unaryOperator
    : PLUS | MINUS | NOT
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
    | keyword
    ;

keyword
    : CREATE | OR | REPLACE | PROCEDURE | AS | LANGUAGE | IN | OUT | INOUT
    | NONATOMIC | SECURITY | INVOKER | DEFINER | SET | TO | BEGIN | END
    | DECLARE | IF | THEN | ELSE | ELSIF | LOOP | WHILE | FOR | EXIT | CONTINUE
    | CASE | WHEN | RAISE | RETURN | EXCEPTION | OTHERS | AND | OR | NOT
    | SELECT | FROM | WHERE | INSERT | UPDATE | DELETE | CREATE | DROP | ALTER
    | TEMP | TEMPORARY | TABLE | COLUMN | CASCADE | RESTRICT | TRUNCATE
    | PERFORM | EXECUTE | INTO | USING | STRICT | GROUP | BY | HAVING | ORDER
    | LIMIT | VALUES | DEFAULT | CONSTANT | CURSOR | RECORD | ROWTYPE
    | DEBUG | LOG | INFO | NOTICE | WARNING | MESSAGE | DETAIL | HINT | ERRCODE
    | CONSTRAINT | DATATYPE | SCHEMA | NEXT | QUERY | SQLSTATE | REVERSE
    | ASC | DESC | NULLS | FIRST | LAST | ALL | EXISTS | BETWEEN | LIKE | ESCAPE
    | DISTINCT | CAST | ARRAY | CONCAT | IS
    ;

// Tokens
CREATE: C R E A T E;
OR: O R;
REPLACE: R E P L A C E;
PROCEDURE: P R O C E D U R E;
AS: A S;
LANGUAGE: L A N G U A G E;
IN: I N;
OUT: O U T;
INOUT: I N O U T;
NONATOMIC: N O N A T O M I C;
SECURITY: S E C U R I T Y;
INVOKER: I N V O K E R;
DEFINER: D E F I N E R;
SET: S E T;
TO: T O;

// PL/pgSQL keywords
PLPGSQL: P L P G S Q L;
BEGIN: B E G I N;
END: E N D;
DECLARE: D E C L A R E;
IF: I F;
THEN: T H E N;
ELSE: E L S E;
ELSIF: E L S I F;
LOOP: L O O P;
WHILE: W H I L E;
FOR: F O R;
EXIT: E X I T;
CONTINUE: C O N T I N U E;
CASE: C A S E;
WHEN: W H E N;
RAISE: R A I S E;
RETURN: R E T U R N;
EXCEPTION: E X C E P T I O N;
OTHERS: O T H E R S;
AND: A N D;
OR_KW: O R;
NOT: N O T;

// SQL keywords
SELECT: S E L E C T;
FROM: F R O M;
WHERE: W H E R E;
INSERT: I N S E R T;
UPDATE: U P D A T E;
DELETE: D E L E T E;
DROP: D R O P;
ALTER: A L T E R;
TEMP: T E M P;
TEMPORARY: T E M P O R A R Y;
TABLE: T A B L E;
COLUMN: C O L U M N;
CASCADE: C A S C A D E;
RESTRICT: R E S T R I C T;
TRUNCATE: T R U N C A T E;
PERFORM: P E R F O R M;
EXECUTE: E X E C U T E;
INTO: I N T O;
USING: U S I N G;
STRICT: S T R I C T;
GROUP: G R O U P;
BY: B Y;
HAVING: H A V I N G;
ORDER: O R D E R;
LIMIT: L I M I T;
VALUES: V A L U E S;
DEFAULT: D E F A U L T;
CONSTANT: C O N S T A N T;
CURSOR: C U R S O R;
RECORD: R E C O R D;
ROWTYPE: R O W T Y P E;

// RAISE keywords
DEBUG: D E B U G;
LOG: L O G;
INFO: I N F O;
NOTICE: N O T I C E;
WARNING: W A R N I N G;
MESSAGE: M E S S A G E;
DETAIL: D E T A I L;
HINT: H I N T;
ERRCODE: E R R C O D E;
CONSTRAINT: C O N S T R A I N T;
DATATYPE: D A T A T Y P E;
SCHEMA: S C H E M A;
NEXT: N E X T;
QUERY: Q U E R Y;
SQLSTATE: S Q L S T A T E;
REVERSE: R E V E R S E;

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

// Additional SQL keywords
ASC: A S C;
DESC: D E S C;
NULLS: N U L L S;
FIRST: F I R S T;
LAST: L A S T;
ALL: A L L;
EXISTS: E X I S T S;
BETWEEN: B E T W E E N;
LIKE: L I K E;
ESCAPE: E S C A P E;
DISTINCT: D I S T I N C T;
CAST: C A S T;
ARRAY: A R R A Y;
IS: I S;
NULL: N U L L;
CONCAT: C O N C A T;

// Operators
PLUS: '+';
MINUS: '-';
ASTERISK: '*';
SLASH: '/';
PERCENT: '%';
CARET: '^';
GT: '>';
LT: '<';
GE: '>=';
LE: '<=';
EQ: '=';
NE: '!=' | '<>';
ASSIGN: ':=';
ARROW: '=>';
PIPE_PIPE: '||';
DOUBLE_COLON: '::';

// Punctuation
LPAREN: '(';
RPAREN: ')';
LBRACKET: '[';
RBRACKET: ']';
COMMA: ',';
SEMICOLON: ';';
DOT: '.';
COLON: ':';
DOLLAR: '$';

// Dollar quoting
DOLLAR_QUOTE_START: '$$';
DOLLAR_QUOTE_END: '$$';

// Literals
INTEGER_LITERAL: [0-9]+;
DECIMAL_LITERAL: [0-9]+ '.' [0-9]+;
STRING_LITERAL: '\'' (~['\r\n] | '\'\'')* '\'';
BOOLEAN_LITERAL: 'TRUE' | 'true' | 'FALSE' | 'false';

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