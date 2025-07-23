-- REVOKE command test cases for Amazon Redshift
-- Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_REVOKE.html

-- Basic table privileges
REVOKE SELECT ON TABLE sales FROM user1;
REVOKE INSERT ON TABLE sales FROM GROUP guests;
REVOKE UPDATE ON TABLE customers FROM ROLE analyst_role;
REVOKE DELETE ON products FROM PUBLIC;
REVOKE DROP ON TABLE inventory FROM user2;
REVOKE REFERENCES ON TABLE employees FROM GROUP hr_group;
REVOKE ALTER ON orders FROM ROLE admin_role;
REVOKE TRUNCATE ON TABLE temp_data FROM user3;

-- Multiple privileges in one statement
REVOKE SELECT, INSERT, UPDATE ON TABLE transactions FROM user4;
REVOKE INSERT, UPDATE ON TABLE public.products FROM GROUP data_loaders;
REVOKE SELECT, UPDATE, DELETE ON customers FROM ROLE reporting_role;
REVOKE DROP, ALTER, TRUNCATE ON TABLE staging_data FROM GROUP dev_group;

-- ALL privileges
REVOKE ALL ON TABLE sales FROM user5;
REVOKE ALL PRIVILEGES ON TABLE customers FROM GROUP sales_group;
REVOKE ALL ON products FROM PUBLIC;

-- Column-level permissions
REVOKE SELECT (cust_name, cust_phone) ON TABLE cust_profile FROM user1;
REVOKE UPDATE (salary, bonus) ON TABLE employees FROM GROUP hr_group;
REVOKE SELECT (ssn, credit_card) ON TABLE sensitive_data FROM ROLE analyst_role;
REVOKE ALL (col1, col2, col3) ON TABLE test_table FROM user6;
REVOKE ALL PRIVILEGES (column_a, column_b) ON TABLE data_table FROM GROUP readers;

-- All tables in schema
REVOKE SELECT ON ALL TABLES IN SCHEMA qa_tickit FROM fred;
REVOKE INSERT, UPDATE ON ALL TABLES IN SCHEMA staging FROM GROUP loaders;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM ROLE guest_role;
REVOKE DELETE ON ALL TABLES IN SCHEMA analytics FROM user7;

-- Database privileges
REVOKE CREATE ON DATABASE sales_db FROM user8;
REVOKE TEMPORARY ON DATABASE analytics_db FROM GROUP temp_users;
REVOKE TEMP ON DATABASE staging_db FROM ROLE developer_role;
REVOKE ALTER ON DATABASE production_db FROM user9;
REVOKE DROP ON DATABASE test_db FROM GROUP admin_group;
REVOKE USAGE ON DATABASE reporting_db FROM PUBLIC;
REVOKE ALL ON DATABASE ecommerce_db FROM alice;
REVOKE ALL PRIVILEGES ON DATABASE warehouse_db FROM ROLE analyst_role;

-- Multiple database privileges
REVOKE CREATE, TEMPORARY ON DATABASE dev_db FROM user10;
REVOKE ALTER, DROP ON DATABASE test_db FROM GROUP developers;
REVOKE CREATE, USAGE, TEMP ON DATABASE staging_db FROM ROLE junior_dev;

-- Schema privileges
REVOKE CREATE ON SCHEMA sales_schema FROM user11;
REVOKE USAGE ON SCHEMA reporting_schema FROM GROUP viewers;
REVOKE ALTER ON SCHEMA analytics_schema FROM ROLE data_scientist;
REVOKE DROP ON SCHEMA temp_schema FROM user12;
REVOKE ALL ON SCHEMA public FROM contractor_01;
REVOKE ALL PRIVILEGES ON SCHEMA private_schema FROM GROUP external_users;

-- Multiple schema privileges
REVOKE CREATE, USAGE ON SCHEMA dev_schema FROM user13;
REVOKE ALTER, DROP ON SCHEMA test_schema FROM GROUP testers;
REVOKE CREATE, USAGE, ALTER, DROP ON SCHEMA sandbox FROM ROLE intern_role;

-- Function and procedure privileges
REVOKE EXECUTE ON FUNCTION calculate_total() FROM user14;
REVOKE EXECUTE ON FUNCTION get_customer_data(integer) FROM GROUP analysts;
REVOKE EXECUTE ON FUNCTION process_order(varchar, date) FROM ROLE app_role;
REVOKE EXECUTE ON PROCEDURE update_inventory() FROM user15;
REVOKE EXECUTE ON PROCEDURE generate_report(date, date) FROM GROUP reporters;
REVOKE ALL ON FUNCTION complex_calc(numeric, numeric) FROM PUBLIC;

-- All functions/procedures in schema
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA utils FROM user16;
REVOKE EXECUTE ON ALL PROCEDURES IN SCHEMA batch FROM GROUP schedulers;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA analytics FROM ROLE data_analyst;
REVOKE ALL ON ALL PROCEDURES IN SCHEMA maintenance FROM user17;
REVOKE EXECUTE FOR FUNCTIONS IN SCHEMA Sales_schema FROM bob;
REVOKE EXECUTE FOR PROCEDURES IN SCHEMA admin_schema FROM GROUP operators;

-- Language privileges
REVOKE USAGE ON LANGUAGE plpythonu FROM user18;
REVOKE USAGE ON LANGUAGE plpgsql FROM GROUP developers;
REVOKE USAGE ON LANGUAGE sql FROM ROLE junior_developer;

-- Datashare privileges
REVOKE ALTER ON DATASHARE sales_share FROM user19;
REVOKE SHARE ON DATASHARE marketing_data FROM GROUP external_partners;
REVOKE USAGE ON DATASHARE analytics_share FROM ROLE consumer_role;
REVOKE ALTER, SHARE ON DATASHARE prod_share FROM user20;
REVOKE USAGE ON DATASHARE consumer_share FROM ACCOUNT '123456789012';
REVOKE USAGE ON DATASHARE producer_share FROM NAMESPACE 'a1b2c3d4-5678-90ef-ghij-klmnopqrstuv';

-- Role privileges
REVOKE ROLE analyst_role FROM user21;
REVOKE ROLE admin_role FROM user22;
REVOKE ROLE developer_role FROM ROLE junior_developer;
REVOKE ROLE sample_role2 FROM user1;

-- Model privileges
REVOKE EXECUTE ON MODEL customer_churn_model FROM user23;
REVOKE EXECUTE ON MODEL sales_forecast_model FROM GROUP data_scientists;
REVOKE ALL ON MODEL recommendation_model FROM ROLE ml_engineer;
REVOKE CREATE MODEL FROM user24;
REVOKE CREATE MODEL FROM GROUP ml_developers;
REVOKE CREATE MODEL FROM ROLE junior_scientist;

-- REVOKE with CASCADE option
REVOKE ALL ON SCHEMA public FROM USER contractor_01 CASCADE;
REVOKE SELECT ON TABLE sales FROM user25 CASCADE;
REVOKE CREATE ON DATABASE dev_db FROM GROUP interns CASCADE;
REVOKE EXECUTE ON FUNCTION calculate_metrics() FROM user26 CASCADE;
REVOKE ALL PRIVILEGES ON TABLE orders FROM ROLE temp_role CASCADE;

-- REVOKE with RESTRICT option
REVOKE UPDATE ON TABLE inventory FROM user27 RESTRICT;
REVOKE DROP ON SCHEMA temp_schema FROM GROUP cleaners RESTRICT;
REVOKE ALTER ON DATABASE prod_db FROM user28 RESTRICT;
REVOKE EXECUTE ON PROCEDURE daily_cleanup() FROM ROLE maintenance_role RESTRICT;
REVOKE ALL ON TABLE sensitive_data FROM PUBLIC RESTRICT;

-- REVOKE GRANT OPTION FOR
REVOKE GRANT OPTION FOR SELECT ON TABLE customers FROM user29;
REVOKE GRANT OPTION FOR INSERT, UPDATE ON TABLE products FROM GROUP managers;
REVOKE GRANT OPTION FOR ALL ON TABLE sales FROM ROLE lead_analyst;
REVOKE GRANT OPTION FOR CREATE ON DATABASE test_db FROM user30;
REVOKE GRANT OPTION FOR USAGE ON SCHEMA reporting FROM GROUP senior_analysts;
REVOKE GRANT OPTION FOR EXECUTE ON FUNCTION aggregate_data() FROM user31;
REVOKE GRANT OPTION FOR EXECUTE ON MODEL prediction_model FROM ROLE senior_scientist;
REVOKE GRANT OPTION SELECT FOR TABLES IN DATABASE Sales_db FROM alice;

-- REVOKE GRANT OPTION FOR with CASCADE/RESTRICT
REVOKE GRANT OPTION FOR DELETE ON TABLE archives FROM user32 CASCADE;
REVOKE GRANT OPTION FOR ALTER ON SCHEMA legacy FROM GROUP admins RESTRICT;
REVOKE GRANT OPTION FOR DROP ON DATABASE old_db FROM user33 CASCADE;
REVOKE GRANT OPTION FOR ALL PRIVILEGES ON TABLE logs FROM ROLE senior_admin RESTRICT;

-- REVOKE ADMIN OPTION FOR role
REVOKE ADMIN OPTION FOR ROLE sample_role2 FROM user1;
REVOKE ADMIN OPTION FOR ROLE team_lead FROM user34;
REVOKE ADMIN OPTION FOR ROLE department_head FROM user35;

-- Complex multi-privilege scenarios
REVOKE SELECT, INSERT, UPDATE, DELETE, DROP, ALTER ON TABLE critical_data FROM PUBLIC CASCADE;
REVOKE CREATE, USAGE, ALTER, DROP ON SCHEMA protected FROM GROUP external_users RESTRICT;
REVOKE ALL PRIVILEGES ON DATABASE production FROM ROLE contractor CASCADE;
REVOKE GRANT OPTION FOR ALL ON ALL TABLES IN SCHEMA finance FROM user36 CASCADE;

-- Quoted identifiers
REVOKE SELECT ON TABLE "Sales Data" FROM "user-name";
REVOKE UPDATE ON "Customer Table" FROM GROUP "sales-group";
REVOKE EXECUTE ON FUNCTION "Calculate Total"(integer, integer) FROM ROLE "analyst-role";
REVOKE CREATE ON SCHEMA "Finance Schema" FROM "user@domain";
REVOKE ALL ON DATABASE "Production DB" FROM GROUP "external-users";

-- Mixed case identifiers
REVOKE INSERT ON TABLE SalesData FROM UserName;
REVOKE DELETE ON CustomerTable FROM GROUP SalesGroup;
REVOKE ALTER ON SCHEMA FinanceSchema FROM ROLE AnalystRole;
REVOKE DROP ON DATABASE ProductionDB FROM MixedCaseUser;

-- Numeric account and namespace identifiers
REVOKE USAGE ON DATASHARE data_share FROM ACCOUNT '987654321098';
REVOKE SHARE ON DATASHARE analytics_share FROM NAMESPACE 'zyxw9876-5432-10fe-dcba-9876543210zy';
REVOKE ALTER ON DATASHARE prod_share FROM ACCOUNT '111222333444', NAMESPACE 'abcd1234-5678-90ef-ghij-klmnopqrstuv';

-- Edge cases and special scenarios
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM PUBLIC CASCADE;
REVOKE GRANT OPTION FOR ALL PRIVILEGES ON DATABASE main_db FROM GROUP power_users RESTRICT;
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA utils FROM ROLE function_executor CASCADE;
REVOKE ADMIN OPTION FOR ROLE super_admin FROM user37;
REVOKE CREATE MODEL FROM PUBLIC;

-- Schema-qualified object names
REVOKE SELECT ON TABLE public.customers FROM user38;
REVOKE INSERT ON sales.transactions FROM GROUP sales_team;
REVOKE UPDATE ON analytics.fact_sales FROM ROLE reporting;
REVOKE EXECUTE ON FUNCTION utils.calculate_tax(numeric) FROM user39;
REVOKE EXECUTE ON PROCEDURE maintenance.cleanup_old_data() FROM GROUP ops_team;

-- ALTER DEFAULT PRIVILEGES combination (for reference, showing related usage)
-- Note: This is mentioned in the documentation as a related command
-- ALTER DEFAULT PRIVILEGES FOR USER app_owner IN SCHEMA public REVOKE SELECT ON TABLES FROM PUBLIC;