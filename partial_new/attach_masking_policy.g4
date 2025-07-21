// ATTACH MASKING POLICY statement grammar for Amazon Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_ATTACH_MASKING_POLICY.html

grammar AttachMaskingPolicy;

// Parser Rules
attachMaskingPolicyStatement
    : ATTACH MASKING POLICY policyName=identifier
      ON relationName=identifier
      '(' outputColumnList ')'
      (USING '(' inputColumnList ')')?
      TO attachTarget
      (PRIORITY priority=INTEGER)?
      ';'?
    ;

outputColumnList
    : outputColumn (',' outputColumn)*
    ;

outputColumn
    : columnName=identifier          # SimpleOutputColumn
    | superPath                      # SuperOutputColumn
    ;

inputColumnList
    : inputColumn (',' inputColumn)*
    ;

inputColumn
    : columnName=identifier          # SimpleInputColumn
    | superPath                      # SuperInputColumn
    ;

superPath
    : identifier ('.' identifier)+
    ;

attachTarget
    : userName=identifier            # UserTarget
    | ROLE roleName=identifier       # RoleTarget
    | PUBLIC                         # PublicTarget
    ;

identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    | nonReservedKeyword
    ;

nonReservedKeyword
    : ATTACH
    | MASKING
    | POLICY
    | USING
    | PRIORITY
    | ROLE
    ;

// Lexer Rules
ATTACH    : A T T A C H;
MASKING   : M A S K I N G;
POLICY    : P O L I C Y;
ON        : O N;
USING     : U S I N G;
TO        : T O;
PRIORITY  : P R I O R I T Y;
ROLE      : R O L E;
PUBLIC    : P U B L I C;

IDENTIFIER
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

QUOTED_IDENTIFIER
    : '"' (~["\r\n] | '""')* '"'
    ;

INTEGER
    : [0-9]+
    ;

// Fragment rules for case-insensitive matching
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

// Whitespace and comments
WS
    : [ \t\r\n]+ -> skip
    ;

SINGLE_LINE_COMMENT
    : '--' ~[\r\n]* -> skip
    ;

MULTI_LINE_COMMENT
    : '/*' .*? '*/' -> skip
    ;