// UNLOAD command grammar for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_UNLOAD.html

grammar partial;

// Main UNLOAD statement
unloadStatement
    : UNLOAD '(' selectStatement ')' TO stringLiteral iamRoleClause unloadOptions*
    ;

// IAM role specification
iamRoleClause
    : IAM_ROLE (DEFAULT | stringLiteral)
    ;

// UNLOAD options
unloadOptions
    : formatOption
    | partitionByOption
    | manifestOption
    | headerOption
    | delimiterOption
    | fixedwidthOption
    | encryptedOption
    | kmsKeyOption
    | compressionOption
    | addquotesOption
    | nullAsOption
    | escapeOption
    | allowoverwriteOption
    | cleanpathOption
    | parallelOption
    | maxfilesizeOption
    | rowgroupsizeOption
    | regionOption
    | extensionOption
    ;

// FORMAT option
formatOption
    : FORMAT (CSV | PARQUET | JSON)
    ;

// PARTITION BY option
partitionByOption
    : PARTITION BY '(' columnList ')' INCLUDE?
    ;

// MANIFEST option
manifestOption
    : MANIFEST VERBOSE?
    ;

// HEADER option
headerOption
    : HEADER
    ;

// DELIMITER option
delimiterOption
    : DELIMITER AS? stringLiteral
    ;

// FIXEDWIDTH option
fixedwidthOption
    : FIXEDWIDTH stringLiteral
    ;

// ENCRYPTED option
encryptedOption
    : ENCRYPTED AUTO?
    ;

// KMS_KEY_ID option
kmsKeyOption
    : KMS_KEY_ID stringLiteral
    ;

// Compression options
compressionOption
    : BZIP2
    | GZIP
    | ZSTD
    ;

// ADDQUOTES option
addquotesOption
    : ADDQUOTES
    ;

// NULL AS option
nullAsOption
    : NULL AS stringLiteral
    ;

// ESCAPE option
escapeOption
    : ESCAPE
    ;

// ALLOWOVERWRITE option
allowoverwriteOption
    : ALLOWOVERWRITE
    ;

// CLEANPATH option
cleanpathOption
    : CLEANPATH
    ;

// PARALLEL option
parallelOption
    : PARALLEL (ON | OFF)
    ;

// MAXFILESIZE option
maxfilesizeOption
    : MAXFILESIZE AS? numericValue sizeUnit?
    ;

// ROWGROUPSIZE option (for Parquet format)
rowgroupsizeOption
    : ROWGROUPSIZE AS? numericValue sizeUnit?
    ;

// Size units
sizeUnit
    : MB
    | GB
    ;

// REGION option
regionOption
    : REGION AS? stringLiteral
    ;

// EXTENSION option
extensionOption
    : EXTENSION stringLiteral
    ;

// Column list for PARTITION BY
columnList
    : identifier (',' identifier)*
    ;

// Placeholder rules (these would be defined in the main grammar)
selectStatement : .* ;
stringLiteral : .* ;
identifier : .* ;
numericValue : .* ;

// Keywords (would be in lexer)
UNLOAD : 'UNLOAD' ;
TO : 'TO' ;
IAM_ROLE : 'IAM_ROLE' ;
DEFAULT : 'DEFAULT' ;
FORMAT : 'FORMAT' ;
CSV : 'CSV' ;
PARQUET : 'PARQUET' ;
JSON : 'JSON' ;
PARTITION : 'PARTITION' ;
BY : 'BY' ;
INCLUDE : 'INCLUDE' ;
MANIFEST : 'MANIFEST' ;
VERBOSE : 'VERBOSE' ;
HEADER : 'HEADER' ;
DELIMITER : 'DELIMITER' ;
AS : 'AS' ;
FIXEDWIDTH : 'FIXEDWIDTH' ;
ENCRYPTED : 'ENCRYPTED' ;
AUTO : 'AUTO' ;
KMS_KEY_ID : 'KMS_KEY_ID' ;
BZIP2 : 'BZIP2' ;
GZIP : 'GZIP' ;
ZSTD : 'ZSTD' ;
ADDQUOTES : 'ADDQUOTES' ;
NULL : 'NULL' ;
ESCAPE : 'ESCAPE' ;
ALLOWOVERWRITE : 'ALLOWOVERWRITE' ;
CLEANPATH : 'CLEANPATH' ;
PARALLEL : 'PARALLEL' ;
ON : 'ON' ;
OFF : 'OFF' ;
MAXFILESIZE : 'MAXFILESIZE' ;
ROWGROUPSIZE : 'ROWGROUPSIZE' ;
MB : 'MB' ;
GB : 'GB' ;
REGION : 'REGION' ;
EXTENSION : 'EXTENSION' ;