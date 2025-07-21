/*
 * Grammar for DROP RLS POLICY command in Amazon Redshift
 * Based on AWS documentation: https://docs.aws.amazon.com/redshift/latest/dg/r_DROP_RLS_POLICY.html
 * 
 * Syntax: DROP RLS POLICY [ IF EXISTS ] policy_name [ CASCADE | RESTRICT ]
 */

grammar drop_rls_policy;

// Main rule for DROP RLS POLICY statement
drop_rls_policy_statement
    : DROP RLS POLICY if_exists_clause? policy_name drop_behavior_clause? SEMICOLON?
    ;

// Optional IF EXISTS clause
if_exists_clause
    : IF EXISTS
    ;

// Policy name identifier
policy_name
    : identifier
    ;

// Optional CASCADE or RESTRICT clause
drop_behavior_clause
    : CASCADE
    | RESTRICT
    ;

// Identifier rule (supports quoted and unquoted identifiers)
identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    ;

// Lexer tokens
DROP        : 'DROP' | 'drop' ;
RLS         : 'RLS' | 'rls' ;
POLICY      : 'POLICY' | 'policy' ;
IF          : 'IF' | 'if' ;
EXISTS      : 'EXISTS' | 'exists' ;
CASCADE     : 'CASCADE' | 'cascade' ;
RESTRICT    : 'RESTRICT' | 'restrict' ;

IDENTIFIER          : [a-zA-Z_][a-zA-Z0-9_]* ;
QUOTED_IDENTIFIER   : '"' (~["\r\n])* '"' ;

SEMICOLON   : ';' ;
WS          : [ \t\r\n]+ -> skip ;