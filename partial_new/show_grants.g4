// SHOW GRANTS statement grammar for Redshift
// Based on: https://docs.aws.amazon.com/redshift/latest/dg/r_SHOW_GRANTS.html

grammar show_grants;

// Main rule for SHOW GRANTS statement
showGrantsStatement
    : SHOW GRANTS (showGrantsOnObject | showGrantsForPrincipal)
    ;

// Show grants on a specific object
showGrantsOnObject
    : ON showGrantsObjectType showGrantsForClause? showGrantsLimitClause?
    ;

// Show grants for a specific user or role
showGrantsForPrincipal
    : FOR showGrantsPrincipal showGrantsLimitClause?
    ;

// Object types that can have grants shown
showGrantsObjectType
    : DATABASE databaseName
    | FUNCTION functionSpecification
    | SCHEMA schemaSpecification
    | TABLE? tableSpecification
    ;

// Function specification with optional parameter list
functionSpecification
    : qualifiedFunctionName (LP functionParameterList? RP)?
    ;

// Qualified function name (with optional database and schema)
qualifiedFunctionName
    : (databaseName DOT)? schemaName DOT functionName
    | schemaName DOT functionName
    ;

// Function parameter list
functionParameterList
    : functionParameter (COMMA functionParameter)*
    ;

// Function parameter (optional name and type)
functionParameter
    : parameterName? dataType
    ;

// Schema specification (with optional database)
schemaSpecification
    : databaseName DOT schemaName
    | schemaName
    ;

// Table specification (with optional database and schema)
tableSpecification
    : databaseName DOT schemaName DOT tableName
    | schemaName DOT tableName
    | tableName
    ;

// FOR clause to filter by principal
showGrantsForClause
    : FOR showGrantsPrincipal
    ;

// Principal (user, role, or PUBLIC)
showGrantsPrincipal
    : userName
    | ROLE roleName
    | PUBLIC
    ;

// LIMIT clause
showGrantsLimitClause
    : LIMIT rowLimit
    ;

// Identifiers
databaseName : identifier ;
schemaName : identifier ;
tableName : identifier ;
functionName : identifier ;
userName : identifier ;
roleName : identifier ;
parameterName : identifier ;
rowLimit : INTEGER_LITERAL ;

// Data type (simplified - can be expanded based on Redshift types)
dataType : identifier ;

// Generic identifier
identifier
    : IDENTIFIER
    | nonReservedKeyword
    ;

// Non-reserved keywords that can be used as identifiers
nonReservedKeyword
    : DATABASE
    | FUNCTION
    | SCHEMA
    | TABLE
    | ROLE
    | PUBLIC
    | GRANTS
    | LIMIT
    ;

// Lexer rules
SHOW : S H O W ;
GRANTS : G R A N T S ;
ON : O N ;
FOR : F O R ;
DATABASE : D A T A B A S E ;
FUNCTION : F U N C T I O N ;
SCHEMA : S C H E M A ;
TABLE : T A B L E ;
ROLE : R O L E ;
PUBLIC : P U B L I C ;
LIMIT : L I M I T ;

// Operators
LP : '(' ;
RP : ')' ;
DOT : '.' ;
COMMA : ',' ;

// Literals
INTEGER_LITERAL : [0-9]+ ;
IDENTIFIER : [a-zA-Z_][a-zA-Z0-9_]* ;

// Whitespace
WS : [ \t\r\n]+ -> skip ;

// Case-insensitive letter fragments
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