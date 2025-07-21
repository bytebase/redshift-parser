/*
 * PREPARE command grammar for Amazon Redshift
 * 
 * Creates a prepared statement from a SQL statement for later execution.
 * Prepared statements can contain parameter placeholders ($1, $2, etc.) for dynamic values.
 * 
 * Syntax:
 * PREPARE plan_name [ (datatype [, ...] ) ] AS statement
 * 
 * Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_PREPARE.html
 */

grammar prepare;

// Main PREPARE statement rule
prepareStmt
    : PREPARE plan_name=IDENTIFIER (LPAREN datatype_list RPAREN)? AS statement
    ;

// List of data types for parameters
datatype_list
    : datatype (COMMA datatype)*
    ;

// Data types supported in PREPARE statement
datatype
    : character_type
    | numeric_type
    | datetime_type
    | boolean_type
    | other_type
    ;

// Character data types
character_type
    : CHAR (LPAREN precision=NUMERIC_LITERAL RPAREN)?
    | CHARACTER (LPAREN precision=NUMERIC_LITERAL RPAREN)?
    | VARCHAR (LPAREN precision=NUMERIC_LITERAL RPAREN)?
    | CHARACTER VARYING (LPAREN precision=NUMERIC_LITERAL RPAREN)?
    | TEXT
    ;

// Numeric data types
numeric_type
    : SMALLINT
    | INTEGER
    | INT
    | BIGINT
    | DECIMAL (LPAREN precision=NUMERIC_LITERAL (COMMA scale=NUMERIC_LITERAL)? RPAREN)?
    | NUMERIC (LPAREN precision=NUMERIC_LITERAL (COMMA scale=NUMERIC_LITERAL)? RPAREN)?
    | REAL
    | DOUBLE PRECISION
    | FLOAT (LPAREN precision=NUMERIC_LITERAL RPAREN)?
    ;

// Date/time data types
datetime_type
    : DATE
    | TIME (LPAREN precision=NUMERIC_LITERAL RPAREN)? (WITH TIME ZONE | WITHOUT TIME ZONE)?
    | TIMESTAMP (LPAREN precision=NUMERIC_LITERAL RPAREN)? (WITH TIME ZONE | WITHOUT TIME ZONE)?
    | TIMESTAMPTZ
    | TIMETZ
    ;

// Boolean data type
boolean_type
    : BOOLEAN
    | BOOL
    ;

// Other data types
other_type
    : BINARY
    | VARBINARY (LPAREN precision=NUMERIC_LITERAL RPAREN)?
    | SUPER
    ;

// The SQL statement to prepare (simplified - could be SELECT, INSERT, UPDATE, DELETE, etc.)
statement
    : select_statement
    | insert_statement
    | update_statement
    | delete_statement
    | other_statement
    ;

// SELECT statement (simplified)
select_statement
    : SELECT select_list from_clause? where_clause? group_by_clause? having_clause? order_by_clause? limit_clause?
    ;

select_list
    : STAR
    | expression (COMMA expression)*
    ;

from_clause
    : FROM table_reference (COMMA table_reference)*
    ;

where_clause
    : WHERE condition
    ;

group_by_clause
    : GROUP BY expression (COMMA expression)*
    ;

having_clause
    : HAVING condition
    ;

order_by_clause
    : ORDER BY expression (ASC | DESC)? (COMMA expression (ASC | DESC)?)*
    ;

limit_clause
    : LIMIT NUMERIC_LITERAL
    ;

// INSERT statement (simplified)
insert_statement
    : INSERT INTO table_name (LPAREN column_list RPAREN)? (VALUES values_list | select_statement)
    ;

column_list
    : IDENTIFIER (COMMA IDENTIFIER)*
    ;

values_list
    : LPAREN expression (COMMA expression)* RPAREN (COMMA LPAREN expression (COMMA expression)* RPAREN)*
    ;

// UPDATE statement (simplified)
update_statement
    : UPDATE table_name SET assignment_list where_clause?
    ;

assignment_list
    : assignment (COMMA assignment)*
    ;

assignment
    : IDENTIFIER EQUALS expression
    ;

// DELETE statement (simplified)
delete_statement
    : DELETE FROM table_name where_clause?
    ;

// Other statements (catch-all for complex statements)
other_statement
    : ~EOF+?
    ;

// Table references and expressions
table_reference
    : table_name (alias_name=IDENTIFIER)?
    ;

table_name
    : IDENTIFIER (DOT IDENTIFIER)?
    ;

condition
    : expression
    ;

expression
    : literal_value
    | parameter_placeholder
    | IDENTIFIER
    | function_call
    | expression EQUALS expression
    | expression NOT_EQUALS expression
    | expression LESS_THAN expression
    | expression GREATER_THAN expression
    | expression LESS_EQUALS expression
    | expression GREATER_EQUALS expression
    | expression AND expression
    | expression OR expression
    | NOT expression
    | LPAREN expression RPAREN
    | expression PLUS expression
    | expression MINUS expression
    | expression MULTIPLY expression
    | expression DIVIDE expression
    ;

function_call
    : IDENTIFIER LPAREN (expression (COMMA expression)*)? RPAREN
    ;

literal_value
    : STRING_LITERAL
    | NUMERIC_LITERAL
    | BOOLEAN_LITERAL
    | NULL
    ;

parameter_placeholder
    : DOLLAR NUMERIC_LITERAL
    ;

// Keywords
PREPARE         : P R E P A R E ;
AS              : A S ;
SELECT          : S E L E C T ;
INSERT          : I N S E R T ;
UPDATE          : U P D A T E ;
DELETE          : D E L E T E ;
INTO            : I N T O ;
FROM            : F R O M ;
WHERE           : W H E R E ;
GROUP           : G R O U P ;
BY              : B Y ;
HAVING          : H A V I N G ;
ORDER           : O R D E R ;
LIMIT           : L I M I T ;
VALUES          : V A L U E S ;
SET             : S E T ;
AND             : A N D ;
OR              : O R ;
NOT             : N O T ;
NULL            : N U L L ;
TRUE            : T R U E ;
FALSE           : F A L S E ;
ASC             : A S C ;
DESC            : D E S C ;

// Data type keywords
CHAR            : C H A R ;
CHARACTER       : C H A R A C T E R ;
VARCHAR         : V A R C H A R ;
VARYING         : V A R Y I N G ;
TEXT            : T E X T ;
SMALLINT        : S M A L L I N T ;
INTEGER         : I N T E G E R ;
INT             : I N T ;
BIGINT          : B I G I N T ;
DECIMAL         : D E C I M A L ;
NUMERIC         : N U M E R I C ;
REAL            : R E A L ;
DOUBLE          : D O U B L E ;
PRECISION       : P R E C I S I O N ;
FLOAT           : F L O A T ;
DATE            : D A T E ;
TIME            : T I M E ;
TIMESTAMP       : T I M E S T A M P ;
TIMESTAMPTZ     : T I M E S T A M P T Z ;
TIMETZ          : T I M E T Z ;
WITH            : W I T H ;
WITHOUT         : W I T H O U T ;
ZONE            : Z O N E ;
BOOLEAN         : B O O L E A N ;
BOOL            : B O O L ;
BINARY          : B I N A R Y ;
VARBINARY       : V A R B I N A R Y ;
SUPER           : S U P E R ;

// Operators and symbols
EQUALS          : '=' ;
NOT_EQUALS      : '<>' | '!=' ;
LESS_THAN       : '<' ;
GREATER_THAN    : '>' ;
LESS_EQUALS     : '<=' ;
GREATER_EQUALS  : '>=' ;
PLUS            : '+' ;
MINUS           : '-' ;
MULTIPLY        : '*' ;
DIVIDE          : '/' ;
LPAREN          : '(' ;
RPAREN          : ')' ;
COMMA           : ',' ;
DOT             : '.' ;
DOLLAR          : '$' ;
STAR            : '*' ;

// Literals and identifiers
IDENTIFIER      : [a-zA-Z_][a-zA-Z0-9_]* ;
STRING_LITERAL  : '\'' (~'\'' | '\'\'')* '\'' ;
NUMERIC_LITERAL : [0-9]+ ('.' [0-9]+)? ([eE] [+-]? [0-9]+)? ;
BOOLEAN_LITERAL : TRUE | FALSE ;

// Case-insensitive character fragments
fragment A : [aA] ;
fragment B : [bB] ;
fragment C : [cC] ;
fragment D : [dD] ;
fragment E : [eE] ;
fragment F : [fF] ;
fragment G : [gG] ;
fragment H : [hH] ;
fragment I : [iI] ;
fragment J : [jJ] ;
fragment K : [kK] ;
fragment L : [lL] ;
fragment M : [mM] ;
fragment N : [nN] ;
fragment O : [oO] ;
fragment P : [pP] ;
fragment Q : [qQ] ;
fragment R : [rR] ;
fragment S : [sS] ;
fragment T : [tT] ;
fragment U : [uU] ;
fragment V : [vV] ;
fragment W : [wW] ;
fragment X : [xX] ;
fragment Y : [yY] ;
fragment Z : [zZ] ;

// Whitespace handling
WS : [ \t\r\n]+ -> skip ;