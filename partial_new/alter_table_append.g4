// ALTER TABLE APPEND command
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_TABLE_APPEND.html

alterTableAppendStatement
    : ALTER TABLE targetTableName=alterTableName 
      APPEND FROM sourceTable=alterTableAppendSource
      alterTableAppendOption?
    ;

alterTableAppendSource
    : schemaName=identifier DOT tableName=identifier
    | tableName=identifier
    ;

alterTableAppendOption
    : IGNOREEXTRA
    | FILLTARGET
    ;