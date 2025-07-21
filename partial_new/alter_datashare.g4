// ALTER DATASHARE grammar rules for Amazon Redshift
// Based on: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_DATASHARE.html

alterdatasharestmt
   : ALTER DATASHARE colid alterdatashare_action
   ;

alterdatashare_action
   : alterdatashare_add_drop alterdatashare_objects
   | SET PUBLICACCESSIBLE opt_equal? opt_boolean_or_string
   | SET INCLUDENEW opt_equal? opt_boolean_or_string FOR SCHEMA colid
   ;

alterdatashare_add_drop
   : ADD_P
   | REMOVE
   ;

alterdatashare_objects
   : TABLE datashare_table_list
   | SCHEMA name_list
   | FUNCTION datashare_function_list
   | ALL TABLES IN_P SCHEMA name_list
   | ALL FUNCTIONS IN_P SCHEMA name_list
   ;

datashare_table_list
   : datashare_table_name (COMMA datashare_table_name)*
   ;

datashare_table_name
   : colid (DOT colid)?
   ;

datashare_function_list
   : datashare_function (COMMA datashare_function)*
   ;

datashare_function
   : datashare_function_name func_args
   ;

datashare_function_name
   : colid (DOT colid)?
   ;

// Note: The following rules are already defined in RedshiftParser.g4:
// - func_args (for function argument lists)
// - opt_boolean_or_string (for TRUE/FALSE values)
// - opt_equal (for optional equals sign)
// - colid (for identifiers)
// - name_list (for comma-separated identifier lists)

// Lexer rules that need to be added to RedshiftLexer.g4:
// DATASHARE: 'DATASHARE';
// PUBLICACCESSIBLE: 'PUBLICACCESSIBLE';
// INCLUDENEW: 'INCLUDENEW';
// REMOVE: 'REMOVE';