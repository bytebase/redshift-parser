// CREATE MODEL statement - Redshift ML command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_MODEL.html
createmodelstmt
    : CREATE MODEL model_name=qualified_name
      FROM createmodelfromclause
      (TARGET target_column=colid)?
      FUNCTION function_name=colid ('(' datatypelist ')')?
      (RETURNS typename)?
      (SAGEMAKER sagemakerspec)?
      IAM_ROLE iamrolespec
      (AUTO (ON | OFF))?
      (MODEL_TYPE modeltypespec)?
      (PROBLEM_TYPE problemtypespec)?
      (OBJECTIVE objectivespec)?
      (PREPROCESSORS sconst)?
      (HYPERPARAMETERS hyperparametersspec)?
      (SETTINGS '(' settingsclause ')')?
    ;

// FROM clause options
createmodelfromclause
    : qualified_name                         // table_name
    | '(' selectstmt ')'                     // (select_statement)
    | sconst                                 // 'job_name'
    ;

// IAM Role specification
iamrolespec
    : DEFAULT
    | sconst  // 'arn:aws:iam::<account-id>:role/<role-name>'
    ;

// SageMaker endpoint specification
sagemakerspec
    : sconst (':' sconst)?  // 'endpoint_name':'model_name'
    ;

// Model type specification
modeltypespec
    : XGBOOST
    | MLP
    | LINEAR_LEARNER
    | KMEANS
    | FORECAST
    ;

// Problem type specification
problemtypespec
    : '(' problemtype ')'
    ;

problemtype
    : REGRESSION
    | BINARY_CLASSIFICATION
    | MULTICLASS_CLASSIFICATION
    ;

// Objective specification
objectivespec
    : '(' sconst ')'  // 'MSE', 'Accuracy', etc.
    ;

// Hyperparameters specification
hyperparametersspec
    : DEFAULT
    | DEFAULT EXCEPT '(' hyperparameterslist ')'
    ;

hyperparameterslist
    : hyperparameteritem (',' hyperparameteritem)*
    ;

hyperparameteritem
    : colid sconst
    ;

// Settings clause
settingsclause
    : settingsitem (',' settingsitem)*
    ;

settingsitem
    : S3_BUCKET sconst
    | TAGS sconst
    | KMS_KEY_ID sconst
    | S3_GARBAGE_COLLECT (ON | OFF)
    | MAX_CELLS iconst
    | MAX_RUNTIME iconst
    | HORIZON iconst
    | FREQUENCY iconst
    | PERCENTILES sconst
    | MAX_BATCH_ROWS iconst
    ;

// Data type list for function parameters
datatypelist
    : typename (',' typename)*
    ;

// Tokens needed in RedshiftLexer.g4:
// MODEL, TARGET, SAGEMAKER, IAM_ROLE, AUTO, MODEL_TYPE, PROBLEM_TYPE,
// OBJECTIVE, PREPROCESSORS, HYPERPARAMETERS, XGBOOST, MLP, LINEAR_LEARNER,
// KMEANS, FORECAST, REGRESSION, BINARY_CLASSIFICATION, MULTICLASS_CLASSIFICATION,
// S3_BUCKET, TAGS, KMS_KEY_ID, S3_GARBAGE_COLLECT, MAX_CELLS, MAX_RUNTIME,
// HORIZON, FREQUENCY, PERCENTILES, MAX_BATCH_ROWS