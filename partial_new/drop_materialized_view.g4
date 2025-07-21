/*
 * DROP MATERIALIZED VIEW command grammar for Amazon Redshift
 * 
 * Supports:
 * - DROP MATERIALIZED VIEW mv_name
 * - DROP MATERIALIZED VIEW IF EXISTS mv_name
 * - CASCADE/RESTRICT options (RESTRICT is default)
 * - Schema-qualified names: schema_name.mv_name
 * - Multiple view names: DROP MATERIALIZED VIEW view1, view2, view3
 * 
 * Reference: https://docs.aws.amazon.com/redshift/latest/dg/materialized-view-drop-sql-command.html
 */

grammar DropMaterializedView;

// Main rule for DROP MATERIALIZED VIEW statement
dropMaterializedViewStmt
    : DROP MATERIALIZED VIEW ifExists? materializedViewNameList cascadeOption? ';'?
    ;

// IF EXISTS clause
ifExists
    : IF EXISTS
    ;

// List of materialized view names (comma-separated for multiple drops)
materializedViewNameList
    : materializedViewName (COMMA materializedViewName)*
    ;

// Materialized view name - supports schema qualification
materializedViewName
    : identifier DOT identifier    // schema_name.mv_name
    | identifier                   // simple mv_name
    ;

// CASCADE/RESTRICT options
cascadeOption
    : CASCADE
    | RESTRICT
    ;

// Identifier rule - supports simple names and quoted names
identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    | unreserved_keyword
    ;

// Common unreserved keywords that can be used as identifiers
unreserved_keyword
    : MATERIALIZED
    | VIEW
    | SCHEMA
    | CASCADE
    | RESTRICT
    | DATA
    | ANALYTICS
    | REPORTING
    | WAREHOUSE
    | SUMMARY
    | METRICS
    | ORDERS
    | SALES
    | CUSTOMERS
    | PRODUCTS
    | INVENTORY
    | FINANCIAL
    | QUARTERLY
    | MONTHLY
    | DAILY
    ;

// Lexer tokens
DROP : D R O P ;
MATERIALIZED : M A T E R I A L I Z E D ;
VIEW : V I E W ;
IF : I F ;
EXISTS : E X I S T S ;
CASCADE : C A S C A D E ;
RESTRICT : R E S T R I C T ;

// Common keyword tokens for identifiers
SCHEMA : S C H E M A ;
DATA : D A T A ;
ANALYTICS : A N A L Y T I C S ;
REPORTING : R E P O R T I N G ;
WAREHOUSE : W A R E H O U S E ;
SUMMARY : S U M M A R Y ;
METRICS : M E T R I C S ;
ORDERS : O R D E R S ;
SALES : S A L E S ;
CUSTOMERS : C U S T O M E R S ;
PRODUCTS : P R O D U C T S ;
INVENTORY : I N V E N T O R Y ;
FINANCIAL : F I N A N C I A L ;
QUARTERLY : Q U A R T E R L Y ;
MONTHLY : M O N T H L Y ;
DAILY : D A I L Y ;

// Basic identifier tokens
IDENTIFIER : [a-zA-Z_][a-zA-Z0-9_$]* ;
QUOTED_IDENTIFIER : '"' (~["\r\n] | '""')* '"' ;

// Punctuation
COMMA : ',' ;
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