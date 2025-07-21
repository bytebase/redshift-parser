grammar drop_schema;

/*
 * DROP SCHEMA Grammar for Amazon Redshift
 * 
 * Based on AWS Redshift documentation:
 * https://docs.aws.amazon.com/redshift/latest/dg/r_DROP_SCHEMA.html
 * 
 * Syntax:
 * DROP SCHEMA [ IF EXISTS ] name [, ...]
 * [ DROP EXTERNAL DATABASE ]
 * [ CASCADE | RESTRICT ]
 */

// Main rule for DROP SCHEMA statement
dropSchemaStmt
    : DROP SCHEMA ifExists? schemaNameList dropExternalDatabase? (CASCADE | RESTRICT)?
    ;

// Optional IF EXISTS clause
ifExists
    : IF EXISTS
    ;

// Schema name list (comma-separated for multiple schemas)
schemaNameList
    : schemaName (COMMA schemaName)*
    ;

// Individual schema name
schemaName
    : identifier
    ;

// Optional DROP EXTERNAL DATABASE clause
dropExternalDatabase
    : DROP EXTERNAL DATABASE
    ;

// Generic identifier rule
identifier
    : IDENTIFIER
    | quotedIdentifier
    ;

// Quoted identifier (for names with special characters)
quotedIdentifier
    : QUOTED_IDENTIFIER
    ;

// Lexer tokens
DROP : D R O P ;
SCHEMA : S C H E M A ;
IF : I F ;
EXISTS : E X I S T S ;
EXTERNAL : E X T E R N A L ;
DATABASE : D A T A B A S E ;
CASCADE : C A S C A D E ;
RESTRICT : R E S T R I C T ;

COMMA : ',' ;

// Identifier tokens
IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

QUOTED_IDENTIFIER
    : '"' (~["\r\n] | '""')* '"'
    ;

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

// Skip whitespace and comments
WS : [ \t\r\n]+ -> skip ;
COMMENT_SINGLE_LINE : '--' ~[\r\n]* -> skip ;
COMMENT_MULTI_LINE : '/*' .*? '*/' -> skip ;