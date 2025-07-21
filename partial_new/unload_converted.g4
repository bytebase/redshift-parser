// UNLOAD statement - Redshift-specific command for exporting data to S3
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_UNLOAD.html
unloadstmt
    : UNLOAD '(' selectstmt ')' TO sconst iamroleclause unloadoptions*
    ;

// IAM role specification
iamroleclause
    : IAM_ROLE (DEFAULT | sconst)
    ;

// UNLOAD options
unloadoptions
    : formatoption
    | partitionbyoption
    | manifestoption
    | headeroption
    | delimiteroption
    | fixedwidthoption
    | encryptedoption
    | kmskeyoption
    | compressionoption
    | addquotesoption
    | nullasoption
    | escapeoption
    | allowoverwriteoption
    | cleanpathoption
    | paralleloption
    | maxfilesizeoption
    | rowgroupsizeoption
    | regionoption
    | extensionoption
    ;

// FORMAT option
formatoption
    : FORMAT (CSV | PARQUET | JSON)
    ;

// PARTITION BY option
partitionbyoption
    : PARTITION BY '(' columnlist ')' INCLUDE?
    ;

// MANIFEST option
manifestoption
    : MANIFEST VERBOSE?
    ;

// HEADER option
headeroption
    : HEADER
    ;

// DELIMITER option
delimiteroption
    : DELIMITER AS? sconst
    ;

// FIXEDWIDTH option
fixedwidthoption
    : FIXEDWIDTH sconst
    ;

// ENCRYPTED option
encryptedoption
    : ENCRYPTED AUTO?
    ;

// KMS_KEY_ID option
kmskeyoption
    : KMS_KEY_ID sconst
    ;

// Compression options
compressionoption
    : BZIP2
    | GZIP
    | ZSTD
    ;

// ADDQUOTES option
addquotesoption
    : ADDQUOTES
    ;

// NULL AS option
nullasoption
    : NULL AS sconst
    ;

// ESCAPE option
escapeoption
    : ESCAPE
    ;

// ALLOWOVERWRITE option
allowoverwriteoption
    : ALLOWOVERWRITE
    ;

// CLEANPATH option
cleanpathoption
    : CLEANPATH
    ;

// PARALLEL option
paralleloption
    : PARALLEL (ON | OFF)
    ;

// MAXFILESIZE option
maxfilesizeoption
    : MAXFILESIZE AS? iconst sizeunit?
    ;

// ROWGROUPSIZE option (for Parquet format)
rowgroupsizeoption
    : ROWGROUPSIZE AS? iconst sizeunit?
    ;

// Size units
sizeunit
    : MB
    | GB
    ;

// REGION option
regionoption
    : REGION AS? sconst
    ;

// EXTENSION option
extensionoption
    : EXTENSION sconst
    ;

// Column list for PARTITION BY
columnlist
    : colid (',' colid)*
    ;