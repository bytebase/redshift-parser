// ALTER SYSTEM command grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_SYSTEM.html

// ALTER SYSTEM statement
alterSystemStmt
    : ALTER SYSTEM SET systemLevelConfiguration '=' systemConfigValue
    ;

// System-level configuration parameters
systemLevelConfiguration
    : DATA_CATALOG_AUTO_MOUNT
    | METADATA_SECURITY
    | DEFAULT_IDENTITY_NAMESPACE
    ;

// Configuration values
systemConfigValue
    : booleanValue      // for data_catalog_auto_mount and metadata_security
    | stringLiteral     // for default_identity_namespace
    ;

// Boolean values
booleanValue
    : TRUE | T | ON
    | FALSE | F | OFF
    ;

// String literal (for identity namespace)
stringLiteral
    : SCONST
    ;

// Keywords (to be added to lexer)
ALTER : A L T E R;
SYSTEM : S Y S T E M;
SET : S E T;
DATA_CATALOG_AUTO_MOUNT : D A T A '_' C A T A L O G '_' A U T O '_' M O U N T;
METADATA_SECURITY : M E T A D A T A '_' S E C U R I T Y;
DEFAULT_IDENTITY_NAMESPACE : D E F A U L T '_' I D E N T I T Y '_' N A M E S P A C E;
TRUE : T R U E;
FALSE : F A L S E;
T : 'T' | 't';
F : 'F' | 'f';
ON : O N;
OFF : O F F;

// String constant token (assuming it exists in the main lexer)
SCONST : '\'' ( ~['] | '\'\'' )* '\'';

// Fragment definitions for case-insensitive matching
fragment A : [aA];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment I : [iI];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment Y : [yY];