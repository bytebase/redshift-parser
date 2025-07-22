-- CREATE PROCEDURE test cases for Amazon Redshift
-- Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_PROCEDURE.html

-- Basic procedure examples

-- Simple procedure with input parameters
CREATE PROCEDURE test_sp1(f1 int, f2 varchar(20)) AS $$ 
DECLARE 
    min_val int; 
BEGIN 
    DROP TABLE IF EXISTS tmp_tbl;
    CREATE TEMP TABLE tmp_tbl(id int);
    INSERT INTO tmp_tbl values (f1),(10001),(10002);
    SELECT INTO min_val MIN(id) FROM tmp_tbl;
    RAISE INFO 'min_val = %, f2 = %', min_val, f2; 
END; 
$$ LANGUAGE plpgsql;

-- Procedure with IN, OUT, INOUT parameters
CREATE PROCEDURE test_sp2(
    f1 IN int, 
    f2 INOUT varchar(256), 
    out_var OUT varchar(256)
) AS $$ 
DECLARE 
    loop_var int; 
BEGIN 
    IF f1 is null OR f2 is null THEN 
        RAISE EXCEPTION 'input cannot be null';
    END IF;
    DROP TABLE IF EXISTS tmp_tbl;
    CREATE TEMP TABLE tmp_tbl(id int);
    FOR loop_var IN 1..f1 LOOP
        INSERT INTO tmp_tbl VALUES (loop_var);
    END LOOP;
    SELECT INTO out_var 'INFO: loop_var = ' || loop_var || ', f2 = ' || f2;
    f2 := 'updated f2';
END; 
$$ LANGUAGE plpgsql;

-- Procedure with parameter mode variations
CREATE PROCEDURE test_modes(
    input_param IN integer,
    output_param OUT varchar(100),
    inout_param INOUT decimal(10,2)
) AS $$
DECLARE
    temp_value decimal(10,2);
BEGIN
    temp_value := inout_param * input_param;
    output_param := 'Calculated value: ' || temp_value::varchar;
    inout_param := temp_value;
END;
$$ LANGUAGE plpgsql;

-- OR REPLACE examples

-- Replace existing procedure
CREATE OR REPLACE PROCEDURE test_sp1(f1 int, f2 varchar(20)) AS $$ 
DECLARE 
    min_val int;
    max_val int; 
BEGIN 
    DROP TABLE IF EXISTS tmp_tbl;
    CREATE TEMP TABLE tmp_tbl(id int);
    INSERT INTO tmp_tbl values (f1),(10001),(10002);
    SELECT INTO min_val, max_val MIN(id), MAX(id) FROM tmp_tbl;
    RAISE INFO 'min_val = %, max_val = %, f2 = %', min_val, max_val, f2; 
END; 
$$ LANGUAGE plpgsql;

-- NONATOMIC procedures

-- NONATOMIC procedure that automatically commits
CREATE PROCEDURE test_nonatomic_sp(input_id int) NONATOMIC AS $$
DECLARE
    rec record;
BEGIN
    -- Each statement auto-commits in NONATOMIC mode
    DROP TABLE IF EXISTS test_table;
    CREATE TABLE test_table(id int);
    INSERT INTO test_table VALUES (input_id);
    
    FOR rec IN SELECT * FROM test_table LOOP
        RAISE INFO 'Processing id: %', rec.id;
    END LOOP;
    
    DROP TABLE test_table;
END;
$$ LANGUAGE plpgsql;

-- NONATOMIC with transaction control
CREATE OR REPLACE PROCEDURE test_transaction_sp(batch_size int) NONATOMIC AS $$
DECLARE
    counter int := 0;
    current_id int;
BEGIN
    DROP TABLE IF EXISTS batch_table;
    CREATE TABLE batch_table(id int, processed boolean default false);
    
    -- Insert test data
    FOR current_id IN 1..batch_size * 3 LOOP
        INSERT INTO batch_table(id) VALUES (current_id);
        counter := counter + 1;
        
        -- Commit every batch_size records
        IF counter % batch_size = 0 THEN
            COMMIT;
            RAISE INFO 'Committed batch of % records', batch_size;
        END IF;
    END LOOP;
    
    COMMIT; -- Final commit
END;
$$ LANGUAGE plpgsql;

-- Security options

-- SECURITY INVOKER procedure (default)
CREATE PROCEDURE test_security_invoker(table_name varchar(100))
SECURITY INVOKER AS $$
BEGIN
    -- Runs with caller's privileges
    EXECUTE 'SELECT COUNT(*) FROM ' || table_name;
    RAISE INFO 'Accessed table: %', table_name;
END;
$$ LANGUAGE plpgsql;

-- SECURITY DEFINER procedure
CREATE PROCEDURE test_security_definer(user_id int)
SECURITY DEFINER AS $$
DECLARE
    user_count int;
BEGIN
    -- Runs with procedure owner's privileges
    SELECT COUNT(*) INTO user_count FROM pg_user WHERE usesysid = user_id;
    RAISE INFO 'User count for ID %: %', user_id, user_count;
END;
$$ LANGUAGE plpgsql;

-- SET configuration parameter examples

-- Procedure with configuration parameter
CREATE PROCEDURE test_config_sp(search_query varchar(100))
SET search_path = public, temp_schema AS $$
BEGIN
    -- search_path is temporarily set for this procedure
    DROP TABLE IF EXISTS search_results;
    CREATE TEMP TABLE search_results(result_text varchar(200));
    INSERT INTO search_results VALUES ('Found: ' || search_query);
    RAISE INFO 'Search completed for: %', search_query;
END;
$$ LANGUAGE plpgsql;

-- Multiple configuration parameters
CREATE PROCEDURE test_multi_config_sp(log_level varchar(10))
SET log_min_messages = info
SET work_mem = '256MB' AS $$
BEGIN
    RAISE INFO 'Procedure started with log level: %', log_level;
    -- Memory and logging settings are temporarily modified
    PERFORM pg_sleep(1);
    RAISE INFO 'Procedure completed';
END;
$$ LANGUAGE plpgsql;

-- Data type examples

-- Procedure with various data types
CREATE PROCEDURE test_datatypes_sp(
    small_num smallint,
    big_num bigint,
    precise_num decimal(10,2),
    float_num real,
    double_num double precision,
    bool_val boolean,
    char_val char(10),
    varchar_val varchar(255),
    date_val date,
    timestamp_val timestamp,
    text_val text
) AS $$
DECLARE
    result_text text;
BEGIN
    result_text := 'Values: ' || small_num || ', ' || big_num || ', ' || precise_num;
    result_text := result_text || ', ' || float_num || ', ' || double_num;
    result_text := result_text || ', ' || bool_val || ', ' || trim(char_val);
    result_text := result_text || ', ' || varchar_val || ', ' || date_val;
    result_text := result_text || ', ' || timestamp_val || ', ' || text_val;
    
    RAISE INFO 'All data types: %', result_text;
END;
$$ LANGUAGE plpgsql;

-- Redshift-specific data types
CREATE PROCEDURE test_redshift_types_sp(
    super_val super,
    geom_val geometry,
    geog_val geography,
    hll_val hllsketch
) AS $$
BEGIN
    RAISE INFO 'Super type length: %', JSON_ARRAY_LENGTH(super_val);
    RAISE INFO 'Geometry area: %', ST_AREA(geom_val);
    RAISE INFO 'Geography provided: %', CASE WHEN geog_val IS NOT NULL THEN 'Yes' ELSE 'No' END;
    RAISE INFO 'HLL cardinality: %', HLL_CARDINALITY(hll_val);
END;
$$ LANGUAGE plpgsql;