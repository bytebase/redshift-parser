// CREATE EXTERNAL SCHEMA command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_EXTERNAL_SCHEMA.html

createExternalSchemaStatement
    : CREATE EXTERNAL SCHEMA (IF_P NOT EXISTS)? schemaName
      ( fromDataCatalogClause
      | fromHiveMetastoreClause
      | fromPostgresClause
      | fromMysqlClause
      | fromKinesisClause
      | fromKafkaClause
      | fromMskClause
      | fromRedshiftClause
      )
    ;

schemaName
    : identifier
    ;

// Data Catalog / AWS Glue syntax
fromDataCatalogClause
    : FROM (DATA CATALOG)?
      DATABASE STRING_LITERAL
      REGION STRING_LITERAL
      IAM_ROLE iamRoleValue
      (CATALOG_ROLE catalogRoleValue)?
      (CREATE EXTERNAL DATABASE IF_P NOT EXISTS)?
      (CATALOG_ID STRING_LITERAL)?
    ;

// Hive Metastore syntax
fromHiveMetastoreClause
    : FROM HIVE METASTORE
      DATABASE STRING_LITERAL
      URI STRING_LITERAL
      (PORT INTEGER_LITERAL)?
      IAM_ROLE STRING_LITERAL
    ;

// PostgreSQL federated query syntax
fromPostgresClause
    : FROM POSTGRES
      DATABASE STRING_LITERAL
      (SCHEMA STRING_LITERAL)?
      URI STRING_LITERAL
      (PORT INTEGER_LITERAL)?
      IAM_ROLE iamRoleValue
      SECRET_ARN STRING_LITERAL
    ;

// MySQL federated query syntax
fromMysqlClause
    : FROM MYSQL
      DATABASE STRING_LITERAL
      URI STRING_LITERAL
      (PORT INTEGER_LITERAL)?
      IAM_ROLE iamRoleValue
      SECRET_ARN STRING_LITERAL
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
      (URI STRING_LITERAL)?
      (AUTHENTICATION authenticationValue)?
      (AUTHENTICATION_ARN STRING_LITERAL)?
    ;

// MSK streaming syntax
fromMskClause
    : FROM MSK
      IAM_ROLE iamRoleValue
      (URI STRING_LITERAL)?
      (AUTHENTICATION authenticationValue)?
      (AUTHENTICATION_ARN STRING_LITERAL)?
    ;

// Cross-database query syntax
fromRedshiftClause
    : FROM REDSHIFT
      DATABASE STRING_LITERAL
      SCHEMA STRING_LITERAL?
    ;

// IAM Role value can be DEFAULT, 'SESSION', or ARN string
iamRoleValue
    : DEFAULT
    | SESSION_TOKEN
    | STRING_LITERAL  // ARN string
    ;

// Catalog Role value can be 'SESSION' or ARN string
catalogRoleValue
    : SESSION_TOKEN
    | STRING_LITERAL  // ARN string
    ;

// Authentication methods for streaming
authenticationValue
    : NONE
    | IAM
    | MTLS
    ;

// Tokens (these would typically be in the lexer file)
CREATE: 'CREATE';
EXTERNAL: 'EXTERNAL';
SCHEMA: 'SCHEMA';
IF_P: 'IF';
NOT: 'NOT';
EXISTS: 'EXISTS';
FROM: 'FROM';
DATA: 'DATA';
CATALOG: 'CATALOG';
DATABASE: 'DATABASE';
REGION: 'REGION';
IAM_ROLE: 'IAM_ROLE';
CATALOG_ROLE: 'CATALOG_ROLE';
CATALOG_ID: 'CATALOG_ID';
HIVE: 'HIVE';
METASTORE: 'METASTORE';
URI: 'URI';
PORT: 'PORT';
POSTGRES: 'POSTGRES';
MYSQL: 'MYSQL';
SECRET_ARN: 'SECRET_ARN';
KINESIS: 'KINESIS';
KAFKA: 'KAFKA';
MSK: 'MSK';
REDSHIFT: 'REDSHIFT';
AUTHENTICATION: 'AUTHENTICATION';
AUTHENTICATION_ARN: 'AUTHENTICATION_ARN';
DEFAULT: 'DEFAULT';
SESSION_TOKEN: 'SESSION';
NONE: 'NONE';
IAM: 'IAM';
MTLS: 'MTLS';

// Rules referenced from main parser (placeholders for this partial grammar)
identifier: ID;

// Basic tokens
ID: [a-zA-Z_][a-zA-Z0-9_]*;
INTEGER_LITERAL: [0-9]+;
STRING_LITERAL: '\'' (~['\r\n] | '\'\'')* '\'';
WS: [ \t\r\n]+ -> skip;