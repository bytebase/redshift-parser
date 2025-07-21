/*
 * CREATE MODEL command grammar for Amazon Redshift
 * Based on AWS documentation: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_MODEL.html
 */

// CREATE MODEL Statement
createModelStmt
    : CREATE MODEL qualifiedName
      FROM createModelFromClause
      (TARGET columnName)?
      FUNCTION functionName (LPAREN dataTypeList RPAREN)?
      (RETURNS dataType)?
      (SAGEMAKER sagemakerEndpoint)?
      IAM_ROLE iamRoleSpec
      (AUTO (ON | OFF))?
      (MODEL_TYPE modelTypeSpec)?
      (PROBLEM_TYPE problemTypeSpec)?
      (OBJECTIVE objectiveSpec)?
      (PREPROCESSORS stringLiteral)?
      (HYPERPARAMETERS hyperparametersSpec)?
      (SETTINGS LPAREN settingsClause RPAREN)?
    ;

// FROM clause options
createModelFromClause
    : qualifiedName                          // table_name
    | LPAREN selectStmt RPAREN              // (select_statement)
    | stringLiteral                         // 'job_name'
    ;

// IAM Role specification
iamRoleSpec
    : DEFAULT
    | stringLiteral  // 'arn:aws:iam::<account-id>:role/<role-name>'
    ;

// SageMaker endpoint specification
sagemakerEndpoint
    : stringLiteral (COLON stringLiteral)?  // 'endpoint_name':'model_name'
    ;

// Model type specification
modelTypeSpec
    : XGBOOST
    | MLP
    | LINEAR_LEARNER
    | KMEANS
    | FORECAST
    ;

// Problem type specification
problemTypeSpec
    : LPAREN problemType RPAREN
    ;

problemType
    : REGRESSION
    | BINARY_CLASSIFICATION
    | MULTICLASS_CLASSIFICATION
    ;

// Objective specification
objectiveSpec
    : LPAREN stringLiteral RPAREN  // 'MSE', 'Accuracy', etc.
    ;

// Hyperparameters specification
hyperparametersSpec
    : DEFAULT
    | DEFAULT EXCEPT LPAREN hyperparametersList RPAREN
    ;

hyperparametersList
    : hyperparameterItem (COMMA hyperparameterItem)*
    ;

hyperparameterItem
    : identifier stringLiteral
    ;

// Settings clause
settingsClause
    : settingsItem (COMMA settingsItem)*
    ;

settingsItem
    : S3_BUCKET stringLiteral
    | TAGS stringLiteral
    | KMS_KEY_ID stringLiteral
    | S3_GARBAGE_COLLECT (ON | OFF)
    | MAX_CELLS integerLiteral
    | MAX_RUNTIME integerLiteral
    | HORIZON integerLiteral
    | FREQUENCY integerLiteral
    | PERCENTILES stringLiteral
    | MAX_BATCH_ROWS integerLiteral
    ;

// Data type list for function parameters
dataTypeList
    : dataType (COMMA dataType)*
    ;

// Basic elements
qualifiedName
    : identifier (DOT identifier)*
    ;

columnName
    : identifier
    ;

functionName
    : identifier
    ;

dataType
    : identifier (LPAREN integerLiteral (COMMA integerLiteral)? RPAREN)?
    ;

identifier
    : IDENTIFIER
    | quotedIdentifier
    ;

quotedIdentifier
    : QUOTED_IDENTIFIER
    ;

stringLiteral
    : STRING_LITERAL
    ;

integerLiteral
    : INTEGER_LITERAL
    ;

// Placeholder for SELECT statement (would reference main parser)
selectStmt
    : SELECT .*? // Simplified - would reference full SELECT grammar
    ;

// Keywords for CREATE MODEL
CREATE : 'CREATE' ;
MODEL : 'MODEL' ;
FROM : 'FROM' ;
TARGET : 'TARGET' ;
FUNCTION : 'FUNCTION' ;
RETURNS : 'RETURNS' ;
SAGEMAKER : 'SAGEMAKER' ;
IAM_ROLE : 'IAM_ROLE' ;
DEFAULT : 'DEFAULT' ;
AUTO : 'AUTO' ;
ON : 'ON' ;
OFF : 'OFF' ;
MODEL_TYPE : 'MODEL_TYPE' ;
PROBLEM_TYPE : 'PROBLEM_TYPE' ;
OBJECTIVE : 'OBJECTIVE' ;
PREPROCESSORS : 'PREPROCESSORS' ;
HYPERPARAMETERS : 'HYPERPARAMETERS' ;
EXCEPT : 'EXCEPT' ;
SETTINGS : 'SETTINGS' ;

// Model types
XGBOOST : 'XGBOOST' ;
MLP : 'MLP' ;
LINEAR_LEARNER : 'LINEAR_LEARNER' ;
KMEANS : 'KMEANS' ;
FORECAST : 'FORECAST' ;

// Problem types
REGRESSION : 'REGRESSION' ;
BINARY_CLASSIFICATION : 'BINARY_CLASSIFICATION' ;
MULTICLASS_CLASSIFICATION : 'MULTICLASS_CLASSIFICATION' ;

// Settings keywords
S3_BUCKET : 'S3_BUCKET' ;
TAGS : 'TAGS' ;
KMS_KEY_ID : 'KMS_KEY_ID' ;
S3_GARBAGE_COLLECT : 'S3_GARBAGE_COLLECT' ;
MAX_CELLS : 'MAX_CELLS' ;
MAX_RUNTIME : 'MAX_RUNTIME' ;
HORIZON : 'HORIZON' ;
FREQUENCY : 'FREQUENCY' ;
PERCENTILES : 'PERCENTILES' ;
MAX_BATCH_ROWS : 'MAX_BATCH_ROWS' ;

// Placeholder for SELECT keyword
SELECT : 'SELECT' ;

// Punctuation
LPAREN : '(' ;
RPAREN : ')' ;
COMMA : ',' ;
DOT : '.' ;
COLON : ':' ;

// Literals (simplified - would use main lexer rules)
IDENTIFIER : [a-zA-Z_][a-zA-Z0-9_]* ;
QUOTED_IDENTIFIER : '"' (~["\r\n])* '"' ;
STRING_LITERAL : '\'' (~['\r\n])* '\'' ;
INTEGER_LITERAL : [0-9]+ ;

// Whitespace and comments
WS : [ \t\r\n]+ -> skip ;
LINE_COMMENT : '--' ~[\r\n]* -> skip ;
BLOCK_COMMENT : '/*' .*? '*/' -> skip ;