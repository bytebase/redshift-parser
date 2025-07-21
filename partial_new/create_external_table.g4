// CREATE EXTERNAL TABLE statement - Redshift-specific command

createexternaltablestmt:
    CREATE EXTERNAL TABLE opt_if_not_exists qualified_name 
    '(' opttableelementlist ')'
    partitionedbyClause?
    rowformatClause?
    storedasClause
    locationClause
    tablepropertiesClause?
    ;

partitionedbyClause:
    PARTITIONED BY '(' opttableelementlist ')'
    ;

rowformatClause:
    ROW FORMAT rowformattype
    ;

rowformattype:
    DELIMITED rowformatdelimitedoptions?
    | SERDE sconst (WITH SERDEPROPERTIES '(' rowpropertylist ')')?
    ;

rowformatdelimitedoptions:
    rowformatdelimitedoption+
    ;

rowformatdelimitedoption:
    FIELDS TERMINATED BY sconst (ESCAPED BY sconst)?
    | COLLECTION ITEMS TERMINATED BY sconst
    | MAP KEYS TERMINATED BY sconst  
    | LINES TERMINATED BY sconst
    | NULL DEFINED AS sconst
    ;

storedasClause:
    STORED AS fileformat
    | STORED AS INPUTFORMAT sconst OUTPUTFORMAT sconst
    ;

fileformat:
    PARQUET | RCFILE | SEQUENCEFILE | TEXTFILE | ORC | AVRO
    ;

locationClause:
    LOCATION sconst
    ;

tablepropertiesClause:
    TABLE PROPERTIES '(' rowpropertylist ')'
    ;

rowpropertylist:
    rowproperty (',' rowproperty)*
    ;

rowproperty:
    sconst '=' sconst
    ;

// Needed tokens: CREATE, EXTERNAL, TABLE, PARTITIONED, BY, ROW, FORMAT, DELIMITED,
// SERDE, WITH, SERDEPROPERTIES, FIELDS, TERMINATED, ESCAPED, COLLECTION, ITEMS,
// MAP, KEYS, LINES, NULL, DEFINED, AS, STORED, INPUTFORMAT, OUTPUTFORMAT,
// PARQUET, RCFILE, SEQUENCEFILE, TEXTFILE, ORC, AVRO, LOCATION, PROPERTIES