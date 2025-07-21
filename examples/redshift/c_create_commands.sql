-- Test cases for CREATE commands starting with C

-- ====================================
-- CREATE EXTERNAL FUNCTION
-- ====================================

-- Basic external function
CREATE EXTERNAL FUNCTION public.f_distance (x1 float, y1 float, x2 float, y2 float)
RETURNS float
STABLE
LAMBDA 'lambda_distance'
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftLambdaRole';

-- External function with no arguments
CREATE EXTERNAL FUNCTION get_current_time()
RETURNS timestamp
IMMUTABLE
LAMBDA 'lambda_get_time'
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftLambdaRole';

-- External function with multiple data types
CREATE EXTERNAL FUNCTION process_json(input_json varchar(max), key_name varchar(256))
RETURNS varchar(max)
STABLE
LAMBDA 'lambda_json_processor'
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftLambdaRole';

-- External function with OR REPLACE
CREATE OR REPLACE EXTERNAL FUNCTION calculate_score(a integer, b integer, c integer)
RETURNS decimal(10,2)
STABLE
LAMBDA 'lambda_score_calculator'
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftLambdaRole';

-- ====================================
-- CREATE EXTERNAL MODEL
-- ====================================

-- Basic external model from S3
CREATE EXTERNAL MODEL customer_churn_model
FROM 's3://mybucket/models/customer_churn.tar.gz'
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftMLRole';

-- External model with function name
CREATE EXTERNAL MODEL sales_forecast_model
FROM 's3://mybucket/models/sales_forecast.tar.gz'
FUNCTION_NAME predict_sales
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftMLRole';

-- External model with settings
CREATE EXTERNAL MODEL fraud_detection_model
FROM 's3://mybucket/models/fraud_detection.tar.gz'
FUNCTION_NAME detect_fraud
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftMLRole'
SETTINGS (
    MAX_BATCH_SIZE '1000',
    MAX_PAYLOAD_IN_MB '5'
);

-- ====================================
-- CREATE EXTERNAL SCHEMA
-- ====================================

-- External schema from AWS Glue Data Catalog
CREATE EXTERNAL SCHEMA spectrum_schema
FROM DATA_CATALOG
DATABASE 'spectrum_db'
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftSpectrumRole'
CREATE EXTERNAL DATABASE IF NOT EXISTS;

-- External schema from Hive metastore
CREATE EXTERNAL SCHEMA hive_schema
FROM HIVE METASTORE
DATABASE 'hive_db'
URI 'ec2-123-456-789-012.compute-1.amazonaws.com'
PORT 9083
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftSpectrumRole';

-- External schema from PostgreSQL
CREATE EXTERNAL SCHEMA postgres_schema
FROM POSTGRES
DATABASE 'mypostgresdb'
URI 'hostname.region.rds.amazonaws.com'
PORT 5432
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftRole'
SECRET_ARN 'arn:aws:secretsmanager:region:123456789012:secret:postgres-secret';

-- External schema from MySQL
CREATE EXTERNAL SCHEMA mysql_schema
FROM MYSQL  
DATABASE 'mysqldb'
URI 'hostname.region.rds.amazonaws.com'
PORT 3306
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftRole'
SECRET_ARN 'arn:aws:secretsmanager:region:123456789012:secret:mysql-secret';

-- External schema from Redshift
CREATE EXTERNAL SCHEMA redshift_schema
FROM REDSHIFT
DATABASE 'remote_db'
REGION 'us-west-2'
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftRole';

-- External schema with IF NOT EXISTS
CREATE EXTERNAL SCHEMA IF NOT EXISTS spectrum_schema2
FROM DATA_CATALOG
DATABASE 'spectrum_db2'
REGION 'us-east-1'
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftSpectrumRole';

-- External schema from Kinesis
CREATE EXTERNAL SCHEMA kinesis_schema
FROM KINESIS
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftKinesisRole';

-- ====================================
-- CREATE EXTERNAL VIEW
-- ====================================

-- Basic external view
CREATE EXTERNAL VIEW spectrum_view AS
SELECT col1, col2, col3
FROM spectrum_schema.external_table
WHERE col1 > 100;

-- External view with column list
CREATE EXTERNAL VIEW sales_summary_view (region, total_sales, avg_price) AS
SELECT region, SUM(sales_amount), AVG(unit_price)
FROM spectrum_schema.sales_data
GROUP BY region;

-- External view with OR REPLACE
CREATE OR REPLACE EXTERNAL VIEW customer_360_view AS
SELECT c.customer_id, c.name, o.order_count, p.total_spent
FROM spectrum_schema.customers c
JOIN spectrum_schema.order_summary o ON c.customer_id = o.customer_id
JOIN spectrum_schema.payment_summary p ON c.customer_id = p.customer_id;

-- ====================================
-- CREATE IDENTITY PROVIDER
-- ====================================

-- Azure identity provider
CREATE IDENTITY PROVIDER azure_idp
TYPE 'Azure'
NAMESPACE 'aad:myazuretenant.onmicrosoft.com';

-- Azure identity provider with parameters
CREATE IDENTITY PROVIDER azure_idp_with_params
TYPE 'Azure'
NAMESPACE 'aad:mycompany.onmicrosoft.com'
PARAMETERS (
    application_id 'app123456-7890-1234-5678-901234567890',
    client_secret 'my_client_secret',
    issuer 'https://login.microsoftonline.com/tenant-id/v2.0'
);

-- Custom identity provider
CREATE IDENTITY PROVIDER custom_saml_idp
TYPE 'Custom'
NAMESPACE 'https://idp.mycompany.com'
PARAMETERS (
    login_url 'https://idp.mycompany.com/sso/saml',
    logout_url 'https://idp.mycompany.com/sso/logout',
    certificate 'MIIDdzCCAl+gAwIBAgIE...'
);

-- ====================================
-- CREATE LIBRARY
-- ====================================

-- Basic Python library
CREATE LIBRARY pandas_lib
LANGUAGE plpython3u
FROM 's3://mybucket/python-libs/pandas-layer.zip';

-- Library with credentials
CREATE LIBRARY numpy_lib
LANGUAGE plpython3u
FROM 's3://mybucket/python-libs/numpy-layer.zip'
WITH CREDENTIALS AS 'aws_access_key_id=AKIAIOSFODNN7EXAMPLE;aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY';

-- Library with region
CREATE LIBRARY scipy_lib
LANGUAGE plpython3u
FROM 's3://mybucket/python-libs/scipy-layer.zip'
REGION AS 'us-west-2';

-- Library with OR REPLACE
CREATE OR REPLACE LIBRARY ml_utils_lib
LANGUAGE plpython3u
FROM 's3://mybucket/python-libs/ml-utils.zip'
CREDENTIALS AS 'aws_access_key_id=AKIAIOSFODNN7EXAMPLE;aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
REGION 'us-east-1';

-- ====================================
-- CREATE MASKING POLICY
-- ====================================

-- Basic masking policy for SSN
CREATE MASKING POLICY mask_ssn
WITH (ssn varchar(11))
AS (
    CASE
        WHEN current_user = 'admin' THEN ssn
        ELSE 'XXX-XX-' || SUBSTRING(ssn, 8, 4)
    END
);

-- Masking policy for credit card with role-based access
CREATE MASKING POLICY mask_credit_card
WITH (cc_number varchar(19))
AS (
    CASE
        WHEN current_user IN ('finance_admin', 'compliance_officer') THEN cc_number
        WHEN current_user_has_role('finance_read') THEN 'XXXX-XXXX-XXXX-' || SUBSTRING(cc_number, 16, 4)
        ELSE 'XXXX-XXXX-XXXX-XXXX'
    END
);

-- Masking policy with USING clause
CREATE MASKING POLICY mask_salary
WITH (salary decimal(10,2))
AS (
    CASE
        WHEN is_manager = true AND department = user_department THEN salary
        WHEN is_hr = true THEN salary
        ELSE 0
    END
)
USING (is_manager boolean, department varchar(50), user_department varchar(50), is_hr boolean);

-- Complex masking policy for email
CREATE MASKING POLICY mask_email
WITH (email varchar(255))
AS (
    CASE
        WHEN current_user = 'data_analyst' THEN 
            SUBSTRING(email, 1, 3) || '***@' || SPLIT_PART(email, '@', 2)
        WHEN pg_has_role(current_user, 'marketing_team', 'MEMBER') THEN
            email
        ELSE 
            'hidden@example.com'
    END
);

-- ====================================
-- CREATE MODEL
-- ====================================

-- Basic AUTO model
CREATE MODEL customer_churn_model
FROM (
    SELECT age, gender, tenure, monthly_charges, total_charges, churn
    FROM customer_data
    WHERE record_date >= '2023-01-01'
)
TARGET churn
IAM_ROLE DEFAULT
AUTO ON;

-- Model with specific algorithm
CREATE MODEL sales_forecast_model
FROM training_data.sales_history
TARGET sales_amount
MODEL_TYPE XGBoost
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftMLRole';

-- Model with problem type
CREATE MODEL customer_segmentation
FROM (
    SELECT customer_id, age, income, purchase_frequency, avg_order_value, segment
    FROM customer_features
)
TARGET segment
PROBLEM_TYPE MULTICLASS_CLASSIFICATION
IAM_ROLE DEFAULT;

-- Model with hyperparameters
CREATE MODEL fraud_detection
FROM transactions_table
TARGET is_fraud
MODEL_TYPE XGBoost
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftMLRole'
HYPERPARAMETERS AUTO PRESET STANDARD;

-- Model with options
CREATE MODEL product_recommendation
FROM user_interactions
TARGET will_purchase
MODEL_TYPE MLP
IAM_ROLE DEFAULT
OPTIONS (
    S3_BUCKET 'my-ml-bucket',
    S3_GARBAGE_COLLECT OFF,
    MAX_RUNTIME 3600
);

-- Model with preprocessors
CREATE MODEL price_prediction
FROM products_data
TARGET price
MODEL_TYPE LINEAR_LEARNER
IAM_ROLE DEFAULT
PREPROCESSORS 'onehotencoding_top_10';

-- Bring your own model (BYOM)
CREATE MODEL pretrained_sentiment_model
FUNCTION predict_sentiment(review_text varchar(max))
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftMLRole'
FROM 's3://mybucket/models/sentiment-analysis-model.tar.gz';

-- Model from another model (model chaining)
CREATE MODEL enhanced_churn_model
FROM base_churn_model
IAM_ROLE DEFAULT
AUTO OFF;

-- ====================================
-- CREATE RLS POLICY
-- ====================================

-- Basic RLS policy
CREATE RLS POLICY sales_region_policy
AS (region = current_user_region());

-- RLS policy with grantors
CREATE RLS POLICY department_access_policy
WITH (hr_admin, finance_admin)
AS (department_id IN (
    SELECT department_id 
    FROM user_departments 
    WHERE user_name = current_user
));

-- RLS policy for specific operation
CREATE RLS POLICY customer_data_policy
AS (customer_id = current_user_customer_id())
FOR SELECT
TO data_analysts;

-- RLS policy for multiple operations
CREATE RLS POLICY employee_data_policy
WITH (hr_manager)
AS (
    employee_id = current_user_employee_id()
    OR 
    manager_id = current_user_employee_id()
)
FOR ALL
TO PUBLIC;

-- Complex RLS policy with role list
CREATE RLS POLICY financial_data_policy
WITH (cfo, finance_director)
AS (
    CASE
        WHEN current_user_has_role('executive') THEN true
        WHEN current_user_has_role('finance_team') AND fiscal_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 2 THEN true
        ELSE false
    END
)
FOR SELECT
TO finance_analysts, finance_managers, auditors;

-- RLS policy for DELETE operation
CREATE RLS POLICY delete_own_records_policy
AS (created_by = current_user)
FOR DELETE
TO registered_users;

-- RLS policy for UPDATE operation
CREATE RLS POLICY update_own_profile_policy
AS (user_id = current_user_id() AND is_active = true)
FOR UPDATE
TO all_users;