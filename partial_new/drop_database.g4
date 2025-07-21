// DROP DATABASE grammar rules for Redshift
// Reference: https://docs.aws.amazon.com/redshift/latest/dg/r_DROP_DATABASE.html
// Note: While AWS documentation doesn't explicitly mention IF EXISTS and CASCADE/RESTRICT,
// these are included for compatibility with standard SQL practices

// DROP DATABASE
// Syntax: DROP DATABASE [IF EXISTS] database_name [CASCADE | RESTRICT]
// 
// Restrictions:
// - Cannot drop system databases: dev, padb_harvest, template0, template1, sys:internal
// - Cannot drop the current database
// - For databases with AWS Data Exchange datashares, requires setting:
//   SET datashare_break_glass_session_var to 'ce8d280c10ad41';
dropDatabaseStmt
    : DROP DATABASE (IF_P EXISTS)? databaseName dropBehavior?
    ;

databaseName
    : identifier
    ;

dropBehavior
    : CASCADE
    | RESTRICT
    ;

identifier
    : IDENTIFIER
    | unreservedKeyword
    | colNameKeyword
    ;

// Keywords that can be used as identifiers
unreservedKeyword
    : // Add unreserved keywords that can be used as database names
    ;

colNameKeyword
    : // Add column name keywords that can be used as database names
    ;

// Note: The following tokens should be defined in RedshiftLexer.g4:
// DROP, DATABASE, IF_P (for IF), EXISTS, CASCADE, RESTRICT, IDENTIFIER