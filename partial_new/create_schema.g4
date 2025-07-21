// CREATE SCHEMA command grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_SCHEMA.html

createSchemaStatement
    : CREATE SCHEMA (IF NOT EXISTS)? schemaName=identifier (AUTHORIZATION userName=identifier)? (QUOTA quotaSpec)?
    ;

quotaSpec
    : quotaValue=numericLiteral quotaUnit
    | UNLIMITED
    ;

quotaUnit
    : MB
    | GB 
    | TB
    ;

identifier
    : IDENTIFIER
    | quotedIdentifier
    ;

quotedIdentifier
    : QUOTED_IDENTIFIER
    ;

numericLiteral
    : INTEGER_LITERAL
    | DECIMAL_LITERAL
    ;

// Keywords
CREATE : C R E A T E ;
SCHEMA : S C H E M A ;
IF : I F ;
NOT : N O T ;
EXISTS : E X I S T S ;
AUTHORIZATION : A U T H O R I Z A T I O N ;
QUOTA : Q U O T A ;
UNLIMITED : U N L I M I T E D ;
MB : M B ;
GB : G B ;
TB : T B ;

// Lexer tokens
IDENTIFIER
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

QUOTED_IDENTIFIER
    : '"' ( ~'"' | '""' )* '"'
    ;

INTEGER_LITERAL
    : [0-9]+
    ;

DECIMAL_LITERAL
    : [0-9]+ '.' [0-9]+
    | '.' [0-9]+
    | [0-9]+ '.'
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