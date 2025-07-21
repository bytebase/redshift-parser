grammar CreateRlsPolicy;

// CREATE RLS POLICY grammar for Amazon Redshift
// Based on AWS documentation: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_RLS_POLICY.html

createRlsPolicyStatement
    : CREATE RLS POLICY policy_name
      ( WITH LPAREN columnDefinitionList RPAREN ( ( AS )? relation_alias )? )?
      USING LPAREN using_predicate_expression RPAREN
    ;

policy_name
    : identifier
    ;

columnDefinitionList
    : columnDefinition ( COMMA columnDefinition )*
    ;

columnDefinition
    : column_name data_type
    ;

column_name
    : identifier
    ;

data_type
    : VARCHAR LPAREN numeric_literal RPAREN
    | INTEGER
    | BIGINT
    | DECIMAL ( LPAREN numeric_literal ( COMMA numeric_literal )? RPAREN )?
    | NUMERIC ( LPAREN numeric_literal ( COMMA numeric_literal )? RPAREN )?
    | REAL
    | DOUBLE PRECISION
    | BOOLEAN
    | CHAR ( LPAREN numeric_literal RPAREN )?
    | CHARACTER ( LPAREN numeric_literal RPAREN )?
    | DATE
    | TIMESTAMP ( LPAREN numeric_literal RPAREN )? ( WITH TIME ZONE | WITHOUT TIME ZONE )?
    | TIMESTAMPTZ ( LPAREN numeric_literal RPAREN )?
    | TIME ( LPAREN numeric_literal RPAREN )? ( WITH TIME ZONE | WITHOUT TIME ZONE )?
    | TIMETZ ( LPAREN numeric_literal RPAREN )?
    | identifier // for custom types
    ;

relation_alias
    : identifier
    ;

using_predicate_expression
    : expression
    ;

expression
    : expression AND expression
    | expression OR expression
    | expression comparison_operator expression
    | expression IN LPAREN expression_list RPAREN
    | expression NOT IN LPAREN expression_list RPAREN
    | expression IS NULL
    | expression IS NOT NULL
    | expression LIKE string_literal
    | expression NOT LIKE string_literal
    | NOT expression
    | LPAREN expression RPAREN
    | identifier
    | string_literal
    | numeric_literal
    | boolean_literal
    | function_call
    ;

expression_list
    : expression ( COMMA expression )*
    ;

comparison_operator
    : EQ
    | NE
    | LT
    | LE
    | GT
    | GE
    ;

function_call
    : identifier LPAREN ( expression_list )? RPAREN
    ;

identifier
    : IDENTIFIER
    | quoted_identifier
    ;

quoted_identifier
    : QUOTED_IDENTIFIER
    ;

string_literal
    : STRING_LITERAL
    ;

numeric_literal
    : NUMERIC_LITERAL
    ;

boolean_literal
    : TRUE
    | FALSE
    ;

// Lexer tokens
CREATE : C R E A T E ;
RLS : R L S ;
POLICY : P O L I C Y ;
WITH : W I T H ;
AS : A S ;
USING : U S I N G ;
AND : A N D ;
OR : O R ;
NOT : N O T ;
IN : I N ;
IS : I S ;
NULL : N U L L ;
LIKE : L I K E ;
TRUE : T R U E ;
FALSE : F A L S E ;
VARCHAR : V A R C H A R ;
INTEGER : I N T E G E R ;
BIGINT : B I G I N T ;
DECIMAL : D E C I M A L ;
NUMERIC : N U M E R I C ;
REAL : R E A L ;
DOUBLE : D O U B L E ;
PRECISION : P R E C I S I O N ;
BOOLEAN : B O O L E A N ;
CHAR : C H A R ;
CHARACTER : C H A R A C T E R ;
DATE : D A T E ;
TIMESTAMP : T I M E S T A M P ;
TIMESTAMPTZ : T I M E S T A M P T Z ;
TIME : T I M E ;
TIMETZ : T I M E T Z ;
ZONE : Z O N E ;
WITHOUT : W I T H O U T ;

LPAREN : '(' ;
RPAREN : ')' ;
COMMA : ',' ;
EQ : '=' ;
NE : '<>' | '!=' ;
LT : '<' ;
LE : '<=' ;
GT : '>' ;
GE : '>=' ;

IDENTIFIER
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

QUOTED_IDENTIFIER
    : '"' ( ~'"' | '""' )* '"'
    ;

STRING_LITERAL
    : '\'' ( ~'\'' | '\'\'' )* '\''
    ;

NUMERIC_LITERAL
    : [0-9]+ ( '.' [0-9]+ )? ( [eE] [+-]? [0-9]+ )?
    ;

WS : [ \t\r\n]+ -> skip ;

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