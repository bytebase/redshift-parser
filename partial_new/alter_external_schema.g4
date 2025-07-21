// ALTER EXTERNAL SCHEMA grammar for Amazon Redshift
// Based on: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_EXTERNAL_SCHEMA.html
// Note: OWNER TO is handled through ALTER SCHEMA command which works for both regular and external schemas

// Main ALTER EXTERNAL SCHEMA statement
alterexternalschemastmt
    : ALTER EXTERNAL SCHEMA schema_name=colid alter_external_schema_clauses
    ;

// One or more ALTER EXTERNAL SCHEMA clauses
alter_external_schema_clauses
    : alter_external_schema_clause+
    ;

// Individual ALTER EXTERNAL SCHEMA clause options
alter_external_schema_clause
    : iam_role_clause
    | authentication_clause  
    | authentication_arn_clause
    | uri_clause
    ;

// IAM_ROLE clause
iam_role_clause
    : IAM_ROLE iam_role_value
    ;

iam_role_value
    : DEFAULT
    | SESSION_P  // Using SESSION_P to avoid keyword conflicts
    | sconst     // IAM role ARN string
    ;

// AUTHENTICATION clause
authentication_clause
    : AUTHENTICATION authentication_type
    ;

authentication_type
    : NONE
    | IAM
    | MTLS
    ;

// AUTHENTICATION_ARN or SECRET_ARN clause
authentication_arn_clause
    : AUTHENTICATION_ARN sconst   // ACM certificate ARN
    | SECRET_ARN sconst          // AWS Secrets Manager ARN
    ;

// URI clause for Kafka bootstrap URL
uri_clause
    : URI sconst
    ;

// Additional tokens needed (to be added to RedshiftLexer.g4):
// IAM_ROLE: 'IAM_ROLE';
// AUTHENTICATION: 'AUTHENTICATION';
// AUTHENTICATION_ARN: 'AUTHENTICATION_ARN';
// SECRET_ARN: 'SECRET_ARN';
// URI: 'URI';
// MTLS: 'MTLS';
// IAM: 'IAM';
// SESSION_P: 'SESSION';  // May need _P suffix to avoid conflicts

// Note: For changing schema ownership, use ALTER SCHEMA:
// ALTER SCHEMA schema_name OWNER TO new_owner;
// This works for both regular and external schemas in Redshift