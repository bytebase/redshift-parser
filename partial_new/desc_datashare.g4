// Grammar for DESC DATASHARE command
// Based on AWS Redshift documentation: https://docs.aws.amazon.com/redshift/latest/dg/r_DESC_DATASHARE.html

// DESC DATASHARE syntax
desc_datashare_statement:
    (DESC | DESCRIBE) DATASHARE datashare_name (OF (ACCOUNT account_id)? NAMESPACE namespace_guid)?
    ;

// Datashare name can be a regular identifier
datashare_name:
    identifier
    ;

// Account ID is typically a 12-digit number, represented as a string literal
account_id:
    STRING_LITERAL
    ;

// Namespace GUID is a UUID string
namespace_guid:
    STRING_LITERAL
    ;

// Basic identifier rule
identifier:
    IDENTIFIER
    | non_reserved_keyword
    ;

// Non-reserved keywords that can be used as identifiers
non_reserved_keyword:
    ACCOUNT
    | NAMESPACE
    | DATASHARE
    ;

// Lexer tokens
DESC: D E S C;
DESCRIBE: D E S C R I B E;
DATASHARE: D A T A S H A R E;
OF: O F;
ACCOUNT: A C C O U N T;
NAMESPACE: N A M E S P A C E;

// Case-insensitive character fragments
fragment A: [aA];
fragment B: [bB];
fragment C: [cC];
fragment D: [dD];
fragment E: [eE];
fragment F: [fF];
fragment G: [gG];
fragment H: [hH];
fragment I: [iI];
fragment J: [jJ];
fragment K: [kK];
fragment L: [lL];
fragment M: [mM];
fragment N: [nN];
fragment O: [oO];
fragment P: [pP];
fragment Q: [qQ];
fragment R: [rR];
fragment S: [sS];
fragment T: [tT];
fragment U: [uU];
fragment V: [vV];
fragment W: [wW];
fragment X: [xX];
fragment Y: [yY];
fragment Z: [zZ];

// String literal for account IDs and namespace GUIDs
STRING_LITERAL:
    '\'' (~'\'' | '\'\'')* '\''
    ;

// Identifier
IDENTIFIER:
    [a-zA-Z_] [a-zA-Z0-9_$]*
    ;

// Whitespace
WS:
    [ \t\r\n]+ -> skip
    ;

// Comments
LINE_COMMENT:
    '--' ~[\r\n]* -> skip
    ;

BLOCK_COMMENT:
    '/*' .*? '*/' -> skip
    ;