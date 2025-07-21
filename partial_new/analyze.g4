// ANALYZE statement
// https://docs.aws.amazon.com/redshift/latest/dg/r_ANALYZE.html

// Rules to be included in RedshiftParser.g4

// Enhanced ANALYZE statement for Redshift (replaces existing analyzestmt)
analyzestmt
    : analyze_keyword opt_verbose? opt_vacuum_relation_list? analyze_column_option?
    | analyze_keyword OPEN_PAREN vac_analyze_option_list CLOSE_PAREN opt_vacuum_relation_list?
    ;

// Column analysis options for ANALYZE
analyze_column_option
    : PREDICATE COLUMNS
    | ALL COLUMNS
    ;

// Keyword alternatives (already exists, included for reference)
analyze_keyword
    : ANALYZE
    | ANALYSE
    ;

// Tokens to be included in RedshiftLexer.g4 (if not already present)
// ANALYZE: 'ANALYZE';        // Already exists at line 246-247
// PREDICATE: 'PREDICATE';
// COLUMNS: 'COLUMNS';        // Already exists at line 2047-2048
// ALL: 'ALL';                // Already exists at line 238-239