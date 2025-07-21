// CREATE EXTERNAL SCHEMA statement - Redshift-specific command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_EXTERNAL_SCHEMA.html
createexternalschemastmt
    : CREATE EXTERNAL SCHEMA opt_if_not_exists? schema_name=colid
      ( fromdatacatalogclause
      | fromhivemetastoreclause
      | frompostgresclause
      | frommysqlclause
      | fromkinesisclause
      | fromkafkaclause
      | frommskclause
      | fromredshiftclause
      )
    ;

// Data Catalog / AWS Glue syntax
fromDataCatalogClause
    : FROM (DATA CATALOG)?
      DATABASE sconst
      REGION sconst
      IAM_ROLE iamRoleValue
      (CATALOG_ROLE catalogRoleValue)?
      (CREATE EXTERNAL DATABASE IF_P NOT EXISTS)?
      (CATALOG_ID sconst)?
    ;

// Hive Metastore syntax
fromHiveMetastoreClause
    : FROM HIVE METASTORE
      DATABASE sconst
      URI sconst
      (PORT INTEGER_LITERAL)?
      IAM_ROLE sconst
    ;

// PostgreSQL federated query syntax
fromPostgresClause
    : FROM POSTGRES
      DATABASE sconst
      (SCHEMA sconst)?
      URI sconst
      (PORT INTEGER_LITERAL)?
      IAM_ROLE iamRoleValue
      SECRET_ARN sconst
    ;

// MySQL federated query syntax
fromMysqlClause
    : FROM MYSQL
      DATABASE sconst
      URI sconst
      (PORT INTEGER_LITERAL)?
      IAM_ROLE iamRoleValue
      SECRET_ARN sconst
    ;

// Kinesis streaming syntax
fromKinesisClause
    : FROM KINESIS
      IAM_ROLE iamRoleValue
    ;

// Kafka streaming syntax
fromKafkaClause
    : FROM KAFKA
      IAM_ROLE iamRoleValue
      (URI sconst)?
      (AUTHENTICATION authenticationValue)?
      (AUTHENTICATION_ARN sconst)?
    ;

// MSK streaming syntax
fromMskClause
    : FROM MSK
      IAM_ROLE iamRoleValue
      (URI sconst)?
      (AUTHENTICATION authenticationValue)?
      (AUTHENTICATION_ARN sconst)?
    ;

// Cross-database query syntax
fromRedshiftClause
    : FROM REDSHIFT
      DATABASE sconst
      SCHEMA sconst?
    ;

// IAM Role value can be DEFAULT, 'SESSION', or ARN string
iamrolevalue
    : DEFAULT
    | SESSION_TOKEN
    | sconst  // ARN string
    ;

// Catalog Role value can be 'SESSION' or ARN string
catalogrolevalue
    : SESSION_TOKEN
    | sconst  // ARN string
    ;

// Authentication methods for streaming
authenticationvalue
    : NONE
    | IAM
    | MTLS
    ;

// Tokens needed in RedshiftLexer.g4:
// EXTERNAL, IAM_ROLE, CATALOG_ROLE, CATALOG_ID, HIVE, METASTORE, URI, PORT,
// POSTGRES, MYSQL, SECRET_ARN, KINESIS, KAFKA, MSK, AUTHENTICATION,
// AUTHENTICATION_ARN, SESSION_TOKEN, MTLS