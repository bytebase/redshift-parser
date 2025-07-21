// DROP RLS POLICY statement - Redshift-specific command

droprlspolicystmt:
    DROP RLS POLICY opt_if_exists colid opt_drop_behavior
    ;

opt_if_exists:
    IF EXISTS | /* empty */
    ;

opt_drop_behavior:
    CASCADE | RESTRICT | /* empty */
    ;

// Needed tokens: DROP, RLS, POLICY, IF, EXISTS, CASCADE, RESTRICT