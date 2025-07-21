/*
 * DROP EXTERNAL VIEW command grammar for Amazon Redshift
 * 
 * Supports:
 * - DROP EXTERNAL VIEW view_name
 * - DROP EXTERNAL VIEW IF EXISTS view_name
 * - Catalog/schema qualification: catalog_name.schema_name.view_name
 * - AWS Data Catalog format: awsdatacatalog.dbname.view_name
 * - External schema format: external_schema_name.view_name
 * 
 * Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_DROP_EXTERNAL_VIEW.html
 */

grammar DropExternalView;

// Main rule for DROP EXTERNAL VIEW statement
dropExternalViewStmt
    : DROP EXTERNAL VIEW ifExists? viewName ';'?
    ;

// IF EXISTS clause
ifExists
    : IF EXISTS
    ;

// View name - supports various qualification formats
viewName
    : identifier DOT identifier DOT identifier  // catalog_name.schema_name.view_name or awsdatacatalog.dbname.view_name
    | identifier DOT identifier                  // external_schema_name.view_name or schema_name.view_name
    | identifier                                 // simple view name
    ;

// Identifier rule - supports simple names and quoted names
identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    | unreserved_keyword
    ;

// Common unreserved keywords that can be used as identifiers
unreserved_keyword
    : EXTERNAL
    | VIEW
    | SCHEMA
    | CATALOG
    | DATABASE
    | AWSDATACATALOG
    | SPECTRUM
    | DATA
    | ANALYTICS
    | REPORTING
    | WAREHOUSE
    ;

// Lexer tokens
DROP : D R O P ;
EXTERNAL : E X T E R N A L ;
VIEW : V I E W ;
IF : I F ;
EXISTS : E X I S T S ;

// Common keyword tokens for identifiers
SCHEMA : S C H E M A ;
CATALOG : C A T A L O G ;
DATABASE : D A T A B A S E ;
AWSDATACATALOG : A W S D A T A C A T A L O G ;
SPECTRUM : S P E C T R U M ;
DATA : D A T A ;
ANALYTICS : A N A L Y T I C S ;
REPORTING : R E P O R T I N G ;
WAREHOUSE : W A R E H O U S E ;

// Basic identifier tokens
IDENTIFIER : [a-zA-Z_][a-zA-Z0-9_$]* ;
QUOTED_IDENTIFIER : '"' (~["\r\n] | '""')* '"' ;

// Dot for qualification
DOT : '.' ;

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

// Whitespace and comments
WS : [ \t\r\n]+ -> skip ;
LINE_COMMENT : '--' ~[\r\n]* -> skip ;
BLOCK_COMMENT : '/*' .*? '*/' -> skip ;

// Semicolon
SEMICOLON : ';' ;