// CALL command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CALL_procedure.html

callStatement
    : CALL procedureName LEFT_PAREN procedureArguments? RIGHT_PAREN
    ;

procedureName
    : identifier
    | identifier DOT identifier  // schema.procedure_name
    ;

procedureArguments
    : procedureArgument (COMMA procedureArgument)*
    ;

procedureArgument
    : expression                                    // Positional argument
    | identifier ARROW expression                   // Named argument with =>
    | identifier EQUALS expression                  // Named argument with =
    ;

expression
    : literal
    | identifier
    | functionCall
    | expression PLUS expression
    | expression MINUS expression
    | expression MULTIPLY expression
    | expression DIVIDE expression
    | LEFT_PAREN expression RIGHT_PAREN
    ;

literal
    : NUMBER
    | STRING_LITERAL
    | BOOLEAN_LITERAL
    | NULL
    ;

functionCall
    : identifier LEFT_PAREN (expression (COMMA expression)*)? RIGHT_PAREN
    ;

identifier
    : IDENTIFIER
    | QUOTED_IDENTIFIER
    ;

// Keywords (these would typically be defined in the lexer)
CALL: 'CALL';
LEFT_PAREN: '(';
RIGHT_PAREN: ')';
COMMA: ',';
DOT: '.';
ARROW: '=>';
EQUALS: '=';
PLUS: '+';
MINUS: '-';
MULTIPLY: '*';
DIVIDE: '/';
NULL: 'NULL';

// Literals
NUMBER: [0-9]+ ('.' [0-9]+)?;
STRING_LITERAL: '\'' (~'\'' | '\'\'')* '\'';
BOOLEAN_LITERAL: 'TRUE' | 'FALSE' | 'true' | 'false';
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
QUOTED_IDENTIFIER: '"' (~'"' | '""')* '"';

// Whitespace
WS: [ \t\r\n]+ -> skip;