// ALTER MATERIALIZED VIEW grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_MATERIALIZED_VIEW.html

alterMaterializedViewStatement
    : ALTER MATERIALIZED VIEW qualifiedName alterMaterializedViewAction
    ;

alterMaterializedViewAction
    : autoRefreshClause
    | alterDistKeyClause
    | alterDistStyleClause
    | alterSortKeyClause
    | rowLevelSecurityClause
    ;

autoRefreshClause
    : AUTO REFRESH (YES | NO)
    ;

alterDistKeyClause
    : ALTER DISTKEY columnName
    ;

alterDistStyleClause
    : ALTER DISTSTYLE (
        ALL
        | EVEN
        | KEY DISTKEY columnName
        | AUTO
      )
    ;

alterSortKeyClause
    : ALTER COMPOUND? SORTKEY LEFT_PAREN columnList RIGHT_PAREN
    | ALTER SORTKEY (AUTO | NONE)
    ;

rowLevelSecurityClause
    : ROW LEVEL SECURITY (ON | OFF)
      (CONJUNCTION TYPE (AND | OR))?
      (FOR DATASHARES)?
    ;

// Common elements that would be defined in the main parser
qualifiedName
    : (schemaName DOT)? identifier
    ;

schemaName
    : identifier
    ;

columnName
    : identifier
    ;

columnList
    : columnName (COMMA columnName)*
    ;

identifier
    : IDENTIFIER
    | nonReservedWord
    | quotedIdentifier
    ;

quotedIdentifier
    : DOUBLE_QUOTE_ID
    ;

nonReservedWord
    : // This would include all non-reserved keywords from keywords.go
      AUTO | REFRESH | DISTKEY | DISTSTYLE | SORTKEY | COMPOUND
    | LEVEL | SECURITY | CONJUNCTION | TYPE | DATASHARES
    | ALL | EVEN | KEY | YES | NO | ON | OFF | AND | OR | NONE
    ;

// Lexer rules that would be defined in RedshiftLexer.g4
ALTER : A L T E R;
MATERIALIZED : M A T E R I A L I Z E D;
VIEW : V I E W;
AUTO : A U T O;
REFRESH : R E F R E S H;
YES : Y E S;
NO : N O;
DISTKEY : D I S T K E Y;
DISTSTYLE : D I S T S T Y L E;
ALL : A L L;
EVEN : E V E N;
KEY : K E Y;
SORTKEY : S O R T K E Y;
COMPOUND : C O M P O U N D;
NONE : N O N E;
ROW : R O W;
LEVEL : L E V E L;
SECURITY : S E C U R I T Y;
ON : O N;
OFF : O F F;
CONJUNCTION : C O N J U N C T I O N;
TYPE : T Y P E;
AND : A N D;
OR : O R;
FOR : F O R;
DATASHARES : D A T A S H A R E S;

DOT : '.';
COMMA : ',';
LEFT_PAREN : '(';
RIGHT_PAREN : ')';

IDENTIFIER : [a-zA-Z_][a-zA-Z0-9_]*;
DOUBLE_QUOTE_ID : '"' (~["])+ '"';

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