// ALTER USER command
// https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_USER.html

alter_user_statement
    : K_ALTER K_USER username=alter_user_name ( K_WITH )? alter_user_option ( ',' alter_user_option )*
    ;

alter_user_name
    : identifier                    // Regular username
    | identifier ':' identifier     // External identity provider format (e.g., myco_aad:bob)
    ;

alter_user_option
    : K_CREATEDB
    | K_NOCREATEDB
    | K_CREATEUSER
    | K_NOCREATEUSER
    | K_SYSLOG K_ACCESS ( K_RESTRICTED | K_UNRESTRICTED )
    | K_PASSWORD password_specification
    | K_VALID K_UNTIL string_literal
    | K_RENAME K_TO new_name=identifier
    | K_CONNECTION K_LIMIT ( numeric_literal | K_UNLIMITED )
    | K_SESSION K_TIMEOUT numeric_literal
    | K_RESET K_SESSION K_TIMEOUT
    | K_SET parameter_name=identifier ( K_TO | '=' ) ( parameter_value | K_DEFAULT )
    | K_RESET parameter_name=identifier
    | K_EXTERNALID string_literal
    ;

password_specification
    : string_literal           // Plain password
    | K_DISABLE               // Disable password for IAM authentication
    | md5_hash                // MD5 hash format
    | sha256_hash             // SHA256 hash format
    ;

md5_hash
    : '\'' 'md5' hex_string '\''
    ;

sha256_hash
    : '\'' 'sha256' pipe_operator salt=hex_string pipe_operator digest=hex_string '\''
    ;

hex_string
    : HEX_LITERAL
    ;

pipe_operator
    : '|'
    ;

parameter_value
    : string_literal
    | numeric_literal
    | boolean_literal
    | identifier
    ;

// Lexer tokens (if not already defined)
HEX_LITERAL
    : [0-9a-fA-F]+
    ;