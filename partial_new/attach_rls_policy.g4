attachRlsPolicyStatement
    : ATTACH RLS POLICY policy_name=identifier
      ON TABLE? table_name_list
      TO rls_policy_target_list
    ;

table_name_list
    : qualified_name (COMMA qualified_name)*
    ;

rls_policy_target_list
    : rls_policy_target (COMMA rls_policy_target)*
    ;

rls_policy_target
    : user_name=identifier
    | ROLE role_name=identifier
    | PUBLIC
    ;