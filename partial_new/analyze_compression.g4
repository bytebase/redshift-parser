// ANALYZE COMPRESSION statement - Redshift-specific command

analyzecompressionstmt:
    analyze_keyword COMPRESSION opt_vacuum_relation_list? comprrowsclause?
    ;

comprrowsclause:
    COMPROWS numericonly
    ;

analyze_keyword:
    ANALYZE | ANALYSE
    ;

// Needed tokens: ANALYZE, ANALYSE, COMPRESSION, COMPROWS