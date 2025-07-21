// Redshift COPY command grammar
// This grammar focuses on Redshift-specific COPY syntax which is significantly different from PostgreSQL COPY

copy_stmt
    : COPY qualified_name opt_column_list? FROM copy_data_source copy_authorization copy_format_options? copy_options*
    ;

// Column list specification
opt_column_list
    : '(' columnlist ')'
    ;

// Data sources - Redshift specific
copy_data_source
    : copy_s3_source
    | copy_dynamodb_source
    | copy_emr_source
    | copy_ssh_source
    ;

// S3 data source
copy_s3_source
    : sconst  // S3 path like 's3://bucket/prefix'
    ;

// DynamoDB data source
copy_dynamodb_source
    : sconst  // DynamoDB table like 'dynamodb://TableName'
    ;

// EMR data source
copy_emr_source
    : sconst  // EMR path like 'emr://cluster-id/path'
    ;

// SSH data source
copy_ssh_source
    : sconst  // SSH path
    ;

// Authorization methods
copy_authorization
    : copy_iam_role
    | copy_access_keys
    | copy_credentials
    ;

// IAM Role authorization
copy_iam_role
    : IAM_ROLE ( DEFAULT | sconst )  // 'default' or ARN string
    ;

// Access key authorization (not recommended)
copy_access_keys
    : ACCESS_KEY_ID sconst SECRET_ACCESS_KEY sconst copy_session_token?
    ;

copy_session_token
    : SESSION_TOKEN sconst
    ;

// Credentials clause
copy_credentials
    : CREDENTIALS sconst
    ;

// Format options
copy_format_options
    : copy_format_clause
    | copy_delimiter_clause
    | copy_fixedwidth_clause
    ;

// FORMAT clause
copy_format_clause
    : FORMAT AS? copy_format_type
    ;

copy_format_type
    : CSV csv_options?
    | JSON ( sconst | AUTO )?
    | AVRO ( sconst | AUTO )?
    | PARQUET
    | ORC
    | RCFILE
    ;

// CSV specific options
csv_options
    : QUOTE AS? sconst
    ;

// Delimiter clause
copy_delimiter_clause
    : DELIMITER AS? sconst
    ;

// Fixed width clause
copy_fixedwidth_clause
    : FIXEDWIDTH AS? sconst
    ;

// All other COPY options
copy_options
    : copy_compression_option
    | copy_manifest_option
    | copy_encrypted_option
    | copy_region_option
    | copy_encoding_option
    | copy_error_handling_option
    | copy_data_conversion_option
    | copy_load_operation_option
    ;

// Compression options
copy_compression_option
    : BZIP2
    | GZIP
    | LZOP
    | ZSTD
    ;

// Manifest option
copy_manifest_option
    : MANIFEST VERBOSE?
    ;

// Encrypted option
copy_encrypted_option
    : ENCRYPTED MASTER_SYMMETRIC_KEY?
    ;

// Region option
copy_region_option
    : REGION AS? sconst
    ;

// Encoding option
copy_encoding_option
    : ENCODING AS? encoding_name
    ;

encoding_name
    : UTF8
    | UTF16
    | UTF16BE
    | UTF16LE
    | sconst
    ;

// Error handling options
copy_error_handling_option
    : MAXERROR AS? ( iconst | sconst )
    | IGNOREALLERRORS
    | NOLOAD
    ;

// Data conversion options
copy_data_conversion_option
    : ACCEPTINVCHARS AS? sconst?
    | ACCEPTANYDATE
    | BLANKSASNULL
    | DATEFORMAT AS? ( sconst | AUTO )
    | EMPTYASNULL
    | ESCAPE
    | EXPLICIT_IDS
    | FILLRECORD
    | IGNOREBLANKLINES
    | IGNOREHEADER AS? iconst
    | NULL AS sconst
    | REMOVEQUOTES
    | ROUNDEC
    | TIMEFORMAT AS? ( sconst | AUTO | EPOCHSECS | EPOCHMILLISECS )
    | TRIMBLANKS
    ;

// Load operation options
copy_load_operation_option
    : COMPROWS iconst
    | COMPUPDATE ( PRESET | ON | OFF | TRUE | FALSE )
    | STATUPDATE ( ON | OFF | TRUE | FALSE )
    | copy_readratio_option
    ;

// DynamoDB specific readratio option
copy_readratio_option
    : READRATIO iconst
    ;

// Additional keywords for Redshift COPY
// Note: These should be added to the lexer
COPY: 'COPY';
IAM_ROLE: 'IAM_ROLE';
ACCESS_KEY_ID: 'ACCESS_KEY_ID';
SECRET_ACCESS_KEY: 'SECRET_ACCESS_KEY';
SESSION_TOKEN: 'SESSION_TOKEN';
CREDENTIALS: 'CREDENTIALS';
FORMAT: 'FORMAT';
CSV: 'CSV';
JSON: 'JSON';
AVRO: 'AVRO';
PARQUET: 'PARQUET';
ORC: 'ORC';
RCFILE: 'RCFILE';
QUOTE: 'QUOTE';
DELIMITER: 'DELIMITER';
FIXEDWIDTH: 'FIXEDWIDTH';
BZIP2: 'BZIP2';
GZIP: 'GZIP';
LZOP: 'LZOP';
ZSTD: 'ZSTD';
MANIFEST: 'MANIFEST';
VERBOSE: 'VERBOSE';
ENCRYPTED: 'ENCRYPTED';
MASTER_SYMMETRIC_KEY: 'MASTER_SYMMETRIC_KEY';
REGION: 'REGION';
ENCODING: 'ENCODING';
UTF8: 'UTF8';
UTF16: 'UTF16';
UTF16BE: 'UTF16BE';
UTF16LE: 'UTF16LE';
MAXERROR: 'MAXERROR';
IGNOREALLERRORS: 'IGNOREALLERRORS';
NOLOAD: 'NOLOAD';
ACCEPTINVCHARS: 'ACCEPTINVCHARS';
ACCEPTANYDATE: 'ACCEPTANYDATE';
BLANKSASNULL: 'BLANKSASNULL';
DATEFORMAT: 'DATEFORMAT';
EMPTYASNULL: 'EMPTYASNULL';
ESCAPE: 'ESCAPE';
EXPLICIT_IDS: 'EXPLICIT_IDS';
FILLRECORD: 'FILLRECORD';
IGNOREBLANKLINES: 'IGNOREBLANKLINES';
IGNOREHEADER: 'IGNOREHEADER';
NULL: 'NULL';
REMOVEQUOTES: 'REMOVEQUOTES';
ROUNDEC: 'ROUNDEC';
TIMEFORMAT: 'TIMEFORMAT';
EPOCHSECS: 'EPOCHSECS';
EPOCHMILLISECS: 'EPOCHMILLISECS';
TRIMBLANKS: 'TRIMBLANKS';
COMPROWS: 'COMPROWS';
COMPUPDATE: 'COMPUPDATE';
STATUPDATE: 'STATUPDATE';
READRATIO: 'READRATIO';
PRESET: 'PRESET';
AUTO: 'AUTO';