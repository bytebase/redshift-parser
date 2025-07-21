// ANALYZE COMPRESSION statement
// https://docs.aws.amazon.com/redshift/latest/dg/r_ANALYZE_COMPRESSION.html

// Rules to be included in RedshiftParser.g4

// ANALYZE COMPRESSION specific rule
analyze_compression_stmt
    : analyze_keyword COMPRESSION opt_vacuum_relation_list? comprows_clause?
    ;

// COMPROWS clause for ANALYZE COMPRESSION
comprows_clause
    : COMPROWS numericonly
    ;

// Keyword alternatives (already exists, included for reference)
analyze_keyword
    : ANALYZE
    | ANALYSE
    ;

// Tokens to be included in RedshiftLexer.g4 (if not already present)
// ANALYZE: 'ANALYZE';        // Already exists at line 246-247
// COMPRESSION: 'COMPRESSION';
// COMPROWS: 'COMPROWS';