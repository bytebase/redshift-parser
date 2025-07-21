// ALTER RLS POLICY grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_RLS_POLICY.html
//
// Syntax:
// ALTER RLS POLICY policy_name USING (using_predicate_exp);
//
// Note: Based on AWS documentation, ALTER RLS POLICY only supports modifying
// the USING clause. RENAME TO, OWNER TO, and WITH CHECK are not supported.

grammar AlterRlsPolicy;

// Parser rules
alterRlsPolicyStatement
    : ALTER RLS POLICY policyName USING LPAREN usingPredicateExpression RPAREN SEMICOLON?
    ;

policyName
    : identifier
    ;

usingPredicateExpression
    : expression
    ;

// Basic expression rule for the predicate
expression
    : expression AND expression
    | expression OR expression
    | NOT expression
    | expression comparisonOperator expression
    | expression IN LPAREN expressionList RPAREN
    | expression NOT? BETWEEN expression AND expression
    | expression IS NOT? NULL
    | functionCall
    | columnReference
    | literal
    | LPAREN expression RPAREN
    ;

expressionList
    : expression (COMMA expression)*
    ;

comparisonOperator
    : EQ | NEQ | LT | GT | LTE | GTE
    ;

functionCall
    : identifier LPAREN expressionList? RPAREN
    ;

columnReference
    : (identifier DOT)? identifier
    ;

literal
    : STRING_LITERAL
    | NUMBER_LITERAL
    | NULL
    | TRUE
    | FALSE
    ;

identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    ;

// Lexer rules
ALTER : A L T E R ;
RLS : R L S ;
POLICY : P O L I C Y ;
USING : U S I N G ;
AND : A N D ;
OR : O R ;
NOT : N O T ;
IN : I N ;
BETWEEN : B E T W E E N ;
IS : I S ;
NULL : N U L L ;
TRUE : T R U E ;
FALSE : F A L S E ;

// Operators
LPAREN : '(' ;
RPAREN : ')' ;
SEMICOLON : ';' ;
COMMA : ',' ;
DOT : '.' ;
EQ : '=' ;
NEQ : '<>' | '!=' ;
LT : '<' ;
GT : '>' ;
LTE : '<=' ;
GTE : '>=' ;

// Identifiers and literals
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

QUOTED_IDENTIFIER
    : '"' (~["])+ '"'
    ;

STRING_LITERAL
    : '\'' (~['])* '\''
    ;

NUMBER_LITERAL
    : [0-9]+ ('.' [0-9]+)?
    ;

// Whitespace and comments
WS : [ \t\r\n]+ -> skip ;
COMMENT : '--' ~[\r\n]* -> skip ;
MULTI_LINE_COMMENT : '/*' .*? '*/' -> skip ;

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