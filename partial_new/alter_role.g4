alterRoleStatement
    : ALTER ROLE roleName=identifier (WITH)? alterRoleOption (COMMA alterRoleOption)*
    ;

alterRoleOption
    : RENAME TO newRoleName=identifier
    | OWNER TO userName=identifier
    | EXTERNALID TO externalId=stringLiteral
    ;