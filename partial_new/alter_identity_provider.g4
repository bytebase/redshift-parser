parser grammar AlterIdentityProvider;

// ALTER IDENTITY PROVIDER statement
alterIdentityProviderStatement
    : ALTER IDENTITY PROVIDER identityProviderName alterIdentityProviderAction* EOF
    ;

identityProviderName
    : identifier
    ;

alterIdentityProviderAction
    : alterIdentityProviderParameters
    | alterIdentityProviderNamespace
    | alterIdentityProviderIamRole
    | alterIdentityProviderAutoCreateRoles
    | alterIdentityProviderEnable
    | alterIdentityProviderDisable
    ;

alterIdentityProviderParameters
    : PARAMETERS parameterString
    ;

parameterString
    : StringLiteral
    ;

alterIdentityProviderNamespace
    : NAMESPACE namespaceName
    ;

namespaceName
    : StringLiteral
    ;

alterIdentityProviderIamRole
    : IAM_ROLE iamRoleArn
    ;

iamRoleArn
    : StringLiteral
    ;

alterIdentityProviderAutoCreateRoles
    : AUTO_CREATE_ROLES autoCreateRolesOption
    ;

autoCreateRolesOption
    : TRUE (groupFilter)?
    | FALSE
    ;

groupFilter
    : (INCLUDE | EXCLUDE) GROUPS LIKE filterPattern
    ;

filterPattern
    : StringLiteral
    ;

alterIdentityProviderEnable
    : ENABLE
    ;

alterIdentityProviderDisable
    : DISABLE
    ;

identifier
    : Identifier
    | QuotedIdentifier
    | StringLiteral
    ;

// Lexer rules (these would normally be in a separate lexer file)
ALTER: 'ALTER';
IDENTITY: 'IDENTITY';
PROVIDER: 'PROVIDER';
PARAMETERS: 'PARAMETERS';
NAMESPACE: 'NAMESPACE';
IAM_ROLE: 'IAM_ROLE';
AUTO_CREATE_ROLES: 'AUTO_CREATE_ROLES';
TRUE: 'TRUE';
FALSE: 'FALSE';
INCLUDE: 'INCLUDE';
EXCLUDE: 'EXCLUDE';
GROUPS: 'GROUPS';
LIKE: 'LIKE';
ENABLE: 'ENABLE';
DISABLE: 'DISABLE';

// Basic tokens
Identifier
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

QuotedIdentifier
    : '"' (~["])+ '"'
    ;

StringLiteral
    : '\'' (~['])* '\''
    ;

// Whitespace and comments
WS
    : [ \t\r\n]+ -> skip
    ;

Comment
    : '--' ~[\r\n]* -> skip
    ;

BlockComment
    : '/*' .*? '*/' -> skip
    ;