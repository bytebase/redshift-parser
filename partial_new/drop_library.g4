// DROP LIBRARY command grammar for Amazon Redshift
// Based on AWS documentation: https://docs.aws.amazon.com/redshift/latest/dg/r_DROP_LIBRARY.html
//
// Syntax: DROP LIBRARY library_name
//
// Notes:
// - Removes a custom Python library from the database
// - Can only be executed by superusers, users with DROP LIBRARY privilege, or library owner
// - Cannot be run inside a transaction block
// - Command commits immediately and is not reversible
// - May cause dependent UDFs to fail if running concurrently

grammar DropLibrary;

// Main rule for DROP LIBRARY statement
dropLibraryStatement
    : DROP LIBRARY libraryName
    ;

// Library name - can be a simple identifier or quoted identifier
libraryName
    : identifier
    | quotedIdentifier
    ;

// Basic identifier rules
identifier
    : IDENTIFIER
    ;

quotedIdentifier
    : QUOTED_IDENTIFIER
    ;

// Lexer rules
DROP : [Dd][Rr][Oo][Pp] ;
LIBRARY : [Ll][Ii][Bb][Rr][Aa][Rr][Yy] ;

// Identifier patterns
IDENTIFIER : [a-zA-Z_][a-zA-Z0-9_$]* ;
QUOTED_IDENTIFIER : '"' (~["\r\n] | '""')* '"' ;

// Whitespace and comments
WS : [ \t\r\n]+ -> skip ;
LINE_COMMENT : '--' ~[\r\n]* -> skip ;
BLOCK_COMMENT : '/*' .*? '*/' -> skip ;