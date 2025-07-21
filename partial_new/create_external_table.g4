// CREATE EXTERNAL TABLE grammar rules for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_EXTERNAL_TABLE.html

// NOTE: The following tokens need to be added to RedshiftLexer.g4:
// File formats: PARQUET, RCFILE, SEQUENCEFILE, TEXTFILE, ORC, AVRO
// Clauses: PARTITIONED, DELIMITED, TERMINATED, ESCAPED, SERDE, SERDEPROPERTIES
// Other: INPUTFORMAT, OUTPUTFORMAT, PROPERTIES, FIELDS, COLLECTION, ITEMS, DEFINED

// For now, using identifiers or string constants where specific tokens don't exist

createExternalTableStmt
    : CREATE EXTERNAL TABLE (IF_P NOT EXISTS)? qualified_name 
      OPEN_PAREN columnDefList? CLOSE_PAREN
      partitionedByClause?
      rowFormatClause?
      storedAsClause
      locationClause
      tablePropertiesClause?
    ;

columnDefList
    : columnDef (COMMA columnDef)*
    ;

columnDef
    : colid typename
    ;

partitionedByClause
    : identifier /* PARTITIONED */ BY OPEN_PAREN columnDefList CLOSE_PAREN
    ;

rowFormatClause
    : ROW FORMAT identifier /* DELIMITED */ rowFormatDelimitedOptions?
    | ROW FORMAT identifier /* SERDE */ sconst (WITH identifier /* SERDEPROPERTIES */ OPEN_PAREN serdePropertyList CLOSE_PAREN)?
    ;

rowFormatDelimitedOptions
    : rowFormatDelimitedOption+
    ;

rowFormatDelimitedOption
    : identifier /* FIELDS */ identifier /* TERMINATED */ BY sconst (identifier /* ESCAPED */ BY sconst)?
    | identifier /* COLLECTION */ identifier /* ITEMS */ identifier /* TERMINATED */ BY sconst
    | MAP identifier /* KEYS */ identifier /* TERMINATED */ BY sconst
    | identifier /* LINES */ identifier /* TERMINATED */ BY sconst
    | NULL identifier /* DEFINED */ AS sconst
    ;

serdePropertyList
    : serdeProperty (COMMA serdeProperty)*
    ;

serdeProperty
    : sconst EQUAL sconst
    ;

storedAsClause
    : STORED AS fileFormat
    | STORED AS identifier /* INPUTFORMAT */ sconst identifier /* OUTPUTFORMAT */ sconst
    ;

fileFormat
    : identifier /* PARQUET, RCFILE, SEQUENCEFILE, TEXTFILE, ORC, or AVRO */
    | identifier /* INPUTFORMAT */ sconst identifier /* OUTPUTFORMAT */ sconst
    ;

locationClause
    : LOCATION sconst
    ;

tablePropertiesClause
    : TABLE identifier /* PROPERTIES */ OPEN_PAREN tablePropertyList CLOSE_PAREN
    ;

tablePropertyList
    : tableProperty (COMMA tableProperty)*
    ;

tableProperty
    : sconst EQUAL sconst
    ;

