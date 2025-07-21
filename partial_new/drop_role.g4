/*
 * Grammar for DROP ROLE command in Amazon Redshift
 * Based on AWS documentation: https://docs.aws.amazon.com/redshift/latest/dg/r_DROP_ROLE.html
 * 
 * Syntax: DROP ROLE role_name [ FORCE | RESTRICT ]
 */

grammar drop_role;

// Main rule for DROP ROLE statement
drop_role_statement
    : DROP ROLE role_name drop_behavior_clause? SEMICOLON?
    ;

// Role name identifier
role_name
    : identifier
    ;

// Optional FORCE or RESTRICT clause
drop_behavior_clause
    : FORCE
    | RESTRICT
    ;

// Identifier rule (supports quoted and unquoted identifiers)
identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    ;

// Lexer tokens
DROP        : 'DROP' | 'drop' ;
ROLE        : 'ROLE' | 'role' ;
FORCE       : 'FORCE' | 'force' ;
RESTRICT    : 'RESTRICT' | 'restrict' ;

IDENTIFIER          : [a-zA-Z_][a-zA-Z0-9_]* ;
QUOTED_IDENTIFIER   : '"' (~["\r\n])* '"' ;

SEMICOLON   : ';' ;
WS          : [ \t\r\n]+ -> skip ;