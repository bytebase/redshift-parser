parser grammar RedshiftParser;


options { tokenVocab = RedshiftLexer;
superClass = RedshiftParserBase;
}


@header
{
}
@members
{
}
root
   : stmtblock EOF
   ;

plsqlroot
   : pl_function
   ;

stmtblock
   : stmtmulti
   ;

stmtmulti
   : (stmt SEMI?)*
   ;

stmt
   : altereventtrigstmt
   | altercollationstmt
   | alterdatabasestmt
   | alterdatabasesetstmt
   | alterdefaultprivilegesstmt
   | alterdomainstmt
   | alterenumstmt
   | alterextensionstmt
   | alterextensioncontentsstmt
   | alterfdwstmt
   | alterforeignserverstmt
   | alterfunctionstmt
   | alterprocedurestmt
   | altergroupstmt
   | alterobjectdependsstmt
   | alterobjectschemastmt
   | alterownerstmt
   | alteroperatorstmt
   | altertypestmt
   | alterpolicystmt
   | alterseqstmt
   | altersystemstmt
   | altertablestmt
   | altertblspcstmt
   | altercompositetypestmt
   | alterpublicationstmt
   | alterrolesetstmt
   | alterrolestmt
   | alteruserstmt
   | alterschemastmt
   | altersubscriptionstmt
   | alterstatsstmt
   | altertsconfigurationstmt
   | altertsdictionarystmt
   | alterusermappingstmt
   | analyzestmt
   | callstmt
   | checkpointstmt
   | closeportalstmt
   | clusterstmt
   | commentstmt
   | constraintssetstmt
   | copystmt
   | createamstmt
   | createasstmt
   | createassertionstmt
   | createcaststmt
   | createconversionstmt
   | createdomainstmt
   | createextensionstmt
   | createfdwstmt
   | createforeignserverstmt
   | createforeigntablestmt
   | createfunctionstmt
   | createprocedurestmt
   | creategroupstmt
   | creatematviewstmt
   | createopclassstmt
   | createopfamilystmt
   | createpublicationstmt
   | alteropfamilystmt
   | createpolicystmt
   | createplangstmt
   | createschemastmt
   | createseqstmt
   | createstmt
   | createsubscriptionstmt
   | createstatsstmt
   | createtablespacestmt
   | createtransformstmt
   | createtrigstmt
   | createeventtrigstmt
   | createrolestmt
   | createuserstmt
   | createusermappingstmt
   | createdbstmt
   | deallocatestmt
   | declarecursorstmt
   | definestmt
   | deletestmt
   | discardstmt
   | dostmt
   | dropcaststmt
   | dropopclassstmt
   | dropopfamilystmt
   | dropownedstmt
   | dropschemastmt
   | dropstmt
   | dropsubscriptionstmt
   | droptablespacestmt
   | droptransformstmt
   | droprolestmt
   | dropuserstmt
   | dropgroupstmt
   | dropusermappingstmt
   | dropdbstmt
   | executestmt
   | explainstmt
   | fetchstmt
   | grantstmt
   | importforeignschemastmt
   | indexstmt
   | insertstmt
   | mergestmt
   | listenstmt
   | refreshmatviewstmt
   | loadstmt
   | lockstmt
   | notifystmt
   | preparestmt
   | reassignownedstmt
   | reindexstmt
   | removeaggrstmt
   | removefuncstmt
   | removeoperstmt
   | renamestmt
   | revokestmt
   | revokerolestmt
   | rulestmt
   | seclabelstmt
   | selectstmt
   | transactionstmt
   | truncatestmt
   | unlistenstmt
   | updatestmt
   | vacuumstmt
   | variableresetstmt
   | variablesetstmt
   | variableshowstmt
   | viewstmt
   // REDSHIFT-SPECIFIC STATEMENTS
   | alterdatasharestmt
   | alterexternalschemastmt
   | alterexternalviewstmt
   | alteridentityproviderstmt
   | altermaskingpolicystmt
   | altermaterializedviewstmt
   | alterrlspolicystmt
   | altertableappendstmt
   | analyzecompressionstmt
   | attachmaskingpolicystmt
   | attachrlspolicystmt
   | cancelstmt
   | closestmt
   | createdatasharestmt
   | createexternalfunctionstmt
   | createexternalmodelstmt
   | createexternalschemastmt
   | createexternaltablestmt
   | createexternalviewstmt
   | createidentityproviderstmt
   | createlibrarystmt
   | createmaskingpolicystmt
   | createmodelstmt
   | createrlspolicystmt
   | descdatasharestmt
   | descidentityproviderstmt
   | detachmaskingpolicystmt
   | detachrlspolicystmt
   | dropdatasharestmt
   | dropexternalviewstmt
   | dropidentityproviderstmt
   | droplibrarystmt
   | dropmaskingpolicystmt
   | dropmodelstmt
   | droprlspolicystmt
   | insertexternaltablestmt
   | selectintostmt
   | setsessionauthorizationstmt
   | setsessioncharacteristicsstmt
   | showcolumnsstmt
   | showdatabasesstmt
   | showdatasharesstmt
   | showexternaltablestmt
   | showgrantsstmt
   | showmodelstmt
   | showprocedurestmt
   | showschemasstmt
   | showtablestmt
   | showtablesstmt
   | showviewstmt
   | unloadstmt
   | usestmt
   | plsqlconsolecommand
   ;

plsqlconsolecommand
   : MetaCommand EndMetaCommand?
   ;

callstmt
   : CALL func_application
   ;

createrolestmt
   : CREATE ROLE roleid opt_with? optrolelist
   ;

opt_with
   : WITH
   //| WITH_LA
   ;

optrolelist
   : createoptroleelem*
   ;

alteroptrolelist
   : alteroptroleelem (',' alteroptroleelem)*
   | alteroptroleelem*
   ;

alteroptroleelem
   : PASSWORD (sconst | NULL_P | DISABLE_P)
   | (ENCRYPTED | UNENCRYPTED) PASSWORD sconst
   | INHERIT
   | CONNECTION LIMIT (signediconst | UNLIMITED)
   | VALID UNTIL sconst
   | USER role_list
   | EXTERNALID (sconst | identifier)
   | CREATEDB
   | NOCREATEDB
   | CREATEUSER
   | NOCREATEUSER
   | SYSLOG ACCESS (RESTRICTED | UNRESTRICTED)
   | SESSION TIMEOUT iconst
   | RESET SESSION TIMEOUT
   | RESET ALL
   | SET var_name (TO | EQUAL)? var_list
   | RESET var_name
   | identifier
   ;

createoptroleelem
   : alteroptroleelem
   | SYSID iconst
   | ADMIN role_list
   | ROLE role_list
   | IN_P (ROLE | GROUP_P) role_list
   ;

createuserstmt
   : CREATE USER roleid opt_with? optrolelist
   ;

alterrolestmt
   : ALTER ROLE rolespec opt_with? alterroleaction;

alterroleaction
   : RENAME TO colid
   | OWNER TO colid
   | EXTERNALID TO colid
   ;

opt_in_database
   : IN_P DATABASE name
   ;

alterrolesetstmt
   : ALTER (ROLE | USER) ALL? rolespec opt_in_database? setresetclause
   ;

alterschemastmt
   : ALTER SCHEMA name QUOTA (iconst (MB | GB | TB)? | UNLIMITED)
   ;

droprolestmt
   : DROP ROLE rolespec (FORCE | RESTRICT)?
   ;

dropuserstmt
   : DROP USER opt_if_exists? role_list
   ;

dropgroupstmt
   : DROP GROUP_P rolespec
   ;


creategroupstmt
   : CREATE GROUP_P roleid opt_with? optrolelist
   ;

altergroupstmt
   : ALTER GROUP_P rolespec add_drop USER role_list
   ;

add_drop
   : ADD_P
   | DROP
   ;

createschemastmt
   : CREATE SCHEMA opt_if_not_exists? schemaname=colid opt_auth_clause? opt_quota? optschemaeltlist?
   | CREATE SCHEMA opt_auth_clause opt_quota? optschemaeltlist?
   ;

opt_auth_clause
   : AUTHORIZATION rolespec
   ;

opt_quota
   : QUOTA ((fconst | iconst) (MB | GB | TB)? | UNLIMITED)
   ;

optschemaeltlist
   : schema_stmt+
   ;

schema_stmt
   : createstmt
   | indexstmt
   | createseqstmt
   | createtrigstmt
   | grantstmt
   | viewstmt
   ;

variablesetstmt
   : SET (LOCAL | SESSION)? set_rest
   ;

set_rest
   : TRANSACTION transaction_mode_list
   | SESSION CHARACTERISTICS AS TRANSACTION transaction_mode_list
   | set_rest_more
   ;

generic_set
   : var_name (TO | EQUAL) var_list
   ;

set_rest_more
   : generic_set
   | var_name FROM CURRENT_P
   | TIME ZONE zone_value
   | CATALOG sconst
   | SCHEMA sconst
   | NAMES opt_encoding?
   | ROLE nonreservedword_or_sconst
   | SESSION AUTHORIZATION nonreservedword_or_sconst
   | XML_P OPTION document_or_content
   | TRANSACTION SNAPSHOT sconst
   ;

var_name
   : colid (DOT colid)*
   ;

var_list
   : var_value (COMMA var_value)*
   ;

var_value
   : opt_boolean_or_string
   | numericonly
   ;

iso_level
   : READ (UNCOMMITTED | COMMITTED)
   | REPEATABLE READ
   | SERIALIZABLE
   ;

opt_boolean_or_string
   : TRUE_P
   | FALSE_P
   | ON
   | nonreservedword_or_sconst
   ;

zone_value
   : sconst
   | identifier
   | constinterval sconst opt_interval?
   | constinterval OPEN_PAREN iconst CLOSE_PAREN sconst
   | numericonly
   | DEFAULT
   | LOCAL
   ;

opt_encoding
   : sconst
   | DEFAULT
   ;

nonreservedword_or_sconst
   : nonreservedword
   | sconst
   ;

variableresetstmt
   : RESET reset_rest
   ;

reset_rest
   : generic_reset
   | TIME ZONE
   | TRANSACTION ISOLATION LEVEL
   | SESSION AUTHORIZATION
   ;

generic_reset
   : var_name
   | ALL
   ;

setresetclause
   : SET set_rest
   | variableresetstmt
   ;

functionsetresetclause
   : SET set_rest_more
   | variableresetstmt
   ;

variableshowstmt
   : SHOW (var_name | TIME ZONE | TRANSACTION ISOLATION LEVEL | SESSION AUTHORIZATION | CURRENT_SCHEMA | SESSION_USER | CURRENT_USER | ALL)
   ;

constraintssetstmt
   : SET CONSTRAINTS constraints_set_list constraints_set_mode
   ;

constraints_set_list
   : ALL
   | qualified_name_list
   ;

constraints_set_mode
   : DEFERRED
   | IMMEDIATE
   ;

checkpointstmt
   : CHECKPOINT
   ;

discardstmt
   : DISCARD (ALL | TEMP | TEMPORARY | PLANS | SEQUENCES)
   ;

altertablestmt
   : ALTER TABLE qualified_name alter_table_cmds (COMMA alter_table_cmds)*
   ;

alter_table_cmds
   : ADD_P table_constraint
   | DROP CONSTRAINT colid (RESTRICT | CASCADE)?
   | OWNER TO rolespec
   | RENAME TO colid
   | RENAME COLUMN colid TO colid
   | ALTER COLUMN colid TYPE_P typename
   | ALTER COLUMN colid ENCODE colid
   | ALTER DISTKEY colid
   | ALTER DISTSTYLE ALL
   | ALTER DISTSTYLE EVEN
   | ALTER DISTSTYLE KEY DISTKEY colid
   | ALTER DISTSTYLE AUTO
   | ALTER COMPOUND? SORTKEY OPEN_PAREN columnlist CLOSE_PAREN
   | ALTER SORTKEY AUTO
   | ALTER SORTKEY NONE
   | ALTER ENCODE AUTO
   | ADD_P COLUMN? colid typename (DEFAULT a_expr)? (ENCODE colid)? (NOT? NULL_P)? (COLLATE (CASE_SENSITIVE | CS | CASE_INSENSITIVE | CI))?
   | DROP COLUMN? colid (RESTRICT | CASCADE)?
   | ROW LEVEL SECURITY (ON | OFF) (CONJUNCTION TYPE_P (AND | OR))? (FOR DATASHARES)?
   | MASKING (ON | OFF) FOR DATASHARES
   // ALTER TABLE APPEND
   | APPEND FROM qualified_name (IGNOREEXTRA | FILLTARGET)?
   // The following options apply only to external tables
   | SET LOCATION StringConstant
   | SET FILE FORMAT colid
   | SET TABLE PROPERTIES OPEN_PAREN table_properties_list CLOSE_PAREN
   | PARTITION OPEN_PAREN ((colid EQUAL a_expr) (COMMA colid EQUAL a_expr)*) CLOSE_PAREN SET LOCATION StringConstant
   | ADD_P opt_if_not_exists? PARTITION OPEN_PAREN ((colid EQUAL a_expr) (COMMA colid EQUAL a_expr)*) CLOSE_PAREN LOCATION StringConstant
   | DROP PARTITION OPEN_PAREN ((colid EQUAL a_expr) (COMMA colid EQUAL a_expr)*) CLOSE_PAREN
   ;

table_constraint
   : (CONSTRAINT colid)? (
       (UNIQUE OPEN_PAREN columnlist CLOSE_PAREN)
       | (PRIMARY KEY OPEN_PAREN columnlist CLOSE_PAREN)
       | (FOREIGN KEY OPEN_PAREN columnlist CLOSE_PAREN REFERENCES qualified_name OPEN_PAREN columnlist CLOSE_PAREN)
   );

partition_cmd
   : ATTACH PARTITION qualified_name partitionboundspec
   | DETACH PARTITION qualified_name
   ;

index_partition_cmd
   : ATTACH PARTITION qualified_name
   ;

alter_table_cmd
   : ADD_P columnDef
   | ADD_P IF_P NOT EXISTS columnDef
   | ADD_P COLUMN columnDef
   | ADD_P COLUMN IF_P NOT EXISTS columnDef
   | ALTER opt_column? colid alter_column_default
   | ALTER opt_column? colid DROP NOT NULL_P
   | ALTER opt_column? colid SET NOT NULL_P
   | ALTER opt_column? colid DROP EXPRESSION
   | ALTER opt_column? colid DROP EXPRESSION IF_P EXISTS
   | ALTER opt_column? colid SET STATISTICS signediconst
   | ALTER opt_column? iconst SET STATISTICS signediconst
   | ALTER opt_column? colid SET reloptions
   | ALTER opt_column? colid RESET reloptions
   | ALTER opt_column? colid SET STORAGE colid
   | ALTER opt_column? colid ADD_P GENERATED generated_when AS IDENTITY_P optparenthesizedseqoptlist?
   | ALTER opt_column? colid alter_identity_column_option_list
   | ALTER opt_column? colid DROP IDENTITY_P
   | ALTER opt_column? colid DROP IDENTITY_P IF_P EXISTS
   | DROP opt_column? IF_P EXISTS colid opt_drop_behavior?
   | DROP opt_column? colid opt_drop_behavior?
   | ALTER opt_column? colid opt_set_data? TYPE_P typename opt_collate_clause? alter_using?
   | ALTER opt_column? colid alter_generic_options
   | ADD_P tableconstraint
   | ALTER CONSTRAINT name constraintattributespec
   | VALIDATE CONSTRAINT name
   | DROP CONSTRAINT IF_P EXISTS name opt_drop_behavior?
   | DROP CONSTRAINT name opt_drop_behavior?
   | SET WITHOUT OIDS
   | CLUSTER ON name
   | SET WITHOUT CLUSTER
   | SET LOGGED
   | SET UNLOGGED
   | ENABLE_P TRIGGER name
   | ENABLE_P ALWAYS TRIGGER name
   | ENABLE_P REPLICA TRIGGER name
   | ENABLE_P TRIGGER ALL
   | ENABLE_P TRIGGER USER
   | DISABLE_P TRIGGER name
   | DISABLE_P TRIGGER ALL
   | DISABLE_P TRIGGER USER
   | ENABLE_P RULE name
   | ENABLE_P ALWAYS RULE name
   | ENABLE_P REPLICA RULE name
   | DISABLE_P RULE name
   | INHERIT qualified_name
   | NO INHERIT qualified_name
   | OF any_name
   | NOT OF
   | OWNER TO rolespec
   | SET ACCESS METHOD name
   | SET TABLESPACE name
   | SET reloptions
   | RESET reloptions
   | REPLICA IDENTITY_P replica_identity
   | ENABLE_P ROW LEVEL SECURITY
   | DISABLE_P ROW LEVEL SECURITY
   | FORCE ROW LEVEL SECURITY
   | NO FORCE ROW LEVEL SECURITY
   | alter_generic_options
   ;

alter_column_default
   : SET DEFAULT a_expr
   | DROP DEFAULT
   ;

opt_drop_behavior
   : CASCADE
   | RESTRICT
   ;

opt_collate_clause
   : COLLATE any_name
   ;

alter_using
   : USING a_expr
   ;

replica_identity
   : NOTHING
   | FULL
   | DEFAULT
   | USING INDEX name
   ;

reloptions
   : OPEN_PAREN reloption_list CLOSE_PAREN
   ;

opt_reloptions
   : WITH reloptions
   ;

reloption_list
   : reloption_elem (COMMA reloption_elem)*
   ;

reloption_elem
   : collabel (EQUAL def_arg | DOT collabel (EQUAL def_arg)?)?
   ;

alter_identity_column_option_list
   : alter_identity_column_option+
   ;

alter_identity_column_option
   : RESTART (opt_with? numericonly)?
   | SET (seqoptelem | GENERATED generated_when)
   ;

partitionboundspec
   : FOR VALUES WITH OPEN_PAREN hash_partbound CLOSE_PAREN
   | FOR VALUES IN_P OPEN_PAREN expr_list CLOSE_PAREN
   | FOR VALUES FROM OPEN_PAREN expr_list CLOSE_PAREN TO OPEN_PAREN expr_list CLOSE_PAREN
   | DEFAULT
   ;

hash_partbound_elem
   : nonreservedword iconst
   ;

hash_partbound
   : hash_partbound_elem (COMMA hash_partbound_elem)*
   ;

altercompositetypestmt
   : ALTER TYPE_P any_name alter_type_cmds
   ;

alter_type_cmds
   : alter_type_cmd (COMMA alter_type_cmd)*
   ;

alter_type_cmd
   : ADD_P ATTRIBUTE tablefuncelement opt_drop_behavior?
   | DROP ATTRIBUTE (IF_P EXISTS)? colid opt_drop_behavior?
   | ALTER ATTRIBUTE colid opt_set_data? TYPE_P typename opt_collate_clause? opt_drop_behavior?
   ;

closeportalstmt
   : CLOSE (cursor_name | ALL)
   ;

copystmt
   : COPY opt_binary? qualified_name opt_column_list? copy_from opt_program? copy_file_name copy_delimiter? opt_with? copy_options where_clause?
   | COPY OPEN_PAREN preparablestmt CLOSE_PAREN TO opt_program? copy_file_name opt_with? copy_options
   | COPY qualified_name opt_column_list? FROM sconst redshift_copy_authorization redshift_copy_format? redshift_copy_parameter*
   ;

redshift_copy_authorization
   : IAM_ROLE (DEFAULT | sconst)
   | CREDENTIALS sconst
   | ACCESS_KEY_ID sconst SECRET_ACCESS_KEY sconst (SESSION_TOKEN_KW sconst)?
   ;

redshift_copy_format
   : FORMAT? AS? (CSV | PARQUET | ORC | JSON | AVRO) sconst?
   ;

redshift_copy_parameter
   : copy_param_name (AS? copy_param_value)?
   ;

copy_param_name
   : colid
   | NULL_P
   ;

copy_param_value
   : sconst | iconst | colid
   | ON | OFF | TRUE_P | FALSE_P | PRESET
   | AUTO | DEFAULT | NONE
   ;

copy_from
   : FROM
   | TO
   ;

opt_program
   : PROGRAM
   ;

copy_file_name
   : sconst
   | STDIN
   | STDOUT
   ;

copy_options
   : copy_opt_list
   | OPEN_PAREN copy_generic_opt_list CLOSE_PAREN
   ;

copy_opt_list
   : copy_opt_item*
   ;

copy_opt_item
   : BINARY
   | FREEZE
   | DELIMITER opt_as? sconst
   | NULL_P opt_as? sconst
   | CSV
   | HEADER_P
   | QUOTE opt_as? sconst
   | ESCAPE opt_as? sconst
   | FORCE QUOTE columnlist
   | FORCE QUOTE STAR
   | FORCE NOT NULL_P columnlist
   | FORCE NULL_P columnlist
   | ENCODING sconst
   ;

opt_binary
   : BINARY
   ;

copy_delimiter
   : opt_using? DELIMITERS sconst
   ;

opt_using
   : USING
   ;

copy_generic_opt_list
   : copy_generic_opt_elem (COMMA copy_generic_opt_elem)*
   ;

copy_generic_opt_elem
   : collabel copy_generic_opt_arg?
   ;

copy_generic_opt_arg
   : opt_boolean_or_string
   | numericonly
   | STAR
   | OPEN_PAREN copy_generic_opt_arg_list CLOSE_PAREN
   ;

copy_generic_opt_arg_list
   : copy_generic_opt_arg_list_item (COMMA copy_generic_opt_arg_list_item)*
   ;

copy_generic_opt_arg_list_item
   : opt_boolean_or_string
   ;

createstmt
   : CREATE opttemp? TABLE (IF_P NOT EXISTS)? table_name (
      OPEN_PAREN opttableelementlist? CLOSE_PAREN opt_backup_clause? opt_table_attributes*
      )
   ;

opt_table_attributes
   : DISTSTYLE (AUTO | EVEN | KEY | ALL)
   | DISTKEY OPEN_PAREN distkey_identifier=colid CLOSE_PAREN
   | (COMPOUND | INTERLEAVED)? SORTKEY OPEN_PAREN sortkey_columnlist=columnlist CLOSE_PAREN
   | ENCODE AUTO
   ;


opttemp
   : LOCAL? (TEMPORARY | TEMP)
   ;

opttableelementlist
   : tableelementlist
   ;

opttypedtableelementlist
   : OPEN_PAREN typedtableelementlist CLOSE_PAREN
   ;

tableelementlist
   : tableelement (COMMA tableelement)*
   ;

typedtableelementlist
   : typedtableelement (COMMA typedtableelement)*
   ;

tableelement
   : tableconstraint
   | tablelikeclause
   | columnDef
   ;

typedtableelement
   : columnOptions
   | tableconstraint
   ;

columnDef
   : colid extern_typename create_generic_options? rs_colattributes?
   ;

rs_colattributes:
   rs_colattribute+
   ;

rs_colattribute
   : DEFAULT b_expr
   | IDENTITY_P OPEN_PAREN seed=iconst COMMA step=iconst CLOSE_PAREN
   | GENERATED generated_when AS IDENTITY_P (OPEN_PAREN seed=iconst COMMA step=iconst CLOSE_PAREN)?
   | ENCODE colid
   | DISTKEY
   | SORTKEY
   | COLLATE (CASE_SENSITIVE | CASE_INSENSITIVE)
   | NOT NULL_P | NULL_P
   | UNIQUE | PRIMARY KEY
   | REFERENCES qualified_name opt_column_list?
   ;

columnOptions
   : colid (WITH OPTIONS)? colquallist
   ;

colquallist
   : colconstraint*
   ;

colconstraint
   : CONSTRAINT name colconstraintelem
   | colconstraintelem
   | constraintattr
   | COLLATE any_name
   ;

colconstraintelem
   : NOT NULL_P
   | NULL_P
   | UNIQUE opt_unique_null_treatment? opt_definition? optconstablespace?
   | PRIMARY KEY opt_definition? optconstablespace?
   | CHECK OPEN_PAREN a_expr CLOSE_PAREN opt_no_inherit?
   | DEFAULT b_expr
   | GENERATED generated_when AS (IDENTITY_P optparenthesizedseqoptlist? | OPEN_PAREN a_expr CLOSE_PAREN STORED)
   | REFERENCES qualified_name opt_column_list? key_match? key_actions?
   ;
   
opt_unique_null_treatment
   : NULLS_P NOT? DISTINCT
   ;

generated_when
   : ALWAYS
   | BY DEFAULT
   ;

constraintattr
   : DEFERRABLE
   | NOT DEFERRABLE
   | INITIALLY (DEFERRED | IMMEDIATE)
   ;

tablelikeclause
   : LIKE qualified_name tablelikeoptionlist
   ;

tablelikeoptionlist
   : ((INCLUDING | EXCLUDING) tablelikeoption)*
   ;

tablelikeoption
   : COMMENTS
   | CONSTRAINTS
   | DEFAULTS
   | IDENTITY_P
   | GENERATED
   | INDEXES
   | STATISTICS
   | STORAGE
   | ALL
   ;

tableconstraint
   : CONSTRAINT name constraintelem
   | constraintelem
   ;

constraintelem
   : CHECK OPEN_PAREN a_expr CLOSE_PAREN constraintattributespec
   | UNIQUE opt_unique_null_treatment? (OPEN_PAREN columnlist CLOSE_PAREN opt_c_include? opt_definition? optconstablespace? constraintattributespec | existingindex constraintattributespec)
   | PRIMARY KEY (OPEN_PAREN columnlist CLOSE_PAREN opt_c_include? opt_definition? optconstablespace? constraintattributespec | existingindex constraintattributespec)
   | EXCLUDE access_method_clause? OPEN_PAREN exclusionconstraintlist CLOSE_PAREN opt_c_include? opt_definition? optconstablespace? exclusionwhereclause? constraintattributespec
   | FOREIGN KEY OPEN_PAREN columnlist CLOSE_PAREN REFERENCES qualified_name opt_column_list? key_match? key_actions? constraintattributespec
   ;

opt_no_inherit
   : NO INHERIT
   ;

opt_column_list
   : OPEN_PAREN columnlist CLOSE_PAREN
   ;

columnlist
   : columnElem (COMMA columnElem)*
   ;

columnElem
   : colid
   ;

opt_c_include
   : INCLUDE OPEN_PAREN columnlist CLOSE_PAREN
   ;

key_match
   : MATCH (FULL | PARTIAL | SIMPLE)
   ;

exclusionconstraintlist
   : exclusionconstraintelem (COMMA exclusionconstraintelem)*
   ;

exclusionconstraintelem
   : index_elem WITH (any_operator | OPERATOR OPEN_PAREN any_operator CLOSE_PAREN)
   ;

exclusionwhereclause
   : WHERE OPEN_PAREN a_expr CLOSE_PAREN
   ;

key_actions
   : key_update
   | key_delete
   | key_update key_delete
   | key_delete key_update
   ;

key_update
   : ON UPDATE key_action
   ;

key_delete
   : ON DELETE_P key_action
   ;

key_action
   : NO ACTION
   | RESTRICT
   | CASCADE
   | SET (NULL_P | DEFAULT) opt_column_list?
   ;

optinherit
   : INHERITS OPEN_PAREN qualified_name_list CLOSE_PAREN
   ;

optpartitionspec
   : partitionspec
   ;

partitionspec
   : PARTITION BY colid OPEN_PAREN part_params CLOSE_PAREN
   ;

part_params
   : part_elem (COMMA part_elem)*
   ;

part_elem
   : colid opt_collate? opt_class?
   | func_expr_windowless opt_collate? opt_class?
   | OPEN_PAREN a_expr CLOSE_PAREN opt_collate? opt_class?
   ;

table_access_method_clause
   : USING name
   ;

optwith
   : WITH reloptions
   | WITHOUT OIDS
   ;

oncommitoption
   : ON COMMIT (DROP | DELETE_P ROWS | PRESERVE ROWS)
   ;

opttablespace
   : TABLESPACE name
   ;

optredshifttableoptions
   : redshifttableoption+
   ;

redshifttableoption
   : BACKUP (YES_P | NO)
   | DISTSTYLE (ALL | EVEN | KEY | AUTO)
   | DISTKEY OPEN_PAREN colid CLOSE_PAREN
   | sortkeyclause
   | ENCODE AUTO
   ;

sortkeyclause
   : sortkeyclausetype? SORTKEY OPEN_PAREN columnlist CLOSE_PAREN
   ;

sortkeyclausetype
   : COMPOUND
   | INTERLEAVED
   ;

optconstablespace
   : USING INDEX TABLESPACE name
   ;

existingindex
   : USING INDEX name
   ;

createstatsstmt
   : CREATE STATISTICS (IF_P NOT EXISTS)? any_name opt_name_list? ON expr_list FROM from_list
   ;

alterstatsstmt
   : ALTER STATISTICS (IF_P EXISTS)? any_name SET STATISTICS signediconst
   ;

createasstmt
   : CREATE opttemp? TABLE create_as_target AS selectstmt
   ;

create_as_target
   : table_name opt_column_list? opt_backup_clause_table_attributes?
   ;

opt_backup_clause_table_attributes
   : opt_backup_clause opt_table_attributes*
   | opt_table_attributes+ opt_backup_clause? opt_table_attributes*
   ;

table_attributes
   : DISTSTYLE (AUTO | EVEN | ALL | KEY)
   | DISTKEY OPEN_PAREN distkey_identifier=colid CLOSE_PAREN
   | (COMPOUND | INTERLEAVED)? SORTKEY OPEN_PAREN sortkey_columnlist=columnlist CLOSE_PAREN
   ;

opt_backup_clause
   : BACKUP (YES_P | NO)
   ;

opt_with_data
   : WITH (DATA_P | NO DATA_P)
   ;

creatematviewstmt
   : CREATE MATERIALIZED VIEW qualified_name opt_backup_clause? opt_table_attributes* opt_auto_refresh? AS selectstmt
   ;

opt_auto_refresh
   : AUTO REFRESH (YES_P | NO);

refreshmatviewstmt
   : REFRESH MATERIALIZED VIEW opt_concurrently? qualified_name opt_with_data? (RESTRICT | CASCADE)?
   ;

createseqstmt
   : CREATE opttemp? SEQUENCE (IF_P NOT EXISTS)? qualified_name optseqoptlist?
   ;

alterseqstmt
   : ALTER SEQUENCE (IF_P EXISTS)? qualified_name seqoptlist
   ;

optseqoptlist
   : seqoptlist
   ;

optparenthesizedseqoptlist
   : OPEN_PAREN seqoptlist CLOSE_PAREN
   ;

seqoptlist
   : seqoptelem+
   ;

seqoptelem
   : AS simpletypename
   | CACHE numericonly
   | CYCLE
   | INCREMENT opt_by? numericonly
   | LOGGED
   | MAXVALUE numericonly
   | MINVALUE numericonly
   | NO (MAXVALUE | MINVALUE | CYCLE)
   | OWNED BY any_name
   | SEQUENCE NAME_P any_name
   | START opt_with? numericonly
   | RESTART opt_with? numericonly?
   | UNLOGGED
   ;

opt_by
   : BY
   ;

numericonly
   : fconst
   | PLUS fconst
   | MINUS fconst
   | signediconst
   ;

numericonly_list
   : numericonly (COMMA numericonly)*
   ;

createplangstmt
   : CREATE opt_or_replace? opt_trusted? opt_procedural? LANGUAGE name (HANDLER handler_name opt_inline_handler? opt_validator?)?
   ;

opt_trusted
   : TRUSTED
   ;

handler_name
   : name attrs?
   ;

opt_inline_handler
   : INLINE_P handler_name
   ;

validator_clause
   : VALIDATOR handler_name
   | NO VALIDATOR
   ;

opt_validator
   : validator_clause
   ;

opt_procedural
   : PROCEDURAL
   ;

createtablespacestmt
   : CREATE TABLESPACE name opttablespaceowner? LOCATION sconst opt_reloptions?
   ;

opttablespaceowner
   : OWNER rolespec
   ;

droptablespacestmt
   : DROP TABLESPACE (IF_P EXISTS)? name
   ;

createextensionstmt
   : CREATE EXTENSION (IF_P NOT EXISTS)? name opt_with? create_extension_opt_list
   ;

create_extension_opt_list
   : create_extension_opt_item*
   ;

create_extension_opt_item
   : SCHEMA name
   | VERSION_P nonreservedword_or_sconst
   | FROM nonreservedword_or_sconst
   | CASCADE
   ;

alterextensionstmt
   : ALTER EXTENSION name UPDATE alter_extension_opt_list
   ;

alter_extension_opt_list
   : alter_extension_opt_item*
   ;

alter_extension_opt_item
   : TO nonreservedword_or_sconst
   ;

alterextensioncontentsstmt
   : ALTER EXTENSION name add_drop object_type_name name
   | ALTER EXTENSION name add_drop object_type_any_name any_name
   | ALTER EXTENSION name add_drop AGGREGATE aggregate_with_argtypes
   | ALTER EXTENSION name add_drop CAST OPEN_PAREN typename AS typename CLOSE_PAREN
   | ALTER EXTENSION name add_drop DOMAIN_P typename
   | ALTER EXTENSION name add_drop FUNCTION function_with_argtypes
   | ALTER EXTENSION name add_drop OPERATOR operator_with_argtypes
   | ALTER EXTENSION name add_drop OPERATOR CLASS any_name USING name
   | ALTER EXTENSION name add_drop OPERATOR FAMILY any_name USING name
   | ALTER EXTENSION name add_drop PROCEDURE function_with_argtypes
   | ALTER EXTENSION name add_drop ROUTINE function_with_argtypes
   | ALTER EXTENSION name add_drop TRANSFORM FOR typename LANGUAGE name
   | ALTER EXTENSION name add_drop TYPE_P typename
   ;

createfdwstmt
   : CREATE FOREIGN DATA_P WRAPPER name opt_fdw_options? create_generic_options?
   ;

fdw_option
   : HANDLER handler_name
   | NO HANDLER
   | VALIDATOR handler_name
   | NO VALIDATOR
   ;

fdw_options
   : fdw_option+
   ;

opt_fdw_options
   : fdw_options
   ;

alterfdwstmt
   : ALTER FOREIGN DATA_P WRAPPER name opt_fdw_options? alter_generic_options
   | ALTER FOREIGN DATA_P WRAPPER name fdw_options
   ;

create_generic_options
   : OPTIONS OPEN_PAREN generic_option_list CLOSE_PAREN
   ;

generic_option_list
   : generic_option_elem (COMMA generic_option_elem)*
   ;

alter_generic_options
   : OPTIONS OPEN_PAREN alter_generic_option_list CLOSE_PAREN
   ;

alter_generic_option_list
   : alter_generic_option_elem (COMMA alter_generic_option_elem)*
   ;

alter_generic_option_elem
   : generic_option_elem
   | SET generic_option_elem
   | ADD_P generic_option_elem
   | DROP generic_option_name
   ;

generic_option_elem
   : generic_option_name generic_option_arg
   ;

generic_option_name
   : collabel
   ;

generic_option_arg
   : sconst
   ;

createforeignserverstmt
   : CREATE SERVER name opt_type? opt_foreign_server_version? FOREIGN DATA_P WRAPPER name create_generic_options?
   | CREATE SERVER IF_P NOT EXISTS name opt_type? opt_foreign_server_version? FOREIGN DATA_P WRAPPER name create_generic_options?
   ;

opt_type
   : TYPE_P sconst
   ;

foreign_server_version
   : VERSION_P (sconst | NULL_P)
   ;

opt_foreign_server_version
   : foreign_server_version
   ;

alterforeignserverstmt
   : ALTER SERVER name (alter_generic_options | foreign_server_version alter_generic_options?)
   ;

createforeigntablestmt
   : CREATE FOREIGN TABLE qualified_name OPEN_PAREN opttableelementlist? CLOSE_PAREN optinherit? SERVER name create_generic_options?
   | CREATE FOREIGN TABLE IF_P NOT EXISTS qualified_name OPEN_PAREN opttableelementlist? CLOSE_PAREN optinherit? SERVER name create_generic_options?
   | CREATE FOREIGN TABLE qualified_name PARTITION OF qualified_name opttypedtableelementlist? partitionboundspec SERVER name create_generic_options?
   | CREATE FOREIGN TABLE IF_P NOT EXISTS qualified_name PARTITION OF qualified_name opttypedtableelementlist? partitionboundspec SERVER name create_generic_options?
   ;

importforeignschemastmt
   : IMPORT_P FOREIGN SCHEMA name import_qualification? FROM SERVER name INTO name create_generic_options?
   ;

import_qualification_type
   : LIMIT TO
   | EXCEPT
   ;

import_qualification
   : import_qualification_type OPEN_PAREN relation_expr_list CLOSE_PAREN
   ;

createusermappingstmt
   : CREATE USER MAPPING FOR auth_ident SERVER name create_generic_options?
   | CREATE USER MAPPING IF_P NOT EXISTS FOR auth_ident SERVER name create_generic_options?
   ;

auth_ident
   : rolespec
   | USER
   ;

dropusermappingstmt
   : DROP USER MAPPING FOR auth_ident SERVER name
   | DROP USER MAPPING IF_P EXISTS FOR auth_ident SERVER name
   ;

alterusermappingstmt
   : ALTER USER MAPPING FOR auth_ident SERVER name alter_generic_options
   ;

createpolicystmt
   : CREATE POLICY name ON qualified_name rowsecuritydefaultpermissive? rowsecuritydefaultforcmd? rowsecuritydefaulttorole? rowsecurityoptionalexpr? rowsecurityoptionalwithcheck?
   ;

alterpolicystmt
   : ALTER POLICY name ON qualified_name rowsecurityoptionaltorole? rowsecurityoptionalexpr? rowsecurityoptionalwithcheck?
   ;

rowsecurityoptionalexpr
   : USING OPEN_PAREN a_expr CLOSE_PAREN
   ;

rowsecurityoptionalwithcheck
   : WITH CHECK OPEN_PAREN a_expr CLOSE_PAREN
   ;

rowsecuritydefaulttorole
   : TO role_list
   ;

rowsecurityoptionaltorole
   : TO role_list
   ;

rowsecuritydefaultpermissive
   : AS identifier
   ;

rowsecuritydefaultforcmd
   : FOR row_security_cmd
   ;

row_security_cmd
   : ALL
   | SELECT
   | INSERT
   | UPDATE
   | DELETE_P
   ;

createamstmt
   : CREATE ACCESS METHOD name TYPE_P am_type HANDLER handler_name
   ;

am_type
   : INDEX
   | TABLE
   ;

createtrigstmt
   : CREATE TRIGGER name triggeractiontime triggerevents ON qualified_name triggerreferencing? triggerforspec? triggerwhen? EXECUTE function_or_procedure func_name OPEN_PAREN triggerfuncargs CLOSE_PAREN
   | CREATE CONSTRAINT TRIGGER name AFTER triggerevents ON qualified_name optconstrfromtable? constraintattributespec FOR EACH ROW triggerwhen? EXECUTE function_or_procedure func_name OPEN_PAREN triggerfuncargs CLOSE_PAREN
   ;

triggeractiontime
   : BEFORE
   | AFTER
   | INSTEAD OF
   ;

triggerevents
   : triggeroneevent (OR triggeroneevent)*
   ;

triggeroneevent
   : INSERT
   | DELETE_P
   | UPDATE
   | UPDATE OF columnlist
   | TRUNCATE
   ;

triggerreferencing
   : REFERENCING triggertransitions
   ;

triggertransitions
   : triggertransition+
   ;

triggertransition
   : transitionoldornew transitionrowortable opt_as? transitionrelname
   ;

transitionoldornew
   : NEW
   | OLD
   ;

transitionrowortable
   : TABLE
   | ROW
   ;

transitionrelname
   : colid
   ;

triggerforspec
   : FOR triggerforopteach? triggerfortype
   ;

triggerforopteach
   : EACH
   ;

triggerfortype
   : ROW
   | STATEMENT
   ;

triggerwhen
   : WHEN OPEN_PAREN a_expr CLOSE_PAREN
   ;

function_or_procedure
   : FUNCTION
   | PROCEDURE
   ;

triggerfuncargs
   : (triggerfuncarg |) (COMMA triggerfuncarg)*
   ;

triggerfuncarg
   : iconst
   | fconst
   | sconst
   | collabel
   ;

optconstrfromtable
   : FROM qualified_name
   ;

constraintattributespec
   : constraintattributeElem*
   ;

constraintattributeElem
   : NOT DEFERRABLE
   | DEFERRABLE
   | INITIALLY IMMEDIATE
   | INITIALLY DEFERRED
   | NOT VALID
   | NO INHERIT
   ;

createeventtrigstmt
   : CREATE EVENT TRIGGER name ON collabel EXECUTE function_or_procedure func_name OPEN_PAREN CLOSE_PAREN
   | CREATE EVENT TRIGGER name ON collabel WHEN event_trigger_when_list EXECUTE function_or_procedure func_name OPEN_PAREN CLOSE_PAREN
   ;

event_trigger_when_list
   : event_trigger_when_item (AND event_trigger_when_item)*
   ;

event_trigger_when_item
   : colid IN_P OPEN_PAREN event_trigger_value_list CLOSE_PAREN
   ;

event_trigger_value_list
   : sconst (COMMA sconst)*
   ;

altereventtrigstmt
   : ALTER EVENT TRIGGER name enable_trigger
   ;

enable_trigger
   : ENABLE_P
   | ENABLE_P REPLICA
   | ENABLE_P ALWAYS
   | DISABLE_P
   ;

createassertionstmt
   : CREATE ASSERTION any_name CHECK OPEN_PAREN a_expr CLOSE_PAREN constraintattributespec
   ;

definestmt
   : CREATE opt_or_replace? AGGREGATE func_name aggr_args definition
   | CREATE opt_or_replace? AGGREGATE func_name old_aggr_definition
   | CREATE OPERATOR any_operator definition
   | CREATE TYPE_P any_name definition
   | CREATE TYPE_P any_name
   | CREATE TYPE_P any_name AS OPEN_PAREN opttablefuncelementlist? CLOSE_PAREN
   | CREATE TYPE_P any_name AS ENUM_P OPEN_PAREN opt_enum_val_list? CLOSE_PAREN
   | CREATE TYPE_P any_name AS RANGE definition
   | CREATE TEXT_P SEARCH PARSER any_name definition
   | CREATE TEXT_P SEARCH DICTIONARY any_name definition
   | CREATE TEXT_P SEARCH TEMPLATE any_name definition
   | CREATE TEXT_P SEARCH CONFIGURATION any_name definition
   | CREATE COLLATION any_name definition
   | CREATE COLLATION IF_P NOT EXISTS any_name definition
   | CREATE COLLATION any_name FROM any_name
   | CREATE COLLATION IF_P NOT EXISTS any_name FROM any_name
   ;

definition
   : OPEN_PAREN def_list CLOSE_PAREN
   ;

def_list
   : def_elem (COMMA def_elem)*
   ;

def_elem
   : collabel (EQUAL def_arg)?
   ;

def_arg
   : func_type
   | reserved_keyword
   | qual_all_op
   | numericonly
   | sconst
   | NONE
   ;

old_aggr_definition
   : OPEN_PAREN old_aggr_list CLOSE_PAREN
   ;

old_aggr_list
   : old_aggr_elem (COMMA old_aggr_elem)*
   ;

old_aggr_elem
   : identifier EQUAL def_arg
   ;

opt_enum_val_list
   : enum_val_list
   ;

enum_val_list
   : sconst (COMMA sconst)*
   ;

alterenumstmt
   : ALTER TYPE_P any_name ADD_P VALUE_P opt_if_not_exists? sconst
   | ALTER TYPE_P any_name ADD_P VALUE_P opt_if_not_exists? sconst BEFORE sconst
   | ALTER TYPE_P any_name ADD_P VALUE_P opt_if_not_exists? sconst AFTER sconst
   | ALTER TYPE_P any_name RENAME VALUE_P sconst TO sconst
   ;

opt_if_not_exists
   : IF_P NOT EXISTS
   ;

createopclassstmt
   : CREATE OPERATOR CLASS any_name opt_default? FOR TYPE_P typename USING name opt_opfamily? AS opclass_item_list
   ;

opclass_item_list
   : opclass_item (COMMA opclass_item)*
   ;

opclass_item
   : OPERATOR iconst any_operator opclass_purpose? opt_recheck?
   | OPERATOR iconst operator_with_argtypes opclass_purpose? opt_recheck?
   | FUNCTION iconst function_with_argtypes
   | FUNCTION iconst OPEN_PAREN type_list CLOSE_PAREN function_with_argtypes
   | STORAGE typename
   ;

opt_default
   : DEFAULT
   ;

opt_opfamily
   : FAMILY any_name
   ;

opclass_purpose
   : FOR SEARCH
   | FOR ORDER BY any_name
   ;

opt_recheck
   : RECHECK
   ;

createopfamilystmt
   : CREATE OPERATOR FAMILY any_name USING name
   ;

alteropfamilystmt
   : ALTER OPERATOR FAMILY any_name USING name ADD_P opclass_item_list
   | ALTER OPERATOR FAMILY any_name USING name DROP opclass_drop_list
   ;

opclass_drop_list
   : opclass_drop (COMMA opclass_drop)*
   ;

opclass_drop
   : OPERATOR iconst OPEN_PAREN type_list CLOSE_PAREN
   | FUNCTION iconst OPEN_PAREN type_list CLOSE_PAREN
   ;

dropopclassstmt
   : DROP OPERATOR CLASS any_name USING name opt_drop_behavior?
   | DROP OPERATOR CLASS IF_P EXISTS any_name USING name opt_drop_behavior?
   ;

dropopfamilystmt
   : DROP OPERATOR FAMILY any_name USING name opt_drop_behavior?
   | DROP OPERATOR FAMILY IF_P EXISTS any_name USING name opt_drop_behavior?
   ;

dropownedstmt
   : DROP OWNED BY role_list opt_drop_behavior?
   ;

reassignownedstmt
   : REASSIGN OWNED BY role_list TO rolespec
   ;

dropstmt
   : DROP object_type_any_name IF_P EXISTS any_name_list opt_drop_behavior?
   | DROP object_type_any_name any_name_list opt_drop_behavior?
   | DROP drop_type_name IF_P EXISTS name_list opt_drop_behavior?
   | DROP drop_type_name name_list opt_drop_behavior?
   | DROP object_type_name_on_any_name name ON any_name opt_drop_behavior?
   | DROP object_type_name_on_any_name IF_P EXISTS name ON any_name opt_drop_behavior?
   | DROP TYPE_P type_name_list opt_drop_behavior?
   | DROP TYPE_P IF_P EXISTS type_name_list opt_drop_behavior?
   | DROP DOMAIN_P type_name_list opt_drop_behavior?
   | DROP DOMAIN_P IF_P EXISTS type_name_list opt_drop_behavior?
   | DROP INDEX CONCURRENTLY any_name_list opt_drop_behavior?
   | DROP INDEX CONCURRENTLY IF_P EXISTS any_name_list opt_drop_behavior?
   ;

object_type_any_name
   : TABLE
   | SEQUENCE
   | VIEW
   | MATERIALIZED VIEW
   | INDEX
   | FOREIGN TABLE
   | COLLATION
   | CONVERSION_P
   | STATISTICS
   | TEXT_P SEARCH PARSER
   | TEXT_P SEARCH DICTIONARY
   | TEXT_P SEARCH TEMPLATE
   | TEXT_P SEARCH CONFIGURATION
   ;

object_type_name
   : drop_type_name
   | SCHEMA
   | DATABASE
   | ROLE
   | SUBSCRIPTION
   | TABLESPACE
   ;

drop_type_name
   : ACCESS METHOD
   | EVENT TRIGGER
   | EXTENSION
   | FOREIGN DATA_P WRAPPER
   | opt_procedural? LANGUAGE
   | PUBLICATION
   | SERVER
   ;

object_type_name_on_any_name
   : POLICY
   | RULE
   | TRIGGER
   ;

any_name_list
   : any_name (COMMA any_name)*
   ;

any_name
   : colid attrs?
   ;

attrs
   :(DOT attr_name)+
   ;

type_name_list
   : typename (COMMA typename)*
   ;

truncatestmt
   : TRUNCATE opt_table? relation_expr_list opt_restart_seqs? opt_drop_behavior?
   ;

opt_restart_seqs
   : CONTINUE_P IDENTITY_P
   | RESTART IDENTITY_P
   ;

commentstmt
   : COMMENT ON object_type_any_name any_name IS comment_text
   | COMMENT ON COLUMN any_name IS comment_text
   | COMMENT ON object_type_name name IS comment_text
   | COMMENT ON TYPE_P typename IS comment_text
   | COMMENT ON DOMAIN_P typename IS comment_text
   | COMMENT ON AGGREGATE aggregate_with_argtypes IS comment_text
   | COMMENT ON FUNCTION function_with_argtypes IS comment_text
   | COMMENT ON OPERATOR operator_with_argtypes IS comment_text
   | COMMENT ON CONSTRAINT name ON any_name IS comment_text
   | COMMENT ON CONSTRAINT name ON DOMAIN_P any_name IS comment_text
   | COMMENT ON object_type_name_on_any_name name ON any_name IS comment_text
   | COMMENT ON PROCEDURE function_with_argtypes IS comment_text
   | COMMENT ON ROUTINE function_with_argtypes IS comment_text
   | COMMENT ON TRANSFORM FOR typename LANGUAGE name IS comment_text
   | COMMENT ON OPERATOR CLASS any_name USING name IS comment_text
   | COMMENT ON OPERATOR FAMILY any_name USING name IS comment_text
   | COMMENT ON LARGE_P OBJECT_P numericonly IS comment_text
   | COMMENT ON CAST OPEN_PAREN typename AS typename CLOSE_PAREN IS comment_text
   ;

comment_text
   : sconst
   | NULL_P
   ;

seclabelstmt
   : SECURITY LABEL opt_provider? ON object_type_any_name any_name IS security_label
   | SECURITY LABEL opt_provider? ON COLUMN any_name IS security_label
   | SECURITY LABEL opt_provider? ON object_type_name name IS security_label
   | SECURITY LABEL opt_provider? ON TYPE_P typename IS security_label
   | SECURITY LABEL opt_provider? ON DOMAIN_P typename IS security_label
   | SECURITY LABEL opt_provider? ON AGGREGATE aggregate_with_argtypes IS security_label
   | SECURITY LABEL opt_provider? ON FUNCTION function_with_argtypes IS security_label
   | SECURITY LABEL opt_provider? ON LARGE_P OBJECT_P numericonly IS security_label
   | SECURITY LABEL opt_provider? ON PROCEDURE function_with_argtypes IS security_label
   | SECURITY LABEL opt_provider? ON ROUTINE function_with_argtypes IS security_label
   ;

opt_provider
   : FOR nonreservedword_or_sconst
   ;

security_label
   : sconst
   | NULL_P
   ;

fetchstmt
   : FETCH fetch_args
   ;

fetch_args
   : NEXT FROM cursor_name
   | ALL FROM cursor_name
   | FORWARD (signediconst | ALL)? FROM cursor_name
   | FROM cursor_name
   ;

grantstmt
   : common_grant
   | grant_column_level_permissions
   | grant_assume_role_permissions
   | grant_spectrum_integration_permissions
   | grant_datashare_permissions
   | grant_scoped_permissions
   | grant_machine_learning_permissions
   | grant_role_permissions
   | grant_explain_permissions_for_row_level_security_policy_filters
   | grant_permissions_for_rls_lookup_tables
   ;

grant_permissions_for_rls_lookup_tables
   : GRANT SELECT ON TABLE? qualified_name_list TO RLS POLICY columnlist
   ;

grant_explain_permissions_for_row_level_security_policy_filters
   : GRANT (EXPLAIN | IGNORE) RLS TO ROLE rolespec
   ;

grant_machine_learning_permissions
   : GRANT CREATE MODEL TO grantee_list
   | GRANT function_privilege_list ON MODEL columnlist TO grantee_list
   ;

grant_role_permissions
   : GRANT ROLE rolespec (COMMA ROLE rolespec)* TO grant_role_permission_target_list
   | GRANT system_permissions TO ROLE role_list
   ;

grant_role_permission_target_list
   : grant_role_permission_target_list_item (COMMA grant_role_permission_target_list_item)*
   ;

grant_role_permission_target_list_item
   : rolespec opt_with_admin_option?
   | ROLE rolespec
   ;

system_permissions
   : system_permissions_item (COMMA system_permissions_item)*
   | all_privileges
   ;

system_permissions_item
   : (CREATE | DROP | ALTER) USER
   | (CREATE | DROP) SCHEMA
   | ALTER DEFAULT PRIVILEGES
   | ACCESS (CATALOG | (SYSTEM_P TABLE))
   | (CREATE | DROP | ALTER) TABLE
   | CREATE OR REPLACE (FUNCTION | (EXTERNAL FUNCTION))
   | DROP FUNCTION
   | ((CREATE OR REPLACE) | DROP) PROCEDURE
   | ((CREATE OR REPLACE) | DROP) VIEW
   | (CREATE | DROP) MODEL
   | (CREATE | ALTER | DROP) DATASHARE
   | (CREATE | DROP) LIBRARY
   | (CREATE | DROP) ROLE
   | TRUNCATE TABLE
   | VACUUM | ANALYZE | CANCEL
   | (IGNORE | EXPLAIN) RLS
   | EXPLAIN MASKING
   ;

opt_with_admin_option
   : WITH ADMIN OPTION
   ;

grant_scoped_permissions
   : grant_scoped_schemas_permissions
   | grant_scoped_tables_permissions
   | grant_scoped_functions_permissions
   | grant_scoped_procedures_permissions
   | grant_scoped_languages_permissions
   | grant_scoped_copy_jobs_permissions
   ;

grant_scoped_schemas_permissions
   : GRANT schema_privilege_list FOR SCHEMAS IN_P DATABASE colid TO grantee_list_without_public
   ;

grant_scoped_tables_permissions
   : GRANT table_privilege_list FOR TABLES IN_P ((SCHEMA colid (DATABASE colid)?) | (DATABASE colid) ) TO grantee_list_without_public
   ;

grant_scoped_functions_permissions
   : GRANT function_privilege_list FOR FUNCTIONS IN_P ((SCHEMA colid (DATABASE colid)?) | (DATABASE colid) ) TO grantee_list_without_public
   ;

grant_scoped_procedures_permissions
   : GRANT procedure_privilege_list FOR PROCEDURES IN_P ((SCHEMA colid (DATABASE colid)?) | (DATABASE colid) ) TO grantee_list_without_public
   ;

grant_scoped_languages_permissions
    : GRANT language_privilege_list FOR LANGUAGES IN_P DATABASE colid TO grantee_list_without_public
    ;

grant_scoped_copy_jobs_permissions
    : GRANT copy_job_privilege_list FOR COPY JOBS IN_P ((SCHEMA colid (DATABASE colid)?) | (DATABASE colid) ) TO grantee_list_without_public
    ;

grantee_list_without_public
   : grantee_without_public (COMMA grantee_without_public)*
   ;

grantee_without_public
   : rolespec opt_with_grant_option?
   | ROLE rolespec
   ;

grant_datashare_permissions
   : GRANT (ALTER | SHARE) ON DATASHARE colid TO grantee_list
   | GRANT USAGE ON DATASHARE colid TO ((NAMESPACE sconst) | (ACCOUNT sconst (VIA DATA_P CATALOG)?))
   | GRANT USAGE ON (DATABASE columnlist | SCHEMA colid) TO grantee_list
   ;

grant_spectrum_integration_permissions
    : grant_spectrum_integration_extenral_column_permissions
    | grant_spectrum_integration_external_table_permissions
    | grant_spectrum_integration_external_schema_permissions
    ;

grant_spectrum_integration_external_schema_permissions
   : GRANT spectrum_integration_external_schema_permission_list ON EXTERNAL SCHEMA columnlist TO iamrolelist_or_public opt_with_grant_option?
   ;

spectrum_integration_external_schema_permission_list
   : spectrum_integration_external_schema_permission (COMMA spectrum_integration_external_schema_permission)*
   | all_privileges
   ;

spectrum_integration_external_schema_permission
   : CREATE
   | ALTER
   | DROP
   ;

grant_spectrum_integration_external_table_permissions
   : GRANT spectrum_integration_external_table_permission_list ON EXTERNAL TABLE qualified_name_list TO iamrolelist_or_public opt_with_grant_option?
   ;

spectrum_integration_external_table_permission
   : SELECT | ALTER | DROP | DELETE_P | INSERT
   | all_privileges
   ;

spectrum_integration_external_table_permission_list
   : spectrum_integration_external_table_permission (COMMA spectrum_integration_external_table_permission)*
   ;


grant_spectrum_integration_extenral_column_permissions
   : GRANT (SELECT | all_privileges) OPEN_PAREN columnlist CLOSE_PAREN ON EXTERNAL TABLE qualified_name TO iamrolelist_or_public opt_with_grant_option?
   ;

iamrolelist_or_public
   : iamrolelist
   | PUBLIC
   ;

iamrolelist
   : IAM_ROLE iamrolevalue (COMMA IAM_ROLE iamrolevalue)*
   ;

grant_assume_role_permissions
   : GRANT ASSUMEROLE grant_assume_role_target TO grantee_list FOR grant_assume_role_for_list
   ;

grant_assume_role_for_list
   : grant_assume_role_for_item (COMMA grant_assume_role_for_item)*
   ;

grant_assume_role_for_item
   : ALL
   | COPY
   | UNLOAD
   | EXTERNAL FUNCTION
   | CREATE MODEL
   ;

grant_assume_role_target
   : sconst (COMMA sconst)* | DEFAULT | ALL
   ;

grant_column_level_permissions
   : GRANT column_privilege_list ON column_privilege_target TO grantee_list
   ;

column_privilege_target
   : TABLE? qualified_name_list
   ;

column_privilege_list
   : column_select_update_privilege (COMMA column_select_update_privilege)*
   | column_all_privilege (COMMA column_all_privilege)*
   ;

column_all_privilege
   : ALL PRIVILEGES? OPEN_PAREN columnlist? CLOSE_PAREN
   ;

column_select_update_privilege
   : (SELECT | UPDATE) OPEN_PAREN columnlist? CLOSE_PAREN
   ;

common_grant
   : GRANT table_privilege_list ON grant_table_target TO grantee_list
   | GRANT database_privilege_list ON grant_database_target TO grantee_list
   | GRANT schema_privilege_list ON grant_schema_target TO grantee_list
   | GRANT function_privilege_list ON grant_function_target TO grantee_list
   | GRANT procedure_privilege_list ON grant_procedure_target TO grantee_list
   | GRANT language_privilege_list ON grant_language_target TO grantee_list
   | GRANT copy_job_privilege_list ON copy_job_target TO grantee_list
   ;

copy_job_privilege_list
    : copy_job_privilege (COMMA copy_job_privilege)*
    | all_privileges
    ;

copy_job_privilege
    : ALTER
    | DROP
    ;

copy_job_target
    : COPY JOB copy_job_name (COMMA copy_job_name)*
    ;

copy_job_name
    : colid
    ;

language_privilege_list
   : USAGE
   ;

grant_language_target
    : LANGUAGE columnlist
    ;

grant_procedure_target
    : PROCEDURE function_with_argtypes_list (COMMA function_with_argtypes_list)*
    | ALL PROCEDURES IN_P SCHEMA columnlist
    ;

procedure_privilege_list
    : procedure_privilege
    | all_privileges
    ;

procedure_privilege
    : EXECUTE
    | all_privileges
    ;

function_privilege_list
    : function_privilege
    | all_privileges
    ;

function_privilege
    : EXECUTE
    | all_privileges
    ;

grant_function_target
    : FUNCTION function_with_argtypes_list (COMMA function_with_argtypes_list)*
    | ALL FUNCTIONS IN_P SCHEMA columnlist
    ;

grant_schema_target
    : SCHEMA colid (COMMA colid)*
    ;

revoke_schema_target
    : SCHEMA (IF_P EXISTS)? colid (COMMA colid)*
    ;

schema_privilege_list
    : schema_privilege (COMMA schema_privilege)*
    | all_privileges
    ;

schema_privilege
   : CREATE
   | USAGE
   | ALTER
   | DROP
   ;

database_privilege_list
   : database_privilege (COMMA database_privilege)*
   | all_privileges
   ;

database_privilege
   : CREATE
   | USAGE
   | TEMPORARY
   | TEMP
   | ALTER
   ;

grant_database_target
    : DATABASE colid (COMMA colid)*
    ;


grant_table_target
    : TABLE? qualified_name_list
    | all_tables_in_schema_list
    ;

revoke_table_target
    : TABLE? (IF_P EXISTS)? qualified_name_list
    | all_tables_in_schema_list
    ;

all_tables_in_schema_list
    : ALL TABLES IN_P SCHEMA qualified_name_list
    ;

all_privileges
   : ALL PRIVILEGES?
   ;

grantee_list
   : grantee (COMMA grantee)*
   ;

grantee
   : rolespec opt_with_grant_option?
   | GROUP_P rolespec
   | ROLE rolespec
   | PUBLIC
   ;

opt_with_grant_option
   : WITH GRANT OPTION
   ;

table_privilege
   : SELECT
   | INSERT
   | UPDATE
   | DELETE_P
   | DROP
   | ALTER
   | TRUNCATE
   | REFERENCES
   ;

table_privilege_list
    : table_privilege (COMMA table_privilege)*
    | all_privileges
    ;

revokestmt
   : common_revoke
   | revoke_column_level_permissions
   | revoke_assume_role_permissions
   | revoke_spectrum_integration_permissions
   | revoke_datashare_permissions
   | revoke_scoped_permissions
   | revoke_machine_learning_permissions
   | revoke_role_permissions
   | revoke_explain_permissions_for_row_level_security_policy_filters
   | revoke_permissions_for_rls_lookup_tables
   ;

revoke_permissions_for_rls_lookup_tables
   : REVOKE SELECT ON TABLE? qualified_name_list FROM RLS POLICY columnlist opt_drop_behavior?
   ;

revoke_explain_permissions_for_row_level_security_policy_filters
   : REVOKE (EXPLAIN | IGNORE) RLS FROM ROLE rolespec opt_drop_behavior?
   ;

revoke_machine_learning_permissions
   : REVOKE CREATE MODEL FROM grantee_list opt_drop_behavior?
   | REVOKE function_privilege_list ON MODEL columnlist FROM grantee_list opt_drop_behavior?
   ;

revoke_role_permissions
   : REVOKE ROLE rolespec (COMMA ROLE rolespec)* FROM grant_role_permission_target_list opt_drop_behavior?
   | REVOKE system_permissions FROM ROLE role_list opt_drop_behavior?
   | REVOKE ADMIN OPTION FOR ROLE rolespec (COMMA ROLE rolespec)* FROM grant_role_permission_target_list opt_drop_behavior?
   ;

revoke_scoped_permissions
   : revoke_scoped_schemas_permissions
   | revoke_scoped_tables_permissions
   | revoke_scoped_functions_permissions
   | revoke_scoped_procedures_permissions
   | revoke_scoped_languages_permissions
   | revoke_scoped_copy_jobs_permissions
   ;

revoke_scoped_schemas_permissions
   : REVOKE schema_privilege_list FOR SCHEMAS IN_P DATABASE colid FROM grantee_list_without_public opt_drop_behavior?
   ;

revoke_scoped_tables_permissions
   : REVOKE table_privilege_list FOR TABLES IN_P ((SCHEMA colid (DATABASE colid)?) | (DATABASE colid) ) FROM grantee_list_without_public opt_drop_behavior?
   ;

revoke_scoped_functions_permissions
   : REVOKE function_privilege_list FOR FUNCTIONS IN_P ((SCHEMA colid (DATABASE colid)?) | (DATABASE colid) ) FROM grantee_list_without_public opt_drop_behavior?
   ;

revoke_scoped_procedures_permissions
   : REVOKE procedure_privilege_list FOR PROCEDURES IN_P ((SCHEMA colid (DATABASE colid)?) | (DATABASE colid) ) FROM grantee_list_without_public opt_drop_behavior?
   ;

revoke_scoped_languages_permissions
    : REVOKE language_privilege_list FOR LANGUAGES IN_P DATABASE colid FROM grantee_list_without_public opt_drop_behavior?
    ;

revoke_scoped_copy_jobs_permissions
    : REVOKE copy_job_privilege_list FOR COPY JOBS IN_P ((SCHEMA colid (DATABASE colid)?) | (DATABASE colid) ) FROM grantee_list_without_public opt_drop_behavior?
    ;

revoke_datashare_permissions
   : REVOKE (GRANT OPTION FOR)? (ALTER | SHARE) ON DATASHARE colid FROM grantee_list opt_drop_behavior?
   | REVOKE (GRANT OPTION FOR)? USAGE ON DATASHARE colid FROM ((NAMESPACE sconst) | (ACCOUNT sconst (VIA DATA_CATALOG)?)) opt_drop_behavior?
   | REVOKE (GRANT OPTION FOR)? USAGE ON (DATABASE columnlist | SCHEMA colid) FROM grantee_list opt_drop_behavior?
   ;

revoke_spectrum_integration_permissions
    : revoke_spectrum_integration_extenral_column_permissions
    | revoke_spectrum_integration_external_table_permissions
    | revoke_spectrum_integration_external_schema_permissions
    ;

revoke_spectrum_integration_external_schema_permissions
   : REVOKE spectrum_integration_external_schema_permission_list ON EXTERNAL SCHEMA columnlist FROM iamrolelist opt_drop_behavior?
   ;

revoke_spectrum_integration_external_table_permissions
   : REVOKE spectrum_integration_external_table_permission_list ON EXTERNAL TABLE qualified_name_list FROM iamrolelist_or_public opt_drop_behavior?
   ;

revoke_spectrum_integration_extenral_column_permissions
   : REVOKE (SELECT | all_privileges) OPEN_PAREN columnlist CLOSE_PAREN ON EXTERNAL TABLE qualified_name FROM iamrolelist opt_drop_behavior?
   ;

revoke_assume_role_permissions
   : REVOKE ASSUMEROLE grant_assume_role_target FROM grantee_list FOR grant_assume_role_for_list opt_drop_behavior?
   ;

revoke_column_level_permissions
   : REVOKE column_privilege_list ON column_privilege_target FROM grantee_list opt_drop_behavior?
   | REVOKE GRANT OPTION FOR column_privilege_list ON column_privilege_target FROM grantee_list opt_drop_behavior?
   ;

common_revoke
   : REVOKE (GRANT OPTION FOR)? table_privilege_list ON revoke_table_target FROM grantee_list opt_drop_behavior?
   | REVOKE (GRANT OPTION FOR)? database_privilege_list ON grant_database_target FROM grantee_list opt_drop_behavior?
   | REVOKE (GRANT OPTION FOR)? schema_privilege_list ON revoke_schema_target FROM grantee_list opt_drop_behavior?
   | REVOKE (GRANT OPTION FOR)? function_privilege_list ON grant_function_target FROM grantee_list opt_drop_behavior?
   | REVOKE (GRANT OPTION FOR)? procedure_privilege_list ON grant_procedure_target FROM grantee_list opt_drop_behavior?
   | REVOKE (GRANT OPTION FOR)? language_privilege_list ON grant_language_target FROM grantee_list opt_drop_behavior?
   | REVOKE (GRANT OPTION FOR)? copy_job_privilege_list ON copy_job_target FROM grantee_list opt_drop_behavior?
   ;

privileges
   : privilege_list
   | ALL
   | ALL PRIVILEGES
   | ALL OPEN_PAREN columnlist CLOSE_PAREN
   | ALL PRIVILEGES OPEN_PAREN columnlist CLOSE_PAREN
   ;

privilege_list
   : privilege (COMMA privilege)*
   ;

privilege
   : SELECT opt_column_list?
   | REFERENCES opt_column_list?
   | CREATE opt_column_list?
   | ALTER SYSTEM_P
   | colid opt_column_list?
   ;

privilege_target
   : qualified_name_list
   | TABLE qualified_name_list
   | SEQUENCE qualified_name_list
   | FOREIGN DATA_P WRAPPER name_list
   | FOREIGN SERVER name_list
   | FUNCTION function_with_argtypes_list
   | PROCEDURE function_with_argtypes_list
   | ROUTINE function_with_argtypes_list
   | DATABASE name_list
   | DOMAIN_P any_name_list
   | LANGUAGE name_list
   | LARGE_P OBJECT_P numericonly_list
   | PARAMETER parameter_name_list
   | SCHEMA name_list
   | TABLESPACE name_list
   | TYPE_P any_name_list
   | ALL TABLES IN_P SCHEMA name_list
   | ALL SEQUENCES IN_P SCHEMA name_list
   | ALL FUNCTIONS IN_P SCHEMA name_list
   | ALL PROCEDURES IN_P SCHEMA name_list
   | ALL ROUTINES IN_P SCHEMA name_list
   ;
   
parameter_name_list
   : parameter_name (COMMA parameter_name)*
   ;
   
parameter_name
   : colid (DOT colid)?
   ;

opt_grant_grant_option
   : WITH GRANT OPTION
   ;

grantrolestmt
   : GRANT privilege_list TO role_list opt_grant_admin_option? opt_granted_by?
   ;

revokerolestmt
   : REVOKE privilege_list FROM role_list opt_granted_by? opt_drop_behavior?
   | REVOKE ADMIN OPTION FOR privilege_list FROM role_list opt_granted_by? opt_drop_behavior?
   ;

opt_grant_admin_option
   : WITH ADMIN OPTION
   ;

opt_granted_by
   : GRANTED BY rolespec
   ;

alterdefaultprivilegesstmt
   : ALTER DEFAULT PRIVILEGES defacloptionlist defaclaction
   ;

defacloptionlist
   : defacloption*
   ;

defacloption
   : IN_P SCHEMA name_list
   | FOR ROLE role_list
   | FOR USER role_list
   ;

defaclaction
   : GRANT privileges ON defacl_privilege_target TO grantee_list opt_grant_grant_option?
   | REVOKE privileges ON defacl_privilege_target FROM grantee_list opt_drop_behavior?
   | REVOKE GRANT OPTION FOR privileges ON defacl_privilege_target FROM grantee_list opt_drop_behavior?
   ;

defacl_privilege_target
   : TABLES
   | FUNCTIONS
   | PROCEDURES
   | ROUTINES
   | SEQUENCES
   | TYPES_P
   | SCHEMAS
   ;
   //create index

indexstmt
   : CREATE opt_unique? INDEX opt_concurrently? ((IF_P NOT EXISTS)? name)? ON relation_expr access_method_clause? OPEN_PAREN index_params CLOSE_PAREN opt_include? opt_unique_null_treatment? opt_reloptions? opttablespace? where_clause?
   ;

opt_unique
   : UNIQUE
   ;

opt_concurrently
   : CONCURRENTLY
   ;

opt_index_name
   : name
   ;

access_method_clause
   : USING name
   ;

index_params
   : index_elem (COMMA index_elem)*
   ;

index_elem_options
   : opt_collate? opt_class? opt_asc_desc? opt_nulls_order?
   | opt_collate? any_name reloptions opt_asc_desc? opt_nulls_order?
   ;

index_elem
   : colid index_elem_options
   | func_expr_windowless index_elem_options
   | OPEN_PAREN a_expr CLOSE_PAREN index_elem_options
   ;

opt_include
   : INCLUDE OPEN_PAREN index_including_params CLOSE_PAREN
   ;

index_including_params
   : index_elem (COMMA index_elem)*
   ;

opt_collate
   : COLLATE any_name
   ;

opt_class
   : any_name
   ;

opt_asc_desc
   : ASC
   | DESC
   ;
   //TOD NULLS_LA was used

opt_nulls_order
   : NULLS_P FIRST_P
   | NULLS_P LAST_P
   ;

createfunctionstmt
   : CREATE opt_or_replace? FUNCTION func_name func_py_args_or_sql_args
     (
        RETURNS (func_return | TABLE OPEN_PAREN table_func_column_list CLOSE_PAREN)
     )?
     (VOLATILE | STABLE | IMMUTABLE)
     createfunc_opt_list
   ;

createprocedurestmt
   : CREATE opt_or_replace? PROCEDURE func_name func_args
    (
            RETURNS (func_return | TABLE OPEN_PAREN table_func_column_list CLOSE_PAREN)
    )?
    opt_nonatomic?
    createfunc_opt_list;

opt_nonatomic
   : NONATOMIC
   ;

opt_or_replace
   : OR REPLACE
   ;

func_py_args_or_sql_args
   : OPEN_PAREN func_py_args_or_sql_args_list? CLOSE_PAREN
   ;

func_py_args_or_sql_args_list
   : param_name func_type (COMMA param_name func_type)*
   | func_type (COMMA func_type)*
   ;

func_args
   : OPEN_PAREN func_args_list? CLOSE_PAREN
   ;

func_args_list
   : func_arg (COMMA func_arg)*
   ;

function_with_argtypes_list
   : function_with_argtypes (COMMA function_with_argtypes)*
   ;

function_with_argtypes
   : func_name func_args
   | type_func_name_keyword
   | colid indirection?
   ;

func_args_with_defaults
   : OPEN_PAREN func_args_with_defaults_list? CLOSE_PAREN
   ;

func_args_with_defaults_list
   : func_arg_with_default (COMMA func_arg_with_default)*
   ;

func_arg
   : arg_class param_name? func_type
   | param_name arg_class? func_type
   | func_type
   ;

arg_class
   : IN_P
   | OUT_P
   | INOUT
   ;

param_name
   : type_function_name
   | builtin_function_name
   | LEFT
   | RIGHT
   ;

func_return
   : func_type
   ;

func_type
   : typename
   | SETOF? (builtin_function_name | type_function_name | LEFT | RIGHT) attrs PERCENT TYPE_P
   ;

func_arg_with_default
   : func_arg ((DEFAULT | EQUAL) a_expr)?
   ;

aggr_arg
   : func_arg
   ;

aggr_args
   : OPEN_PAREN (STAR | aggr_args_list | ORDER BY aggr_args_list | aggr_args_list ORDER BY aggr_args_list) CLOSE_PAREN
   ;

aggr_args_list
   : aggr_arg (COMMA aggr_arg)*
   ;

aggregate_with_argtypes
   : func_name aggr_args
   ;

aggregate_with_argtypes_list
   : aggregate_with_argtypes (COMMA aggregate_with_argtypes)*
   ;

createfunc_opt_list
   : createfunc_opt_item+
   {
                p.ParseRoutineBody(localctx);
            }
   //                    | createfunc_opt_list createfunc_opt_item

   ;

common_func_opt_item
   : CALLED ON NULL_P INPUT_P
   | RETURNS NULL_P ON NULL_P INPUT_P
   | STRICT_P
   | IMMUTABLE
   | STABLE
   | VOLATILE
   | EXTERNAL SECURITY DEFINER
   | EXTERNAL SECURITY INVOKER
   | SECURITY DEFINER
   | SECURITY INVOKER
   | LEAKPROOF
   | NOT LEAKPROOF
   | COST numericonly
   | ROWS numericonly
   | SUPPORT any_name
   | functionsetresetclause
   | PARALLEL colid
   ;

createfunc_opt_item
   : AS func_as
   | BEGIN_P ATOMIC_P stmtmulti END_P
   | LANGUAGE nonreservedword_or_sconst
   | TRANSFORM transform_type_list
   | WINDOW
   | common_func_opt_item
   ;
   //https://www.postgresql.org/docs/9.1/sql-createfunction.html

   //    | AS 'definition'

   //    | AS 'obj_file', 'link_symbol'

func_as locals[antlr.ParserRuleContext Definition]
   :
   /* |AS 'definition'*/
   def = sconst
   /*| AS 'obj_file', 'link_symbol'*/
   | sconst COMMA sconst
   ;

transform_type_list
   :FOR TYPE_P typename (COMMA FOR TYPE_P typename)*
   ;

opt_definition
   : WITH definition
   ;

table_func_column
   : param_name func_type
   ;

table_func_column_list
   : table_func_column (COMMA table_func_column)*
   ;

alterfunctionstmt
   : ALTER FUNCTION func_name func_py_args_or_sql_args ((RENAME TO func_name) | (OWNER TO rolespec))
   ;

alterprocedurestmt
   : ALTER PROCEDURE func_name func_args ((RENAME TO func_name) | (OWNER TO rolespec))
   ;

alterfunc_opt_list
   : common_func_opt_item+
   ;

opt_restrict
   : RESTRICT
   ;

removefuncstmt
   : DROP FUNCTION function_with_argtypes_list opt_drop_behavior?
   | DROP FUNCTION IF_P EXISTS function_with_argtypes_list opt_drop_behavior?
   | DROP PROCEDURE function_with_argtypes_list opt_drop_behavior?
   | DROP PROCEDURE IF_P EXISTS function_with_argtypes_list opt_drop_behavior?
   | DROP ROUTINE function_with_argtypes_list opt_drop_behavior?
   | DROP ROUTINE IF_P EXISTS function_with_argtypes_list opt_drop_behavior?
   ;

removeaggrstmt
   : DROP AGGREGATE aggregate_with_argtypes_list opt_drop_behavior?
   | DROP AGGREGATE IF_P EXISTS aggregate_with_argtypes_list opt_drop_behavior?
   ;

removeoperstmt
   : DROP OPERATOR operator_with_argtypes_list opt_drop_behavior?
   | DROP OPERATOR IF_P EXISTS operator_with_argtypes_list opt_drop_behavior?
   ;

oper_argtypes
   : OPEN_PAREN typename CLOSE_PAREN
   | OPEN_PAREN typename COMMA typename CLOSE_PAREN
   | OPEN_PAREN NONE COMMA typename CLOSE_PAREN
   | OPEN_PAREN typename COMMA NONE CLOSE_PAREN
   ;

any_operator
   : (colid DOT)* all_op
   ;

operator_with_argtypes_list
   : operator_with_argtypes (COMMA operator_with_argtypes)*
   ;

operator_with_argtypes
   : any_operator oper_argtypes
   ;

dostmt
   : DO dostmt_opt_list
   ;

dostmt_opt_list
   : dostmt_opt_item+
   ;

dostmt_opt_item
   : sconst
   | LANGUAGE nonreservedword_or_sconst
   ;

createcaststmt
   : CREATE CAST OPEN_PAREN typename AS typename CLOSE_PAREN WITH FUNCTION function_with_argtypes cast_context?
   | CREATE CAST OPEN_PAREN typename AS typename CLOSE_PAREN WITHOUT FUNCTION cast_context?
   | CREATE CAST OPEN_PAREN typename AS typename CLOSE_PAREN WITH INOUT cast_context?
   ;

cast_context
   : AS IMPLICIT_P
   | AS ASSIGNMENT
   ;

dropcaststmt
   : DROP CAST opt_if_exists? OPEN_PAREN typename AS typename CLOSE_PAREN opt_drop_behavior?
   ;

opt_if_exists
   : IF_P EXISTS
   ;

createtransformstmt
   : CREATE opt_or_replace? TRANSFORM FOR typename LANGUAGE name OPEN_PAREN transform_element_list CLOSE_PAREN
   ;

transform_element_list
   : FROM SQL_P WITH FUNCTION function_with_argtypes COMMA TO SQL_P WITH FUNCTION function_with_argtypes
   | TO SQL_P WITH FUNCTION function_with_argtypes COMMA FROM SQL_P WITH FUNCTION function_with_argtypes
   | FROM SQL_P WITH FUNCTION function_with_argtypes
   | TO SQL_P WITH FUNCTION function_with_argtypes
   ;

droptransformstmt
   : DROP TRANSFORM opt_if_exists? FOR typename LANGUAGE name opt_drop_behavior?
   ;

reindexstmt
   : REINDEX reindex_target_type opt_concurrently? qualified_name
   | REINDEX reindex_target_multitable opt_concurrently? name
   | REINDEX OPEN_PAREN reindex_option_list CLOSE_PAREN reindex_target_type opt_concurrently? qualified_name
   | REINDEX OPEN_PAREN reindex_option_list CLOSE_PAREN reindex_target_multitable opt_concurrently? name
   ;

reindex_target_type
   : INDEX
   | TABLE
   | SCHEMA
   | DATABASE
   | SYSTEM_P
   ;

reindex_target_multitable
   : SCHEMA
   | SYSTEM_P
   | DATABASE
   ;

reindex_option_list
   : reindex_option_elem (COMMA reindex_option_elem)*
   ;

reindex_option_elem
   : VERBOSE
   | TABLESPACE
   | CONCURRENTLY
   ;

altertblspcstmt
   : ALTER TABLESPACE name SET reloptions
   | ALTER TABLESPACE name RESET reloptions
   ;

renamestmt
   : ALTER AGGREGATE aggregate_with_argtypes RENAME TO name
   | ALTER COLLATION any_name RENAME TO name
   | ALTER CONVERSION_P any_name RENAME TO name
   | ALTER DATABASE name RENAME TO name
   | ALTER DOMAIN_P any_name RENAME TO name
   | ALTER DOMAIN_P any_name RENAME CONSTRAINT name TO name
   | ALTER FOREIGN DATA_P WRAPPER name RENAME TO name
   | ALTER FUNCTION function_with_argtypes RENAME TO name
   | ALTER GROUP_P roleid RENAME TO roleid
   | ALTER opt_procedural? LANGUAGE name RENAME TO name
   | ALTER OPERATOR CLASS any_name USING name RENAME TO name
   | ALTER OPERATOR FAMILY any_name USING name RENAME TO name
   | ALTER POLICY name ON qualified_name RENAME TO name
   | ALTER POLICY IF_P EXISTS name ON qualified_name RENAME TO name
   | ALTER PROCEDURE function_with_argtypes RENAME TO name
   | ALTER PUBLICATION name RENAME TO name
   | ALTER ROUTINE function_with_argtypes RENAME TO name
   | ALTER SCHEMA name RENAME TO name
   | ALTER SERVER name RENAME TO name
   | ALTER SUBSCRIPTION name RENAME TO name
   | ALTER TABLE relation_expr RENAME TO name
   | ALTER TABLE IF_P EXISTS relation_expr RENAME TO name
   | ALTER SEQUENCE qualified_name RENAME TO name
   | ALTER SEQUENCE IF_P EXISTS qualified_name RENAME TO name
   | ALTER VIEW qualified_name RENAME TO name
   | ALTER VIEW IF_P EXISTS qualified_name RENAME TO name
   | ALTER MATERIALIZED VIEW qualified_name RENAME TO name
   | ALTER MATERIALIZED VIEW IF_P EXISTS qualified_name RENAME TO name
   | ALTER INDEX qualified_name RENAME TO name
   | ALTER INDEX IF_P EXISTS qualified_name RENAME TO name
   | ALTER FOREIGN TABLE relation_expr RENAME TO name
   | ALTER FOREIGN TABLE IF_P EXISTS relation_expr RENAME TO name
   | ALTER TABLE relation_expr RENAME opt_column? name TO name
   | ALTER TABLE IF_P EXISTS relation_expr RENAME opt_column? name TO name
   | ALTER VIEW qualified_name RENAME opt_column? name TO name
   | ALTER VIEW IF_P EXISTS qualified_name RENAME opt_column? name TO name
   | ALTER MATERIALIZED VIEW qualified_name RENAME opt_column? name TO name
   | ALTER MATERIALIZED VIEW IF_P EXISTS qualified_name RENAME opt_column? name TO name
   | ALTER TABLE relation_expr RENAME CONSTRAINT name TO name
   | ALTER TABLE IF_P EXISTS relation_expr RENAME CONSTRAINT name TO name
   | ALTER FOREIGN TABLE relation_expr RENAME opt_column? name TO name
   | ALTER FOREIGN TABLE IF_P EXISTS relation_expr RENAME opt_column? name TO name
   | ALTER RULE name ON qualified_name RENAME TO name
   | ALTER TRIGGER name ON qualified_name RENAME TO name
   | ALTER EVENT TRIGGER name RENAME TO name
   | ALTER ROLE roleid RENAME TO roleid
   | ALTER USER roleid RENAME TO roleid
   | ALTER TABLESPACE name RENAME TO name
   | ALTER STATISTICS any_name RENAME TO name
   | ALTER TEXT_P SEARCH PARSER any_name RENAME TO name
   | ALTER TEXT_P SEARCH DICTIONARY any_name RENAME TO name
   | ALTER TEXT_P SEARCH TEMPLATE any_name RENAME TO name
   | ALTER TEXT_P SEARCH CONFIGURATION any_name RENAME TO name
   | ALTER TYPE_P any_name RENAME TO name
   | ALTER TYPE_P any_name RENAME ATTRIBUTE name TO name opt_drop_behavior?
   ;

opt_column
   : COLUMN
   ;

opt_set_data
   : SET DATA_P
   ;

alterobjectdependsstmt
   : ALTER FUNCTION function_with_argtypes opt_no? DEPENDS ON EXTENSION name
   | ALTER PROCEDURE function_with_argtypes opt_no? DEPENDS ON EXTENSION name
   | ALTER ROUTINE function_with_argtypes opt_no? DEPENDS ON EXTENSION name
   | ALTER TRIGGER name ON qualified_name opt_no? DEPENDS ON EXTENSION name
   | ALTER MATERIALIZED VIEW qualified_name opt_no? DEPENDS ON EXTENSION name
   | ALTER INDEX qualified_name opt_no? DEPENDS ON EXTENSION name
   ;

opt_no
   : NO
   ;

alterobjectschemastmt
   : ALTER AGGREGATE aggregate_with_argtypes SET SCHEMA name
   | ALTER COLLATION any_name SET SCHEMA name
   | ALTER CONVERSION_P any_name SET SCHEMA name
   | ALTER DOMAIN_P any_name SET SCHEMA name
   | ALTER EXTENSION name SET SCHEMA name
   | ALTER FUNCTION function_with_argtypes SET SCHEMA name
   | ALTER OPERATOR operator_with_argtypes SET SCHEMA name
   | ALTER OPERATOR CLASS any_name USING name SET SCHEMA name
   | ALTER OPERATOR FAMILY any_name USING name SET SCHEMA name
   | ALTER PROCEDURE function_with_argtypes SET SCHEMA name
   | ALTER ROUTINE function_with_argtypes SET SCHEMA name
   | ALTER TABLE relation_expr SET SCHEMA name
   | ALTER TABLE IF_P EXISTS relation_expr SET SCHEMA name
   | ALTER STATISTICS any_name SET SCHEMA name
   | ALTER TEXT_P SEARCH PARSER any_name SET SCHEMA name
   | ALTER TEXT_P SEARCH DICTIONARY any_name SET SCHEMA name
   | ALTER TEXT_P SEARCH TEMPLATE any_name SET SCHEMA name
   | ALTER TEXT_P SEARCH CONFIGURATION any_name SET SCHEMA name
   | ALTER SEQUENCE qualified_name SET SCHEMA name
   | ALTER SEQUENCE IF_P EXISTS qualified_name SET SCHEMA name
   | ALTER VIEW qualified_name SET SCHEMA name
   | ALTER VIEW IF_P EXISTS qualified_name SET SCHEMA name
   | ALTER MATERIALIZED VIEW qualified_name SET SCHEMA name
   | ALTER MATERIALIZED VIEW IF_P EXISTS qualified_name SET SCHEMA name
   | ALTER FOREIGN TABLE relation_expr SET SCHEMA name
   | ALTER FOREIGN TABLE IF_P EXISTS relation_expr SET SCHEMA name
   | ALTER TYPE_P any_name SET SCHEMA name
   ;

alteroperatorstmt
   : ALTER OPERATOR operator_with_argtypes SET OPEN_PAREN operator_def_list CLOSE_PAREN
   ;

operator_def_list
   : operator_def_elem (COMMA operator_def_elem)*
   ;

operator_def_elem
   : collabel EQUAL NONE
   | collabel EQUAL operator_def_arg
   ;

operator_def_arg
   : func_type
   | reserved_keyword
   | qual_all_op
   | numericonly
   | sconst
   ;

altertypestmt
   : ALTER TYPE_P any_name SET OPEN_PAREN operator_def_list CLOSE_PAREN
   ;

alterownerstmt
   : ALTER AGGREGATE aggregate_with_argtypes OWNER TO rolespec
   | ALTER COLLATION any_name OWNER TO rolespec
   | ALTER CONVERSION_P any_name OWNER TO rolespec
   | ALTER DATABASE name OWNER TO rolespec
   | ALTER DOMAIN_P any_name OWNER TO rolespec
   | ALTER FUNCTION function_with_argtypes OWNER TO rolespec
   | ALTER opt_procedural? LANGUAGE name OWNER TO rolespec
   | ALTER LARGE_P OBJECT_P numericonly OWNER TO rolespec
   | ALTER OPERATOR operator_with_argtypes OWNER TO rolespec
   | ALTER OPERATOR CLASS any_name USING name OWNER TO rolespec
   | ALTER OPERATOR FAMILY any_name USING name OWNER TO rolespec
   | ALTER PROCEDURE function_with_argtypes OWNER TO rolespec
   | ALTER ROUTINE function_with_argtypes OWNER TO rolespec
   | ALTER SCHEMA name OWNER TO rolespec
   | ALTER TYPE_P any_name OWNER TO rolespec
   | ALTER TABLESPACE name OWNER TO rolespec
   | ALTER STATISTICS any_name OWNER TO rolespec
   | ALTER TEXT_P SEARCH DICTIONARY any_name OWNER TO rolespec
   | ALTER TEXT_P SEARCH CONFIGURATION any_name OWNER TO rolespec
   | ALTER FOREIGN DATA_P WRAPPER name OWNER TO rolespec
   | ALTER SERVER name OWNER TO rolespec
   | ALTER EVENT TRIGGER name OWNER TO rolespec
   | ALTER PUBLICATION name OWNER TO rolespec
   | ALTER SUBSCRIPTION name OWNER TO rolespec
   ;

createpublicationstmt
   : CREATE PUBLICATION name opt_definition?
   | CREATE PUBLICATION name FOR ALL TABLES opt_definition?
   | CREATE PUBLICATION name FOR pub_obj_list opt_definition?
   ;
   
pub_obj_list
   : publication_obj_spec (COMMA publication_obj_spec)*
   ;
   
publication_obj_spec
   : TABLE relation_expr opt_column_list? opt_where_clause?
   | TABLE IN_P SCHEMA (colid | CURRENT_SCHEMA)
   | colid opt_column_list? opt_where_clause?
   | colid indirection opt_column_list? opt_where_clause?
   | relation_expr opt_column_list? opt_where_clause?
   | CURRENT_SCHEMA
   ;

opt_where_clause
   : WHERE OPEN_PAREN a_expr CLOSE_PAREN
   ;

alterpublicationstmt
   : ALTER PUBLICATION name SET definition
   | ALTER PUBLICATION name ADD_P pub_obj_list
   | ALTER PUBLICATION name SET pub_obj_list
   | ALTER PUBLICATION name DROP pub_obj_list
   ;

createsubscriptionstmt
   : CREATE SUBSCRIPTION name CONNECTION sconst PUBLICATION publication_name_list opt_definition?
   ;

publication_name_list
   : publication_name_item (COMMA publication_name_item)*
   ;

publication_name_item
   : collabel
   ;

altersubscriptionstmt
   : ALTER SUBSCRIPTION name SET definition
   | ALTER SUBSCRIPTION name CONNECTION sconst
   | ALTER SUBSCRIPTION name REFRESH PUBLICATION opt_definition?
   | ALTER SUBSCRIPTION name SET PUBLICATION publication_name_list opt_definition?
   | ALTER SUBSCRIPTION name ENABLE_P
   | ALTER SUBSCRIPTION name DISABLE_P
   | ALTER SUBSCRIPTION name SKIP_P definition
   ;

dropsubscriptionstmt
   : DROP SUBSCRIPTION name opt_drop_behavior?
   | DROP SUBSCRIPTION IF_P EXISTS name opt_drop_behavior?
   ;

rulestmt
   : CREATE opt_or_replace? RULE name AS ON event TO qualified_name where_clause? DO opt_instead? ruleactionlist
   ;

ruleactionlist
   : NOTHING
   | ruleactionstmt
   | OPEN_PAREN ruleactionmulti CLOSE_PAREN
   ;

ruleactionmulti
   : ruleactionstmtOrEmpty? (SEMI ruleactionstmtOrEmpty?)*
   ;

ruleactionstmt
   : selectstmt
   | insertstmt
   | updatestmt
   | deletestmt
   | notifystmt
   ;

ruleactionstmtOrEmpty
   : ruleactionstmt
   ;

event
   : SELECT
   | UPDATE
   | DELETE_P
   | INSERT
   ;

opt_instead
   : INSTEAD
   | ALSO
   ;

notifystmt
   : NOTIFY colid notify_payload?
   ;

notify_payload
   : COMMA sconst
   ;

listenstmt
   : LISTEN colid
   ;

unlistenstmt
   : UNLISTEN colid
   | UNLISTEN STAR
   ;

transactionstmt
   : ABORT_P opt_transaction? opt_transaction_chain?
   | BEGIN_P opt_transaction? transaction_mode_list_or_empty?
   | START TRANSACTION transaction_mode_list_or_empty?
   | COMMIT opt_transaction? opt_transaction_chain?
   | END_P opt_transaction? opt_transaction_chain?
   | ROLLBACK opt_transaction? opt_transaction_chain?
   | SAVEPOINT colid
   | RELEASE SAVEPOINT colid
   | RELEASE colid
   | ROLLBACK opt_transaction? TO SAVEPOINT colid
   | ROLLBACK opt_transaction? TO colid
   | PREPARE TRANSACTION sconst
   | COMMIT PREPARED sconst
   | ROLLBACK PREPARED sconst
   ;

opt_transaction
   : WORK
   | TRANSACTION
   ;

transaction_mode_item
   : ISOLATION LEVEL iso_level
   | READ ONLY
   | READ WRITE
   | DEFERRABLE
   | NOT DEFERRABLE
   ;

transaction_mode_list
   : transaction_mode_item (COMMA? transaction_mode_item)*
   ;

transaction_mode_list_or_empty
   : transaction_mode_list
   ;

opt_transaction_chain
   : AND NO? CHAIN
   ;

viewstmt
   : CREATE (OR REPLACE)? opttemp?
    (
          VIEW qualified_name opt_column_list? opt_reloptions?
        | RECURSIVE VIEW qualified_name OPEN_PAREN columnlist CLOSE_PAREN opt_reloptions?
    )
     AS selectstmt opt_check_option? with_no_schema_binding?
   ;

with_no_schema_binding
   : WITH NO SCHEMA BINDING
   ;

opt_check_option
   : WITH (CASCADED | LOCAL)? CHECK OPTION
   ;

loadstmt
   : LOAD file_name
   ;

// ==============================================================================
// REDSHIFT-SPECIFIC STATEMENTS  
// These statements are specific to Amazon Redshift and not part of PostgreSQL
// ==============================================================================

// DATASHARE statements
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

table_name
   : qualified_name
   | temporary_table_name
   ;

temporary_table_name
   : TemporaryIdentifier
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

createdatasharestmt
    : CREATE DATASHARE qualified_name createdatashareoptions?
    ;

createdatashareoptions
    : createdatashareoption (COMMA createdatashareoption)*
    ;

createdatashareoption
    : setpublicaccessibleoption
    | managedbyoption
    ;

setpublicaccessibleoption
    : SET? PUBLICACCESSIBLE (EQUAL? (TRUE_P | FALSE_P))?
    ;

managedbyoption
    : MANAGEDBY ADX
    ;

descdatasharestmt
    : (DESC | DESCRIBE) DATASHARE datashare_name=colid (OF (ACCOUNT account_id=sconst)? NAMESPACE namespace_guid=sconst)?
    ;

dropdatasharestmt
    : DROP DATASHARE opt_if_exists? colid
    ;

// EXTERNAL statements
alterexternalschemastmt
    : ALTER EXTERNAL SCHEMA colid altexternalschemaopts+
    ;

altexternalschemaopts
    : RENAME TO colid
    | OWNER TO colid
    | IAM_ROLE (DEFAULT | SESSION | sconst)
    | AUTHENTICATION (NONE | IAM | MTLS)
    | AUTHENTICATION_ARN sconst
    | SECRET_ARN sconst
    | URI sconst
    ;

alterexternalviewstmt
    : ALTER EXTERNAL VIEW qualified_name FORCE? ((AS selectstmt) | (REMOVE DEFINITION))?
    ;

createexternalschemastmt
    : CREATE EXTERNAL SCHEMA opt_if_not_exists? schema_name=colid
      ( fromdatacatalogclause
      | fromhivemetastoreclause
      | frompostgresclause
      | frommysqlclause
      | fromkinesisclause
      | fromkafkaclause
      | frommskclause
      | fromredshiftclause
      | implicitdatacatalogclause  // Support implicit data catalog
      )
    ;

// External schema FROM clauses
fromdatacatalogclause
    : FROM (DATA_P CATALOG | DATA_CATALOG)
      DATABASE sconst
      colid sconst  // REGION AS literal
      IAM_ROLE iamrolevalue
      (CATALOG_ROLE catalogrolevalue)?
      (CREATE EXTERNAL DATABASE opt_if_not_exists)?
      (CATALOG_ID sconst)?
    ;

dropschemastmt:
    DROP SCHEMA opt_if_exists? qualified_name (COMMA qualified_name)* (DROP EXTERNAL DATABASE)? (CASCADE | RESTRICT)?;

// Implicit data catalog clause (without explicit DATA CATALOG keywords)
implicitdatacatalogclause
    : FROM DATABASE sconst
      colid sconst  // REGION AS literal
      IAM_ROLE iamrolevalue
      (CATALOG_ROLE catalogrolevalue)?
      (CREATE EXTERNAL DATABASE opt_if_not_exists)?
      (CATALOG_ID sconst)?
    ;

fromhivemetastoreclause
    : FROM HIVE METASTORE
      DATABASE sconst
      URI sconst
      (PORT iconst)?
      IAM_ROLE sconst
    ;

frompostgresclause
    : FROM POSTGRES
      DATABASE sconst
      (SCHEMA sconst)?
      URI sconst
      (PORT iconst)?
      IAM_ROLE iamrolevalue
      SECRET_ARN sconst
    ;

frommysqlclause
    : FROM MYSQL
      DATABASE sconst
      URI sconst
      (PORT iconst)?
      IAM_ROLE iamrolevalue
      SECRET_ARN sconst
    ;

fromkinesisclause
    : FROM KINESIS
      IAM_ROLE iamrolevalue
    ;

fromkafkaclause
    : FROM KAFKA
      IAM_ROLE iamrolevalue
      (URI sconst)?
      (AUTHENTICATION authenticationvalue)?
      (AUTHENTICATION_ARN sconst)?
    ;

frommskclause
    : FROM MSK
      IAM_ROLE iamrolevalue
      (URI sconst)?
      (AUTHENTICATION authenticationvalue)?
      (AUTHENTICATION_ARN sconst)?
    ;

fromredshiftclause
    : FROM REDSHIFT
      DATABASE sconst
      (SCHEMA sconst)?
      (colid sconst)?  // REGION 'region-name'
      (IAM_ROLE iamrolevalue)?
    ;

iamrolevalue
    : DEFAULT
    | SESSION_TOKEN
    | sconst
    ;

catalogrolevalue
    : SESSION_TOKEN
    | sconst
    ;

authenticationvalue
    : NONE
    | IAM
    | MTLS
    ;

createexternalfunctionstmt
    : CREATE (OR REPLACE)? EXTERNAL FUNCTION function_name=qualified_name '(' external_func_params? ')' 
      RETURNS typename
      (STABLE | IMMUTABLE | VOLATILE)
      LAMBDA sconst
      IAM_ROLE iamrolevalue
      (RETRY_TIMEOUT iconst)?
      (MAX_BATCH_ROWS iconst)?
      (MAX_BATCH_SIZE iconst (KB | MB)?)?
    ;

external_func_params
    : typename (',' typename)*
    ;

paramlist
    : param_spec (',' param_spec)*
    |
    ;

param_spec
    : paramname=colid typename
    ;

createexternalmodelstmt
    : CREATE EXTERNAL MODEL qualified_name
      FROM sconst  // S3 path
      (FUNCTION_NAME qualified_name)?
      IAM_ROLE iamrolevalue
      (SETTINGS '(' settingsclause ')')?
    | CREATE EXTERNAL MODEL qualified_name
      FUNCTION qualified_name
      IAM_ROLE iamrolevalue
      MODEL_TYPE BEDROCK
      SETTINGS '(' settingsclause ')'
    ;

createexternaltablestmt
    : CREATE EXTERNAL TABLE opt_if_not_exists? qualified_name '(' extern_column_list ')'
      (PARTITIONED BY '(' extern_column_list ')')?
      extern_table_format
      LOCATION sconst
      (TABLE PROPERTIES '(' table_properties_list ')')?
    ;

extern_column_list
    : extern_column_def (',' extern_column_def)*
    ;

extern_column_def
    : colid extern_typename
    ;

extern_typename
    : typename
    | STRING  // Support STRING type
    ;

extern_table_format
    : STORED AS external_format_spec
    | row_format_spec STORED AS external_format_spec
    | STORED AS INPUTFORMAT sconst OUTPUTFORMAT sconst
    ;

row_format_spec
    : ROW FORMAT DELIMITED 
      (FIELDS TERMINATED BY sconst (ESCAPED BY sconst)?)?
      (COLLECTION ITEMS TERMINATED BY sconst)?
      (MAP KEYS TERMINATED BY sconst)?
      (LINES TERMINATED BY sconst)?
      (NULL_P DEFINED AS sconst)?
    | ROW FORMAT SERDE sconst (WITH SERDEPROPERTIES '(' serde_properties_list ')')?
    ;

serde_properties_list
    : serde_property (',' serde_property)*
    ;

serde_property
    : sconst '=' sconst
    ;

external_format_spec
    : PARQUET
    | AVRO
    | RCFILE
    | SEQUENCEFILE
    | TEXTFILE
    | ORC
    | ION
    | JSON
    ;

table_properties_list
    : table_property (',' table_property)*
    ;

table_property
    : sconst EQUAL sconst
    ;

createexternalviewstmt
    : CREATE (OR REPLACE)? EXTERNAL PROTECTED? VIEW qualified_name 
      (IF_P NOT EXISTS)?
      (OPEN_PAREN name_list CLOSE_PAREN)?
      AS selectstmt
    ;

dropexternalviewstmt
    : DROP EXTERNAL VIEW opt_if_exists? qualified_name opt_drop_behavior?
    ;

// SECURITY/POLICY statements
alteridentityproviderstmt
    : ALTER IDENTITY_P PROVIDER identity_provider_name=colid alteridprovideropts+
    ;

alteridprovideropts
    : PARAMETERS parameter_string=sconst
    | NAMESPACE namespace=sconst
    | IAM_ROLE iam_role=sconst
    | AUTO_CREATE_ROLES ((TRUE_P ((INCLUDE | EXCLUDE) GROUPS LIKE filter_pattern=sconst)?) | FALSE_P)?
    | DISABLE_P | ENABLE_P
    ;

altermaskingpolicystmt
    : ALTER MASKING POLICY colid altmaskingpolicyopts
    ;

altermaterializedviewstmt
    : ALTER MATERIALIZED VIEW qualified_name
     (
       AUTO REFRESH (YES_P | NO)
       | ALTER DISTKEY colid
       | ALTER DISTSTYLE (ALL | EVEN | (KEY DISTKEY colid) | AUTO)
       | ALTER COMPOUND? SORTKEY OPEN_PAREN (colid (COMMA colid)*) CLOSE_PAREN
       | ALTER SORTKEY (AUTO | NONE)
       | ROW LEVEL SECURITY (ON | OFF) (CONJUNCTION TYPE_P (AND | OR))? (FOR DATASHARES)?
     )
    ;

altmaskingpolicyopts
    : RENAME TO colid
    | OWNER TO colid
    | SET '(' altmaskingpolicyargs ')'
    | USING '(' maskingexpression ')'
    ;

altmaskingpolicyargs
    : altmaskingpolicyarg (',' altmaskingpolicyarg)*
    ;

altmaskingpolicyarg
    : colid typename
    ;

alterrlspolicystmt
    : ALTER RLS POLICY colid USING OPEN_PAREN a_expr CLOSE_PAREN
    ;

attachmaskingpolicystmt
    : ATTACH MASKING POLICY colid
      ON qualified_name
      '(' attachpolicycollist ')'
      (USING '(' attachpolicycollist ')')?
      TO attachpolicytargets
      (PRIORITY iconst)?
    ;

attachpolicycollist
    : attachpolicycolumn (',' attachpolicycolumn)*
    ;

attachpolicycolumn
    : qualified_name  // supports dotted paths like person.name.first_name
    ;

attachpolicytargets
    : attachpolicytarget (',' attachpolicytarget)*
    ;

attachpolicytarget
    : ROLE qualified_name
    | colid // PUBLIC or user name - PUBLIC is treated as an identifier here
    ;

attachrlspolicystmt
    : ATTACH RLS POLICY policy_name=colid ON TABLE? table_name_list TO attachpolicytargets
    ;

table_name_list
    : qualified_name (COMMA qualified_name)*
    ;

createidentityproviderstmt
    : CREATE IDENTITY_P PROVIDER colid
      TYPE_P (sconst | colid)
      createidprovideropts*
    ;

createidprovideropts
    : PROVIDER_URL sconst
    | PROVIDER_URL_PORT iconst
    | ATTRIBUTE_MAP sconst
    | PROVIDER_ARN sconst
    | ASSUME_ROLE_ARN sconst
    | NAMESPACE sconst
    | PARAMETERS sconst
    | APPLICATION_ARN sconst
    | IAM_ROLE (DEFAULT | sconst)
    | AUTO_CREATE_ROLES (TRUE_P | FALSE_P) (groupfilter)?
    ;

groupfilter
    : INCLUDE GROUPS LIKE sconst
    | EXCLUDE GROUPS LIKE sconst
    ;

createlibrarystmt
    : CREATE (OR REPLACE)? LIBRARY colid LANGUAGE PLPYTHONU
      FROM sconst createlibraryopts*
    ;

createlibraryopts
    : CREDENTIALS sconst
    | colid (AS)? sconst  // REGION AS literal  
    | IAM_ROLE (DEFAULT | sconst)
    ;

createmaskingpolicystmt
    : CREATE MASKING POLICY opt_if_not_exists? policy_name=colid
      WITH '(' inputcolumnlist ')'
      USING '(' maskingexpression ')'
    ;

inputcolumnlist
    : inputcolumn (',' inputcolumn)*
    ;

inputcolumn
    : column_name=colid typename
    ;

maskingexpression
    : a_expr
    ;

createmodelstmt
    : CREATE MODEL model_name=qualified_name
      FROM createmodelfromclause
      (TARGET target_column=qualified_name)?
      FUNCTION function_name=qualified_name ('(' datatypelist ')')?
      (RETURNS typename)?
      (SAGEMAKER sagemakerspec)?
      IAM_ROLE iamrolespec
      (AUTO (ON | OFF))?
      (MODEL_TYPE modeltypespec)?
      (PROBLEM_TYPE problemtypespec)?
      (OBJECTIVE objectivespec)?
      (PREPROCESSORS sconst)?
      (HYPERPARAMETERS hyperparametersspec)?
      (SETTINGS '(' settingsclause ')')?
    ;

createmodelfromclause
    : qualified_name
    | '(' selectstmt ')'
    | sconst
    ;

iamrolespec
    : DEFAULT
    | sconst
    ;

sagemakerspec
    : sconst (':' sconst)?
    ;

modeltypespec
    : XGBOOST
    | MLP
    | LINEAR_LEARNER
    | KMEANS
    | FORECAST
    ;

problemtypespec
    : '(' problemtype ')'
    ;

problemtype
    : REGRESSION
    | BINARY_CLASSIFICATION
    | MULTICLASS_CLASSIFICATION
    ;

objectivespec
    : '(' sconst ')'
    ;

hyperparametersspec
    : DEFAULT
    | DEFAULT EXCEPT '(' hyperparameterslist ')'
    ;

hyperparameterslist
    : hyperparameteritem (',' hyperparameteritem)*
    ;

hyperparameteritem
    : colid sconst
    ;

settingsclause
    : settingsitem (',' settingsitem)*
    ;

settingsitem
    : S3_BUCKET sconst
    | TAGS sconst
    | KMS_KEY_ID sconst
    | S3_GARBAGE_COLLECT (ON | OFF)
    | MAX_CELLS iconst
    | MAX_RUNTIME iconst
    | MAX_BATCH_SIZE sconst
    | MAX_PAYLOAD_IN_MB sconst
    | HORIZON iconst
    | FREQUENCY iconst
    | PERCENTILES sconst
    | MAX_BATCH_ROWS iconst
    | MODEL_ID sconst
    | PROMPT sconst
    | SUFFIX sconst
    | REQUEST_TYPE (RAW | UNIFIED)
    | RESPONSE_TYPE (VARCHAR | SUPER)
    ;

datatypelist
    : datatype (',' datatype)*
    ;

datatype
    : typename
    | colid typename  // named parameter: name type
    | colid colid     // named parameter with non-standard type like: data json
    ;


createrlspolicystmt
    : CREATE RLS POLICY colid 
      (WITH '(' inputcolumnlist ')' (AS colid)?)?
      USING '(' a_expr ')'
    ;

descidentityproviderstmt
    : (DESC | DESCRIBE) IDENTITY_P PROVIDER colid
    ;

detachmaskingpolicystmt
    : DETACH MASKING POLICY colid
      ON qualified_name
      '(' attachpolicycollist ')'
      FROM attachpolicytargets
    ;

detachrlspolicystmt
    : DETACH RLS POLICY rlspolicyname ON TABLE? table_name_list
      FROM role_or_user_or_public_list
    ;

role_or_user_or_public_list
    : role_or_user_or_public (COMMA role_or_user_or_public)*
    ;

role_or_user_or_public
    : rolespec
    | ROLE rolespec
    | PUBLIC
    ;

rlspolicyname:
    colid
    ;

dropidentityproviderstmt
    : DROP IDENTITY_P PROVIDER opt_if_exists? colid (CASCADE)?
    ;

droplibrarystmt
    : DROP LIBRARY opt_if_exists? colid
    ;

dropmaskingpolicystmt  
    : DROP MASKING POLICY opt_if_exists? colid
    ;

dropmodelstmt
    : DROP MODEL opt_if_exists? qualified_name
    ;


droprlspolicystmt
    : DROP RLS POLICY opt_if_exists? colid (CASCADE | RESTRICT)?
    ;

// REDSHIFT-SPECIFIC UTILITY statements
altertableappendstmt
    : ALTER TABLE qualified_name APPEND FROM qualified_name appendoptions*
    ;

appendoptions
    : FILLTARGET
    | IGNOREEXTRA
    ;

alteruserstmt
    : ALTER USER rolespec (WITH)? alteruseropts+
    ;

alteruseropts
    : CREATEDB | NOCREATEDB
    | CREATEUSER | NOCREATEUSER
    | SYSLOG ACCESS (RESTRICTED | UNRESTRICTED)
    | PASSWORD (sconst | DISABLE_P)
    | VALID UNTIL sconst
    | RENAME TO colid
    | CONNECTION LIMIT (iconst | UNLIMITED)
    | SESSION TIMEOUT iconst
    | RESET SESSION TIMEOUT
    | SET colid TO a_expr
    | RESET colid
    | EXTERNALID colid
    ;

analyzecompressionstmt
    : (ANALYZE | ANALYSE) COMPRESSION (qualified_name ('(' name_list ')')?)? (COMPROWS iconst)?
    ;

cancelstmt
    : CANCEL (sconst | iconst) (sconst)?  // session PID/query ID, optional message
    ;

closestmt
    : CLOSE cursorname=colid
    ;

insertexternaltablestmt
    : INSERT INTO qualified_name select_or_values
    ;

select_or_values  
    : selectstmt
    | values_clause  
    ;

selectintostmt
    : SELECT opt_all_clause? opt_target_list INTO qualified_name from_clause?
    ;

setsessionauthorizationstmt
    : SET SESSION AUTHORIZATION colid
    | SET SESSION AUTHORIZATION DEFAULT
    | RESET SESSION AUTHORIZATION
    ;

setsessioncharacteristicsstmt
    : SET SESSION CHARACTERISTICS AS TRANSACTION transaction_mode_list
    ;

// SHOW statements  
showcolumnsstmt
    : SHOW COLUMNS FROM TABLE? qualified_name (LIKE sconst)? (LIMIT iconst)?
    ;

showdatabasesstmt
    : SHOW DATABASES (FROM DATA_P CATALOG)? showdbsopts*
    ;

showdbsopts
    : LIKE sconst
    | WITH DATASHARE sconst
    | LIMIT iconst
    | ACCOUNT sconst (',' sconst)*
    | IAM_ROLE (DEFAULT | SESSION | sconst)
    ;

showdatasharesstmt
    : SHOW DATASHARES (LIKE sconst)?
    ;

showexternaltablestmt
    : SHOW EXTERNAL TABLE qualified_name (PARTITION)?
    ;

showgrantsstmt
    : SHOW GRANTS (ON grantobject)? (FOR grantprincipal)? (LIMIT iconst)?
    | SHOW GRANTS (FOR grantprincipal) (LIMIT iconst)?
    ;

grantobject
    : DATABASE colid
    | SCHEMA qualified_name  
    | TABLE? qualified_name
    | FUNCTION qualified_name ('(' datatypelist? ')')?
    ;

grantprincipal
    : colid
    | ROLE colid
    ;

showmodelstmt
    : SHOW MODEL (qualified_name | ALL)
    ;

showprocedurestmt
    : SHOW PROCEDURE qualified_name func_args?
    ;

showschemasstmt  
    : SHOW SCHEMAS (FROM DATABASE colid)? (LIKE sconst)? (LIMIT iconst)?
    ;

showtablestmt
    : SHOW TABLE qualified_name
    ;

showtablesstmt
    : SHOW TABLES FROM SCHEMA database_name=colid '.' schema_name=colid
      (LIKE pattern=sconst)?
      (LIMIT limit_value=iconst)?
    ;

showviewstmt
    : SHOW VIEW qualified_name
    ;

// OTHER REDSHIFT statements
unloadstmt
    : UNLOAD '(' sconst ')' TO sconst iamroleclause unloadoptions*
    ;

iamroleclause
    : IAM_ROLE (DEFAULT | sconst)
    ;

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

formatoption
    : FORMAT (CSV | PARQUET | JSON)
    ;

partitionbyoption
    : PARTITION BY '(' columnlist ')' INCLUDE?
    ;

manifestoption
    : MANIFEST VERBOSE?
    ;

headeroption
    : HEADER_P
    ;

delimiteroption
    : DELIMITER AS? sconst
    ;

fixedwidthoption
    : FIXEDWIDTH sconst
    ;

encryptedoption
    : ENCRYPTED AUTO?
    ;

kmskeyoption
    : KMS_KEY_ID sconst
    ;

compressionoption
    : BZIP2
    | GZIP
    | ZSTD
    ;

addquotesoption
    : ADDQUOTES
    ;

nullasoption
    : NULL_P AS sconst
    ;

escapeoption
    : ESCAPE
    ;

allowoverwriteoption
    : ALLOWOVERWRITE
    ;

cleanpathoption
    : CLEANPATH
    ;

paralleloption
    : PARALLEL (ON | OFF)
    ;

maxfilesizeoption
    : MAXFILESIZE AS? iconst sizeunit?
    ;

rowgroupsizeoption
    : ROWGROUPSIZE AS? iconst sizeunit?
    ;

sizeunit
    : MB
    | GB
    ;

regionoption
    : colid AS? sconst  // REGION AS literal
    ;

extensionoption
    : EXTENSION sconst
    ;

usestmt
    : USE database_name=colid
    ;

createdbstmt
   : CREATE DATABASE name opt_with? createdb_opt_list?
   ;

createdb_opt_list
   : createdb_opt_items
   ;

createdb_opt_items
   : createdb_opt_item+
   ;

createdb_opt_item
   : createdb_opt_name opt_equal? (signediconst | opt_boolean_or_string | DEFAULT | UNLIMITED)
   | ISOLATION LEVEL (SERIALIZABLE | SNAPSHOT)
   | COLLATE (CASE_SENSITIVE | CASE_INSENSITIVE | CI | CS)
   ;

createdb_opt_name
   : identifier
   | CONNECTION LIMIT
   | ENCODING
   | LOCATION
   | OWNER
   | TABLESPACE
   | TEMPLATE
   ;

opt_equal
   : EQUAL
   ;

alterdatabasestmt
   : ALTER DATABASE name (WITH createdb_opt_list? | createdb_opt_list? | SET TABLESPACE name | REFRESH COLLATION VERSION_P | COLLATE (CASE_SENSITIVE | CASE_INSENSITIVE) | CONNECTION LIMIT (iconst | UNLIMITED))
   ;

alterdatabasesetstmt
   : ALTER DATABASE name setresetclause
   ;

dropdbstmt
   : DROP DATABASE name
   ;

drop_option_list
   : drop_option (COMMA drop_option)*
   ;

drop_option
   : FORCE
   ;

altercollationstmt
   : ALTER COLLATION any_name REFRESH VERSION_P
   ;

altersystemstmt
   : ALTER SYSTEM_P (SET | RESET) generic_set
   ;

createdomainstmt
   : CREATE DOMAIN_P any_name opt_as? typename colquallist
   ;

alterdomainstmt
   : ALTER DOMAIN_P any_name (alter_column_default | DROP NOT NULL_P | SET NOT NULL_P | ADD_P tableconstraint | DROP CONSTRAINT (IF_P EXISTS)? name opt_drop_behavior? | VALIDATE CONSTRAINT name)
   ;

opt_as
   : AS
   ;

altertsdictionarystmt
   : ALTER TEXT_P SEARCH DICTIONARY any_name definition
   ;

altertsconfigurationstmt
   : ALTER TEXT_P SEARCH CONFIGURATION any_name ADD_P MAPPING FOR name_list any_with any_name_list
   | ALTER TEXT_P SEARCH CONFIGURATION any_name ALTER MAPPING FOR name_list any_with any_name_list
   | ALTER TEXT_P SEARCH CONFIGURATION any_name ALTER MAPPING REPLACE any_name any_with any_name
   | ALTER TEXT_P SEARCH CONFIGURATION any_name ALTER MAPPING FOR name_list REPLACE any_name any_with any_name
   | ALTER TEXT_P SEARCH CONFIGURATION any_name DROP MAPPING FOR name_list
   | ALTER TEXT_P SEARCH CONFIGURATION any_name DROP MAPPING IF_P EXISTS FOR name_list
   ;

any_with
   : WITH
   //TODO

   //         | WITH_LA

   ;

createconversionstmt
   : CREATE opt_default? CONVERSION_P any_name FOR sconst TO sconst FROM any_name
   ;

clusterstmt
   : CLUSTER opt_verbose? qualified_name cluster_index_specification?
   | CLUSTER opt_verbose?
   | CLUSTER opt_verbose? name ON qualified_name
   ;

cluster_index_specification
   : USING name
   ;

vacuumstmt
   : VACUUM opt_full? opt_freeze? opt_verbose? opt_analyze? opt_vacuum_relation_list?
   | VACUUM OPEN_PAREN vac_analyze_option_list CLOSE_PAREN opt_vacuum_relation_list?
   | VACUUM vacuum_option? qualified_name? (TO iconst PERCENT_WORD)? BOOST?
   ;

vacuum_option
   : FULL
   | SORT ONLY
   | DELETE_P ONLY
   | REINDEX
   | RECLUSTER
   ;

analyzestmt
   : analyze_keyword opt_verbose? (qualified_name (OPEN_PAREN columnlist CLOSE_PAREN)?)? ((PREDICATE COLUMNS) | (ALL COLUMNS))?
   ;

vac_analyze_option_list
   : vac_analyze_option_elem (COMMA vac_analyze_option_elem)*
   ;

analyze_keyword
   : ANALYZE
   | ANALYSE
   ;

vac_analyze_option_elem
   : vac_analyze_option_name vac_analyze_option_arg?
   ;

vac_analyze_option_name
   : nonreservedword
   | analyze_keyword
   ;

vac_analyze_option_arg
   : opt_boolean_or_string
   | numericonly
   ;

opt_analyze
   : analyze_keyword
   ;

opt_verbose
   : VERBOSE
   ;

opt_full
   : FULL
   ;

opt_freeze
   : FREEZE
   ;

opt_name_list
   : OPEN_PAREN name_list CLOSE_PAREN
   ;

vacuum_relation
   : qualified_name opt_name_list?
   ;

vacuum_relation_list
   : vacuum_relation (COMMA vacuum_relation)*
   ;

opt_vacuum_relation_list
   : vacuum_relation_list
   ;

explainstmt
   : EXPLAIN explainablestmt
   | EXPLAIN analyze_keyword opt_verbose? explainablestmt
   | EXPLAIN VERBOSE explainablestmt
   | EXPLAIN OPEN_PAREN explain_option_list CLOSE_PAREN explainablestmt
   ;

explainablestmt
   : selectstmt
   | insertstmt
   | updatestmt
   | deletestmt
   | declarecursorstmt
   | createasstmt
   | creatematviewstmt
   | refreshmatviewstmt
   | executestmt
   ;

explain_option_list
   : explain_option_elem (COMMA explain_option_elem)*
   ;

explain_option_elem
   : explain_option_name explain_option_arg?
   ;

explain_option_name
   : nonreservedword
   | analyze_keyword
   ;

explain_option_arg
   : opt_boolean_or_string
   | numericonly
   ;

preparestmt
   : PREPARE name prep_type_clause? AS preparablestmt
   ;

prep_type_clause
   : OPEN_PAREN type_list CLOSE_PAREN
   ;

preparablestmt
   : selectstmt
   | insertstmt
   | updatestmt
   | deletestmt
   | mergestmt
   ;

executestmt
   : EXECUTE name execute_param_clause?
   | CREATE opttemp? TABLE create_as_target AS EXECUTE name execute_param_clause? opt_with_data?
   | CREATE opttemp? TABLE IF_P NOT EXISTS create_as_target AS EXECUTE name execute_param_clause? opt_with_data?
   ;

execute_param_clause
   : OPEN_PAREN expr_list CLOSE_PAREN
   ;

deallocatestmt
   : DEALLOCATE name
   | DEALLOCATE PREPARE name
   | DEALLOCATE ALL
   | DEALLOCATE PREPARE ALL
   ;

insertstmt
   : opt_with_clause? INSERT INTO insert_target insert_rest opt_on_conflict? returning_clause?
   ;

insert_target
   : qualified_name (AS colid)?
   ;

insert_rest
   : selectstmt
   | OVERRIDING override_kind VALUE_P selectstmt
   | OPEN_PAREN insert_column_list CLOSE_PAREN (OVERRIDING override_kind VALUE_P)? selectstmt
   | DEFAULT VALUES
   ;

override_kind
   : USER
   | SYSTEM_P
   ;

insert_column_list
   : insert_column_item (COMMA insert_column_item)*
   ;

insert_column_item
   : colid opt_indirection
   ;

opt_on_conflict
   : ON CONFLICT opt_conf_expr? DO (UPDATE SET set_clause_list where_clause? | NOTHING)
   ;

opt_conf_expr
   : OPEN_PAREN index_params CLOSE_PAREN where_clause?
   | ON CONSTRAINT name
   ;

returning_clause
   : RETURNING target_list
   ;

// https://www.postgresql.org/docs/current/sql-merge.html
mergestmt
   : with_clause? MERGE INTO ONLY? qualified_name alias_clause? USING (select_with_parens|qualified_name) alias_clause? ON a_expr
        (merge_when_clause+ | REMOVE DUPLICATES)
   ;

merge_when_clause
   : merge_insert_clause
   | merge_update_clause
   | merge_delete_clause
   ;

merge_insert_clause
   : WHEN NOT MATCHED (AND a_expr)? THEN? INSERT (OPEN_PAREN insert_column_list CLOSE_PAREN)? values_clause
   ;

merge_update_clause
   : WHEN MATCHED (AND a_expr)? THEN? UPDATE SET set_clause_list
   ;

merge_delete_clause
   : WHEN MATCHED (AND a_expr)? THEN? DELETE_P
   ;

deletestmt
   : opt_with_clause? DELETE_P FROM? relation_expr_opt_alias using_clause? where_or_current_clause? returning_clause?
   ;

using_clause
   : USING from_list
   ;

lockstmt
   : LOCK_P opt_table? relation_expr_list opt_lock? opt_nowait?
   ;

opt_lock
   : IN_P lock_type MODE
   ;

lock_type
   : ACCESS (SHARE | EXCLUSIVE)
   | ROW (SHARE | EXCLUSIVE)
   | SHARE (UPDATE EXCLUSIVE | ROW EXCLUSIVE)?
   | EXCLUSIVE
   ;

opt_nowait
   : NOWAIT
   ;

opt_nowait_or_skip
   : NOWAIT
   | SKIP_P LOCKED
   ;

updatestmt
   : opt_with_clause? UPDATE relation_expr_opt_alias SET set_clause_list from_clause? where_or_current_clause? returning_clause?
   ;

set_clause_list
   : set_clause (COMMA set_clause)*
   ;

set_clause
   : set_target EQUAL a_expr
   | OPEN_PAREN set_target_list CLOSE_PAREN EQUAL a_expr
   ;

set_target
   : colid opt_indirection
   ;

set_target_list
   : set_target (COMMA set_target)*
   ;

declarecursorstmt
   : DECLARE cursor_name cursor_options CURSOR opt_hold? FOR selectstmt
   ;

cursor_name
   : name
   ;

cursor_options
   : (NO SCROLL | SCROLL | BINARY | INSENSITIVE)*
   ;

opt_hold
   : WITH HOLD
   | WITHOUT HOLD
   ;
/*
TODO: why select_with_parens alternative is needed at all?
i guess it because original byson grammar can choose selectstmt(2)->select_with_parens on only OPEN_PARENT/SELECT kewords at the begining of statement;
(select * from tab);
parse can go through selectstmt( )->select_no_parens(1)->select_clause(2)->select_with_parens(1)->select_no_parens(1)->select_clause(1)->simple_select
instead of           selectstmt(1)->select_no_parens(1)->select_clause(2)->select_with_parens(1)->select_no_parens(1)->select_clause(1)->simple_select
all standard tests passed on both variants
*/


selectstmt
   : select_no_parens
   | select_with_parens
   ;

select_with_parens
   : OPEN_PAREN select_no_parens CLOSE_PAREN
   | OPEN_PAREN select_with_parens CLOSE_PAREN
   ;

select_no_parens
   : select_clause opt_sort_clause? (for_locking_clause opt_select_limit? | select_limit opt_for_locking_clause?)?
   | with_clause select_clause opt_sort_clause? (for_locking_clause opt_select_limit? | select_limit opt_for_locking_clause?)?
   ;

select_clause
   : simple_select_intersect ((UNION | EXCEPT) all_or_distinct? simple_select_intersect)*
   ;

simple_select_intersect
    : simple_select_pramary (INTERSECT all_or_distinct? simple_select_pramary)*
    ;

simple_select_pramary
   : ( SELECT (opt_all_clause? into_clause? opt_target_list? | opt_top_clause? into_clause? target_list | distinct_clause target_list)
           exclude_clause?
           into_clause?
           from_clause?
           where_clause?
           start_with_clause?
           group_clause?
           having_clause?
           qualify_clause?
           window_clause?
    )
   | values_clause
   | TABLE relation_expr
   | select_with_parens
   ;

exclude_clause
   : EXCLUDE OPEN_PAREN columnlist CLOSE_PAREN
   ;

qualify_clause
   : QUALIFY a_expr
   ;

start_with_clause
   : (START WITH a_expr)? CONNECT BY a_expr;

with_clause
   : WITH RECURSIVE? cte_list
   ;

cte_list
   : common_table_expr (COMMA common_table_expr)*
   ;

common_table_expr
   : name opt_name_list? AS opt_materialized? OPEN_PAREN preparablestmt CLOSE_PAREN
   ;

opt_materialized
   : MATERIALIZED
   | NOT MATERIALIZED
   ;

opt_with_clause
   : with_clause
   ;

into_clause
   : INTO (opt_strict? opttempTableName | into_target)
   ;

opt_top_clause
   : TOP iconst
   ;

opt_strict
   : STRICT_P
   ;

opttempTableName
   : (LOCAL|GLOBAL)? (TEMPORARY | TEMP) opt_table? qualified_name
   | UNLOGGED opt_table? qualified_name
   | TABLE qualified_name
   | qualified_name
   ;

opt_table
   : TABLE
   ;

all_or_distinct
   : ALL
   | DISTINCT
   ;

distinct_clause
   : DISTINCT (ON OPEN_PAREN expr_list CLOSE_PAREN)?
   ;

opt_all_clause
   : ALL
   ;

opt_sort_clause
   : sort_clause
   ;

sort_clause
   : ORDER BY sortby_list
   ;

sortby_list
   : sortby (COMMA sortby)*
   ;

sortby
   : a_expr (USING qual_all_op | opt_asc_desc?) opt_nulls_order?
   ;

select_limit
   : limit_clause offset_clause?
   | offset_clause limit_clause?
   ;

opt_select_limit
   : select_limit
   ;

limit_clause
   : LIMIT select_limit_value (COMMA select_offset_value)?
   | FETCH first_or_next (select_fetch_first_value row_or_rows (ONLY | WITH TIES) | row_or_rows (ONLY | WITH TIES))
   ;

offset_clause
   : OFFSET (select_offset_value | select_fetch_first_value row_or_rows)
   ;

select_limit_value
   : a_expr
   | ALL
   ;

select_offset_value
   : a_expr
   ;

select_fetch_first_value
   : c_expr
   | PLUS i_or_f_const
   | MINUS i_or_f_const
   ;

i_or_f_const
   : iconst
   | fconst
   ;

row_or_rows
   : ROW
   | ROWS
   ;

first_or_next
   : FIRST_P
   | NEXT
   ;

group_clause
   : GROUP_P BY group_by_list
   ;

group_by_list
   : group_by_item (COMMA group_by_item)*
   | ALL
   ;

group_by_item
   : a_expr
   | empty_grouping_set
   | cube_clause
   | rollup_clause
   | grouping_sets_clause
   ;

empty_grouping_set
   : OPEN_PAREN CLOSE_PAREN
   ;

rollup_clause
   : ROLLUP OPEN_PAREN expr_list CLOSE_PAREN
   ;

cube_clause
   : CUBE OPEN_PAREN expr_list CLOSE_PAREN
   ;

grouping_sets_clause
   : GROUPING SETS OPEN_PAREN group_by_list CLOSE_PAREN
   ;

having_clause
   : HAVING a_expr
   ;

for_locking_clause
   : for_locking_items
   | FOR READ ONLY
   ;

opt_for_locking_clause
   : for_locking_clause
   ;

for_locking_items
   : for_locking_item+
   ;

for_locking_item
   : for_locking_strength locked_rels_list? opt_nowait_or_skip?
   ;

for_locking_strength
   : FOR ((NO KEY)? UPDATE | KEY? SHARE)
   ;

locked_rels_list
   : OF qualified_name_list
   ;

values_clause
   : VALUES OPEN_PAREN expr_list CLOSE_PAREN (COMMA OPEN_PAREN expr_list CLOSE_PAREN)*
   ;

from_clause
   : FROM from_list
   ;

from_list
   : table_ref (COMMA table_ref)*
   ;

table_ref
   : (relation_expr opt_alias_clause? tablesample_clause?
      | func_table func_alias_clause?
      | xmltable opt_alias_clause?
      | select_with_parens opt_alias_clause?
      | LATERAL_P (
                    xmltable opt_alias_clause?
                    | func_table func_alias_clause?
                    | select_with_parens opt_alias_clause?
                  )
      | OPEN_PAREN table_ref (
                                CROSS JOIN table_ref
                                | NATURAL join_type? JOIN table_ref
                                | join_type? JOIN table_ref join_qual
                             )? CLOSE_PAREN opt_alias_clause?
     )
      joined_table*
   ;
   
joined_table
   : join_type? JOIN table_ref join_qual
   | CROSS JOIN table_ref
   | NATURAL join_type? JOIN table_ref
   ;

alias_clause
   : AS? colid (OPEN_PAREN name_list CLOSE_PAREN)?
   ;

opt_alias_clause
   : table_alias_clause
   ;

table_alias_clause
   : AS? table_alias (OPEN_PAREN name_list CLOSE_PAREN)?
   ;

func_alias_clause
   : alias_clause
   | (AS colid? | colid) OPEN_PAREN tablefuncelementlist CLOSE_PAREN
   ;

join_type
   : (FULL | LEFT | RIGHT | INNER_P) OUTER_P?
   ;

join_qual
   : USING OPEN_PAREN name_list CLOSE_PAREN
   | ON a_expr
   ;

relation_expr
   : qualified_name STAR?
   | ONLY (qualified_name | OPEN_PAREN qualified_name CLOSE_PAREN)
   ;

relation_expr_list
   : relation_expr (COMMA relation_expr)*
   ;

relation_expr_opt_alias
   : relation_expr (AS? colid)?
   ;

tablesample_clause
   : TABLESAMPLE func_name OPEN_PAREN expr_list CLOSE_PAREN opt_repeatable_clause?
   ;

opt_repeatable_clause
   : REPEATABLE OPEN_PAREN a_expr CLOSE_PAREN
   ;

func_table
   : func_expr_windowless opt_ordinality?
   | ROWS FROM OPEN_PAREN rowsfrom_list CLOSE_PAREN opt_ordinality?
   ;

rowsfrom_item
   : func_expr_windowless opt_col_def_list?
   ;

rowsfrom_list
   : rowsfrom_item (COMMA rowsfrom_item)*
   ;

opt_col_def_list
   : AS OPEN_PAREN tablefuncelementlist CLOSE_PAREN
   ;
   //TODO WITH_LA was used

opt_ordinality
   : WITH ORDINALITY
   ;

where_clause
   : WHERE a_expr
   ;

where_or_current_clause
   : WHERE (CURRENT_P OF cursor_name | a_expr)
   ;

opttablefuncelementlist
   : tablefuncelementlist
   ;

tablefuncelementlist
   : tablefuncelement (COMMA tablefuncelement)*
   ;

tablefuncelement
   : colid typename opt_collate_clause?
   ;

xmltable
   : XMLTABLE OPEN_PAREN (c_expr xmlexists_argument COLUMNS xmltable_column_list | XMLNAMESPACES OPEN_PAREN xml_namespace_list CLOSE_PAREN COMMA c_expr xmlexists_argument COLUMNS xmltable_column_list) CLOSE_PAREN
   ;

xmltable_column_list
   : xmltable_column_el (COMMA xmltable_column_el)*
   ;

xmltable_column_el
   : colid (typename xmltable_column_option_list? | FOR ORDINALITY)
   ;

xmltable_column_option_list
   : xmltable_column_option_el+
   ;

xmltable_column_option_el
   : DEFAULT a_expr
   | identifier a_expr
   | NOT NULL_P
   | NULL_P
   ;

xml_namespace_list
   : xml_namespace_el (COMMA xml_namespace_el)*
   ;

xml_namespace_el
   : b_expr AS collabel
   | DEFAULT b_expr
   ;

typename
   : SETOF? simpletypename (opt_array_bounds? | ARRAY (OPEN_BRACKET iconst CLOSE_BRACKET)?)
   | qualified_name PERCENT (ROWTYPE | TYPE_P)
   | SUPER
   ;

opt_array_bounds
   : (OPEN_BRACKET iconst? CLOSE_BRACKET)+
   ;

simpletypename
   : generictype
   | numeric
   | bit
   | character
   | varbyte
   | constdatetime
   | constinterval (opt_interval? | OPEN_PAREN iconst CLOSE_PAREN)
   | json_type
   ;

varbyte
    : (VARBYTE | VARBINARY | BINARY VARYING) OPEN_PAREN iconst CLOSE_PAREN
    ;

json_type
   : JSON
   ;

consttypename
   : numeric
   | constbit
   | constcharacter
   | constdatetime
   ;

generictype
   : (builtin_function_name | type_function_name | LEFT | RIGHT) attrs? opt_type_modifiers?
   ;

opt_type_modifiers
   : OPEN_PAREN expr_list CLOSE_PAREN
   ;

numeric
   : INT_P
   | INTEGER
   | SMALLINT
   | BIGINT
   | REAL
   | FLOAT_P opt_float?
   | DOUBLE_P PRECISION
   | DECIMAL_P opt_type_modifiers?
   | DEC opt_type_modifiers?
   | NUMERIC opt_type_modifiers?
   | BOOLEAN_P
   ;

opt_float
   : OPEN_PAREN iconst CLOSE_PAREN
   ;
   //todo: merge alts

bit
   : bitwithlength
   | bitwithoutlength
   ;

constbit
   : bitwithlength
   | bitwithoutlength
   ;

bitwithlength
   : BIT opt_varying? OPEN_PAREN expr_list CLOSE_PAREN
   ;

bitwithoutlength
   : BIT opt_varying?
   ;

character
   : character_c (OPEN_PAREN (iconst | colid) CLOSE_PAREN)?
   ;

constcharacter
   : character_c (OPEN_PAREN (iconst | colid) CLOSE_PAREN)?
   ;

character_c
   : (CHARACTER | CHAR_P | NCHAR) opt_varying?
   | VARCHAR
   | NATIONAL (CHARACTER | CHAR_P) opt_varying?
   ;

opt_varying
   : VARYING
   ;

constdatetime
   : (TIMESTAMP | TIME) (OPEN_PAREN iconst CLOSE_PAREN)? opt_timezone?
   ;

constinterval
   : INTERVAL
   ;
   //TODO with_la was used

opt_timezone
   : WITH TIME ZONE
   | WITHOUT TIME ZONE
   ;

opt_interval
   : YEAR_P
   | MONTH_P
   | DAY_P
   | HOUR_P
   | MINUTE_P
   | interval_second
   | YEAR_P TO MONTH_P
   | DAY_P TO (HOUR_P | MINUTE_P | interval_second)
   | HOUR_P TO (MINUTE_P | interval_second)
   | MINUTE_P TO interval_second
   ;

interval_second
   : SECOND_P (OPEN_PAREN iconst CLOSE_PAREN)?
   ;

opt_escape
   : ESCAPE a_expr
   ;
   //precendence accroding to Table 4.2. Operator Precedence (highest to lowest)

   //https://www.postgresql.org/docs/12/sql-syntax-lexical.html#SQL-PRECEDENCE

/*
original version of a_expr, for info
 a_expr: c_expr
        //::	left	PostgreSQL-style typecast
       | a_expr TYPECAST typename -- 1
       | a_expr COLLATE any_name -- 2
       | a_expr AT TIME ZONE a_expr-- 3
       //right	unary plus, unary minus
       | (PLUS| MINUS) a_expr -- 4
        //left	exponentiation
       | a_expr CARET a_expr -- 5
        //left	multiplication, division, modulo
       | a_expr (STAR | SLASH | PERCENT) a_expr -- 6
        //left	addition, subtraction
       | a_expr (PLUS | MINUS) a_expr -- 7
        //left	all other native and user-defined operators
       | a_expr qual_op a_expr -- 8
       | qual_op a_expr -- 9
        //range containment, set membership, string matching BETWEEN IN LIKE ILIKE SIMILAR
       | a_expr NOT? (LIKE|ILIKE|SIMILAR TO|(BETWEEN SYMMETRIC?)) a_expr opt_escape -- 10
        //< > = <= >= <>	 	comparison operators
       | a_expr (LT | GT | EQUAL | LESS_EQUALS | GREATER_EQUALS | NOT_EQUALS) a_expr -- 11
       //IS ISNULL NOTNULL	 	IS TRUE, IS FALSE, IS NULL, IS DISTINCT FROM, etc
       | a_expr IS NOT?
            (
                NULL_P
                |TRUE_P
                |FALSE_P
                |UNKNOWN
                |DISTINCT FROM a_expr
                |OF OPEN_PAREN type_list CLOSE_PAREN
                |DOCUMENT_P
                |unicode_normal_form? NORMALIZED
            ) -- 12
       | a_expr (ISNULL|NOTNULL) -- 13
       | row OVERLAPS row -- 14
       //NOT	right	logical negation
       | NOT a_expr -- 15
        //AND	left	logical conjunction
       | a_expr AND a_expr -- 16
        //OR	left	logical disjunction
       | a_expr OR a_expr -- 17
       | a_expr (LESS_LESS|GREATER_GREATER) a_expr -- 18
       | a_expr qual_op -- 19
       | a_expr NOT? IN_P in_expr -- 20
       | a_expr subquery_Op sub_type (select_with_parens|OPEN_PAREN a_expr CLOSE_PAREN) -- 21
       | UNIQUE select_with_parens -- 22
       | DEFAULT -- 23
;
*/


a_expr
   : a_expr_qual
   ;
/*23*/


/*moved to c_expr*/


/*22*/


/*moved to c_expr*/


/*19*/


a_expr_qual
   : a_expr_lessless qual_op?
   ;
/*18*/


a_expr_lessless
   : a_expr_or ((LESS_LESS | GREATER_GREATER) a_expr_or)*
   ;
/*17*/


a_expr_or
   : a_expr_and (OR a_expr_and)*
   ;
/*16*/

a_expr_and
   : a_expr_between (AND a_expr_between)*
   ;
/*21*/

a_expr_between
   : a_expr_in (NOT? BETWEEN SYMMETRIC? a_expr_in AND a_expr_in)?
   ;
/*20*/


a_expr_in
   : a_expr_unary_not (NOT? IN_P in_expr)?
   ;
/*15*/


a_expr_unary_not
   : NOT? a_expr_isnull
   ;
/*14*/


/*moved to c_expr*/


/*13*/


a_expr_isnull
   : a_expr_is_not (ISNULL | NOTNULL)?
   ;
/*12*/


a_expr_is_not
   : a_expr_compare (IS NOT? (NULL_P | TRUE_P | FALSE_P | UNKNOWN | DISTINCT FROM a_expr | OF OPEN_PAREN type_list CLOSE_PAREN | DOCUMENT_P | unicode_normal_form? NORMALIZED))?
   ;
/*11*/


//a_expr_compare
//   : a_expr_like ((LT | GT | EQUAL | LESS_EQUALS | GREATER_EQUALS | NOT_EQUALS) a_expr_like |subquery_Op sub_type (select_with_parens | OPEN_PAREN a_expr CLOSE_PAREN) /*21*/
//
//   )?
//   ;
///*10*/

a_expr_compare
   : a_expr_prior_or_level ((LT | GT | EQUAL | LESS_EQUALS | GREATER_EQUALS | NOT_EQUALS) a_expr_prior_or_level |subquery_Op sub_type (select_with_parens | OPEN_PAREN a_expr CLOSE_PAREN) /*21*/

   )?
   ;
/*10*/

/* Redshift Level and Prior Expression https://docs.aws.amazon.com/redshift/latest/dg/r_CONNECT_BY_clause.html */
// Perf(zp): Introducing a_expr_prior_or_level seems like introduce the significant performance penalty,
// make redshift-test costs ~4x higher time than without it. Using (PRIOR | LEVEL)? a_expr_like instead will not.
//a_expr_prior_or_level
//   : PRIOR? a_expr_like
//   | LEVEL? a_expr_like
//   ;

a_expr_prior_or_level
   : (PRIOR | LEVEL)? a_expr_like
   ;

a_expr_like
   : a_expr_qual_op (NOT? (LIKE | ILIKE | SIMILAR TO) a_expr_qual_op opt_escape?)?
   ;
/* 8*/


a_expr_qual_op
   : a_expr_unary_qualop (qual_op a_expr_unary_qualop)*
   ;
/* 9*/


a_expr_unary_qualop
   : qual_op? a_expr_add
   ;
/* 7*/


a_expr_add
   : a_expr_mul ((MINUS | PLUS) a_expr_mul)*
   ;
/* 6*/


a_expr_mul
   : a_expr_caret ((STAR | SLASH | PERCENT) a_expr_caret)*
   ;
/* 5*/


a_expr_caret
   : a_expr_unary_sign (CARET a_expr)?
   ;
/* 4*/


a_expr_unary_sign
   : (MINUS | PLUS)? a_expr_at_time_zone /* */


   ;
/* 3*/


a_expr_at_time_zone
   : a_expr_collate (AT TIME ZONE a_expr)?
   ;
/* 2*/


a_expr_collate
   : a_expr_typecast (COLLATE any_name)?
   ;
/* 1*/


a_expr_typecast
   : c_expr (TYPECAST typename)*
   ;

b_expr
   : c_expr
   | b_expr TYPECAST typename
   //right	unary plus, unary minus
   | (PLUS | MINUS) b_expr
   //^	left	exponentiation
   | b_expr CARET b_expr
   //* / %	left	multiplication, division, modulo
   | b_expr (STAR | SLASH | PERCENT) b_expr
   //+ -	left	addition, subtraction
   | b_expr (PLUS | MINUS) b_expr
   //(any other operator)	left	all other native and user-defined operators
   | b_expr qual_op b_expr
   //< > = <= >= <>	 	comparison operators
   | b_expr (LT | GT | EQUAL | LESS_EQUALS | GREATER_EQUALS | NOT_EQUALS) b_expr
   | qual_op b_expr
   | b_expr qual_op
   //S ISNULL NOTNULL	 	IS TRUE, IS FALSE, IS NULL, IS DISTINCT FROM, etc
   | b_expr IS NOT? (DISTINCT FROM b_expr | OF OPEN_PAREN type_list CLOSE_PAREN | DOCUMENT_P)
   ;

c_expr
   : EXISTS select_with_parens # c_expr_exists
   | ARRAY (select_with_parens | array_expr) # c_expr_expr
   | PARAM opt_indirection # c_expr_expr
   | GROUPING OPEN_PAREN expr_list CLOSE_PAREN # c_expr_expr
   | /*22*/

   UNIQUE select_with_parens # c_expr_expr
   | columnref # c_expr_expr
   | aexprconst # c_expr_expr
   | plsqlvariablename # c_expr_expr
   | OPEN_PAREN a_expr_in_parens = a_expr CLOSE_PAREN opt_indirection # c_expr_expr
   | case_expr # c_expr_case
   | func_expr # c_expr_expr
   | select_with_parens indirection? # c_expr_expr
   | explicit_row # c_expr_expr
   | implicit_row # c_expr_expr
   | row OVERLAPS row /* 14*/

   # c_expr_expr
   ;

plsqlvariablename
   : PLSQLVARIABLENAME
   ;

func_application
   : func_name OPEN_PAREN (func_arg_list (COMMA VARIADIC func_arg_expr)? opt_sort_clause? | VARIADIC func_arg_expr opt_sort_clause? | (ALL | DISTINCT) func_arg_list opt_sort_clause? | STAR |) CLOSE_PAREN
   ;

func_expr
   : func_application within_group_clause? filter_clause? over_clause?
   | func_expr_common_subexpr
   ;

func_expr_windowless
   : func_application
   | func_expr_common_subexpr
   ;

func_expr_common_subexpr
   : COLLATION FOR OPEN_PAREN a_expr CLOSE_PAREN
   | CURRENT_DATE
   | CURRENT_TIME (OPEN_PAREN iconst CLOSE_PAREN)?
   | CURRENT_TIMESTAMP (OPEN_PAREN iconst CLOSE_PAREN)?
   | LOCALTIME (OPEN_PAREN iconst CLOSE_PAREN)?
   | LOCALTIMESTAMP (OPEN_PAREN iconst CLOSE_PAREN)?
   | CURRENT_ROLE
   | CURRENT_USER
   | SESSION_USER
   | USER
   | CURRENT_CATALOG
   | CURRENT_SCHEMA
   | CAST OPEN_PAREN a_expr AS typename CLOSE_PAREN
   | EXTRACT OPEN_PAREN extract_list? CLOSE_PAREN
   | NORMALIZE OPEN_PAREN a_expr (COMMA unicode_normal_form)? CLOSE_PAREN
   | OVERLAY OPEN_PAREN overlay_list CLOSE_PAREN
   | POSITION OPEN_PAREN position_list? CLOSE_PAREN
   | SUBSTRING OPEN_PAREN substr_list CLOSE_PAREN
   | TREAT OPEN_PAREN a_expr AS typename CLOSE_PAREN
   | TRIM OPEN_PAREN (BOTH | LEADING | TRAILING)? trim_list CLOSE_PAREN
   | NULLIF OPEN_PAREN a_expr COMMA a_expr CLOSE_PAREN
   | COALESCE OPEN_PAREN expr_list CLOSE_PAREN
   | GREATEST OPEN_PAREN expr_list CLOSE_PAREN
   | LEAST OPEN_PAREN expr_list CLOSE_PAREN
   | XMLCONCAT OPEN_PAREN expr_list CLOSE_PAREN
   | XMLELEMENT OPEN_PAREN NAME_P collabel (COMMA (xml_attributes | expr_list))? CLOSE_PAREN
   | XMLEXISTS OPEN_PAREN c_expr xmlexists_argument CLOSE_PAREN
   | XMLFOREST OPEN_PAREN xml_attribute_list CLOSE_PAREN
   | XMLPARSE OPEN_PAREN document_or_content a_expr xml_whitespace_option? CLOSE_PAREN
   | XMLPI OPEN_PAREN NAME_P collabel (COMMA a_expr)? CLOSE_PAREN
   | XMLROOT OPEN_PAREN XML_P a_expr COMMA xml_root_version opt_xml_root_standalone? CLOSE_PAREN
   | XMLSERIALIZE OPEN_PAREN document_or_content a_expr AS simpletypename CLOSE_PAREN
   ;

xml_root_version
   : VERSION_P a_expr
   | VERSION_P NO VALUE_P
   ;

opt_xml_root_standalone
   : COMMA STANDALONE_P YES_P
   | COMMA STANDALONE_P NO
   | COMMA STANDALONE_P NO VALUE_P
   ;

xml_attributes
   : XMLATTRIBUTES OPEN_PAREN xml_attribute_list CLOSE_PAREN
   ;

xml_attribute_list
   : xml_attribute_el (COMMA xml_attribute_el)*
   ;

xml_attribute_el
   : a_expr (AS collabel)?
   ;

document_or_content
   : DOCUMENT_P
   | CONTENT_P
   ;

xml_whitespace_option
   : PRESERVE WHITESPACE_P
   | STRIP_P WHITESPACE_P
   ;

xmlexists_argument
   : PASSING c_expr
   | PASSING c_expr xml_passing_mech
   | PASSING xml_passing_mech c_expr
   | PASSING xml_passing_mech c_expr xml_passing_mech
   ;

xml_passing_mech
   : BY (REF | VALUE_P)
   ;

within_group_clause
   : WITHIN GROUP_P OPEN_PAREN sort_clause CLOSE_PAREN
   ;

filter_clause
   : FILTER OPEN_PAREN WHERE a_expr CLOSE_PAREN
   ;

window_clause
   : WINDOW window_definition_list
   ;

window_definition_list
   : window_definition (COMMA window_definition)*
   ;

window_definition
   : colid AS window_specification
   ;

over_clause
   : OVER (window_specification | colid)
   ;

window_specification
   : OPEN_PAREN opt_existing_window_name? opt_partition_clause? opt_sort_clause? opt_frame_clause? CLOSE_PAREN
   ;

opt_existing_window_name
   : colid
   ;

opt_partition_clause
   : PARTITION BY expr_list
   ;

opt_frame_clause
   : RANGE frame_extent opt_window_exclusion_clause?
   | ROWS frame_extent opt_window_exclusion_clause?
   | GROUPS frame_extent opt_window_exclusion_clause?
   ;

frame_extent
   : frame_bound
   | BETWEEN frame_bound AND frame_bound
   ;

frame_bound
   : UNBOUNDED (PRECEDING | FOLLOWING)
   | CURRENT_P ROW
   | a_expr (PRECEDING | FOLLOWING)
   ;

opt_window_exclusion_clause
   : EXCLUDE (CURRENT_P ROW | GROUP_P | TIES | NO OTHERS)
   ;

row
   : ROW OPEN_PAREN expr_list? CLOSE_PAREN
   | OPEN_PAREN expr_list COMMA a_expr CLOSE_PAREN
   ;

explicit_row
   : ROW OPEN_PAREN expr_list? CLOSE_PAREN
   ;
/*
TODO:
for some reason v1
implicit_row: OPEN_PAREN expr_list COMMA a_expr CLOSE_PAREN;
works better than v2
implicit_row: OPEN_PAREN expr_list  CLOSE_PAREN;
while looks like they are almost the same, except v2 requieres at least 2 items in list
while v1 allows single item in list
*/


implicit_row
   : OPEN_PAREN expr_list COMMA a_expr CLOSE_PAREN
   ;

sub_type
   : ANY
   | SOME
   | ALL
   ;

all_op
   : Operator
   | mathop
   ;

mathop
   : PLUS
   | MINUS
   | STAR
   | SLASH
   | PERCENT
   | CARET
   | LT
   | GT
   | EQUAL
   | LESS_EQUALS
   | GREATER_EQUALS
   | NOT_EQUALS
   ;

qual_op
   : Operator
   | OPERATOR OPEN_PAREN any_operator CLOSE_PAREN
   ;

qual_all_op
   : all_op
   | OPERATOR OPEN_PAREN any_operator CLOSE_PAREN
   ;

subquery_Op
   : all_op
   | OPERATOR OPEN_PAREN any_operator CLOSE_PAREN
   | LIKE
   | NOT LIKE
   | ILIKE
   | NOT ILIKE
   ;

expr_list
   : a_expr (COMMA a_expr)*
   ;

func_arg_list
   : func_arg_expr (COMMA func_arg_expr)*
   ;

func_arg_expr
   : a_expr
   | param_name (COLON_EQUALS | EQUALS_GREATER) a_expr
   ;

type_list
   : typename (COMMA typename)*
   ;

array_expr
   : OPEN_BRACKET (expr_list | array_expr_list)? CLOSE_BRACKET
   ;

array_expr_list
   : array_expr (COMMA array_expr)*
   ;

extract_list
   : extract_arg FROM a_expr
   ;

extract_arg
   : identifier
   | YEAR_P
   | MONTH_P
   | DAY_P
   | HOUR_P
   | MINUTE_P
   | SECOND_P
   | sconst
   ;

unicode_normal_form
   : NFC
   | NFD
   | NFKC
   | NFKD
   ;

overlay_list
   : a_expr PLACING a_expr FROM a_expr (FOR a_expr)?
   ;

position_list
   : b_expr IN_P b_expr
   ;

substr_list
   : a_expr FROM a_expr FOR a_expr
   | a_expr FOR a_expr FROM a_expr
   | a_expr FROM a_expr
   | a_expr FOR a_expr
   | a_expr SIMILAR a_expr ESCAPE a_expr
   | expr_list
   ;

trim_list
   : a_expr FROM expr_list
   | FROM expr_list
   | expr_list
   ;

in_expr
   : select_with_parens # in_expr_select
   | OPEN_PAREN expr_list CLOSE_PAREN # in_expr_list
   ;

case_expr
   : CASE case_arg? when_clause_list case_default? END_P
   ;

when_clause_list
   : when_clause+
   ;

when_clause
   : WHEN a_expr THEN a_expr
   ;

case_default
   : ELSE a_expr
   ;

case_arg
   : a_expr
   ;

columnref
   : colid indirection?
   ;

indirection_el
   : DOT (attr_name | STAR)
   | OPEN_BRACKET (a_expr | opt_slice_bound? COLON opt_slice_bound?) CLOSE_BRACKET
   ;

opt_slice_bound
   : a_expr
   ;

indirection
   : indirection_el+
   ;

opt_indirection
   : indirection_el*
   ;

opt_target_list
   : target_list
   ;

target_list
   : target_el (COMMA target_el)*
   ;

target_el
   : a_expr target_alias? # target_label
   | STAR # target_star
   ;
   
target_alias
   : AS collabel
   | identifier
   ;

qualified_name_list
   : qualified_name (COMMA qualified_name)*
   ;

qualified_name
   : colid indirection?
   ;

name_list
   : name (COMMA name)*
   ;

name
   : colid
   ;

attr_name
   : collabel
   ;

file_name
   : sconst
   ;

func_name
   : builtin_function_name
   | type_function_name
   | colid indirection
   | LEFT
   | RIGHT
   ;

aexprconst
   : iconst
   | fconst
   | sconst
   | bconst
   | xconst
   | func_name (sconst | OPEN_PAREN func_arg_list opt_sort_clause? CLOSE_PAREN sconst)
   | consttypename sconst
   | constinterval (sconst opt_interval? | OPEN_PAREN iconst CLOSE_PAREN sconst)
   | TRUE_P
   | FALSE_P
   | NULL_P
   ;

xconst
   : HexadecimalStringConstant
   ;

bconst
   : BinaryStringConstant
   ;

fconst
   : Numeric
   ;

iconst
   : Integral
   ;

sconst
   : anysconst opt_uescape?
   ;

anysconst
   : StringConstant
   | UnicodeEscapeStringConstant
   | BeginDollarStringConstant DollarText* EndDollarStringConstant
   | EscapeStringConstant
   ;

opt_uescape
   : UESCAPE anysconst
   ;

signediconst
   : iconst
   | PLUS iconst
   | MINUS iconst
   ;

roleid
   : rolespec
   ;

rolespec
   : nonreservedword
   | NamespaceUser
   | CURRENT_USER
   | SESSION_USER
   ;

role_list
   : rolespec (COMMA rolespec)*
   ;

colid
   : identifier
   | unreserved_keyword
   | col_name_keyword
   | plsql_unreserved_keyword
   | LEFT
   | RIGHT
   ;

table_alias
   : identifier
   | unreserved_keyword
   | col_name_keyword
   | plsql_unreserved_keyword
   ;


type_function_name
   : identifier
   | unreserved_keyword
   | plsql_unreserved_keyword
   | type_func_name_keyword
   ;

nonreservedword
   : identifier
   | unreserved_keyword
   | col_name_keyword
   | type_func_name_keyword
   ;

collabel
   : identifier
   | plsql_unreserved_keyword
   | unreserved_keyword
   | col_name_keyword
   | type_func_name_keyword
   | reserved_keyword
   ;

identifier
   : Identifier opt_uescape?
   | QuotedIdentifier
   | UnicodeQuotedIdentifier
   | plsqlvariablename
   | plsqlidentifier
   | plsql_unreserved_keyword
   ;

plsqlidentifier
   : PLSQLIDENTIFIER
   ;

unreserved_keyword
   : ABORT_P
   | ABSOLUTE_P
   | ACCESS
   | ACTION
   | ADD_P
   | ADMIN
   | AFTER
   | AGGREGATE
   | ALSO
   | ALTER
   | ALWAYS
   | ASSERTION
   | ASSIGNMENT
   | AT
   | ATOMIC_P
   | ATTACH
   | ATTRIBUTE
   | BACKWARD
   | BEFORE
   | BEGIN_P
   | BY
   | CACHE
   | CALL
   | CALLED
   | CASCADE
   | CASCADED
   | CATALOG
   | CHAIN
   | CHARACTERISTICS
   | CHECKPOINT
   | CLASS
   | CLOSE
   | CLUSTER
   | COLUMNS
   | COMMENT
   | COMMENTS
   | COMMIT
   | COMMITTED
   | CONFIGURATION
   | CONFLICT
   | CONNECTION
   | CONSTRAINTS
   | CONTENT_P
   | CONTINUE_P
   | CONVERSION_P
   | COPY
   | COST
   | CSV
   | CUBE
   | CURRENT_P
   | CURSOR
   | CYCLE
   | DATA_P
   | DATABASE
   | DAY_P
   | DEALLOCATE
   | DECLARE
   | DEFAULTS
   | DEFERRED
   | DEFINER
   | DELETE_P
   | DELIMITER
   | DELIMITERS
   | DEPENDS
   | DETACH
   | DICTIONARY
   | DISABLE_P
   | DISCARD
   | DOCUMENT_P
   | DOMAIN_P
   | DOUBLE_P
   | DROP
   | EACH
   | ENABLE_P
   | ENCODING
   | ENCRYPTED
   | ENUM_P
   | ESCAPE
   | EVENT
   | EXCLUDE
   | EXCLUDING
   | EXCLUSIVE
   | EXECUTE
   | EXPLAIN
   | EXPRESSION
   | EXTENSION
   | EXTERNAL
   | FAMILY
   | FILTER
   | FIRST_P
   | FOLLOWING
   | FORCE
   | FORWARD
   | FUNCTION
   | FUNCTIONS
   | GENERATED
   | GLOBAL
   | GRANTED
   | GROUPS
   | HANDLER
   | HEADER_P
   | HOLD
   | HOUR_P
   | IDENTITY_P
   | IF_P
   | IMMEDIATE
   | IMMUTABLE
   | IMPLICIT_P
   | IMPORT_P
   | INCLUDE
   | INCLUDING
   | INCREMENT
   | INDEX
   | INDEXES
   | INHERIT
   | INHERITS
   | INLINE_P
   | INPUT_P
   | INSENSITIVE
   | INSERT
   | INSTEAD
   | INVOKER
   | ISOLATION
   | KEY
   | LABEL
   | LANGUAGE
   | LARGE_P
   | LAST_P
   | LEAKPROOF
   | LEVEL
   | LISTEN
   | LOAD
   | LOCAL
   | LOCATION
   | LOCK_P
   | LOCKED
   | LOGGED
   | MAPPING
   | MATCH
   | MATERIALIZED
   | MAXVALUE
   | METHOD
   | MINUTE_P
   | MINVALUE
   | MODE
   | MONTH_P
   | MOVE
   | NAME_P
   | NAMES
   | NEW
   | NEXT
   | NFC
   | NFD
   | NFKC
   | NFKD
   | NO
   | NORMALIZED
   | NOTHING
   | NOTIFY
   | NOWAIT
   | NULLS_P
   | OBJECT_P
   | OF
   | OFF
   | OIDS
   | OLD
   | OPERATOR
   | OPTION
   | OPTIONS
   | ORDINALITY
   | OTHERS
   | OVER
   | OVERRIDING
   | OWNED
   | OWNER
   | PARALLEL
   | PARAMETER
   | PUBLIC
   | PARSER
   | PARTIAL
   | PARTITION
   | PASSING
   | PASSWORD
   | PLANS
   | POLICY
   | PRECEDING
   | PREPARE
   | PREPARED
   | PRESERVE
   | PRIOR
   | PRIORITY
   | PRIVILEGES
   | PROCEDURAL
   | PROCEDURE
   | PROCEDURES
   | PROGRAM
   | PUBLICATION
   | QUOTE
   | RANGE
   | READ
   | REASSIGN
   | RECHECK
   | RECURSIVE
   | REF
   | REFERENCING
   | REFRESH
   | REINDEX
   | RELATIVE_P
   | RELEASE
   | RENAME
   | REPEATABLE
   | REPLICA
   | RESET
   | RESTART
   | RESTRICT
   | RETURNS
   | REVOKE
   | ROLE
   | ROLLBACK
   | ROLLUP
   | ROUTINE
   | ROUTINES
   | ROWS
   | RULE
   | SAVEPOINT
   | SCHEMA
   | SCHEMAS
   | SCROLL
   | SEARCH
   | SECOND_P
   | SECURITY
   | SEQUENCE
   | SEQUENCES
   | SERIALIZABLE
   | SERVER
   | SESSION
   | SET
   | SETS
   | SHARE
   | SHOW
   | SIMPLE
   | SKIP_P
   | SNAPSHOT
   | SQL_P
   | STABLE
   | STANDALONE_P
   | START
   | STATEMENT
   | STATISTICS
   | STDIN
   | STDOUT
   | STORAGE
   | STORED
   | STRICT_P
   | STRIP_P
   | SUBSCRIPTION
   | SUPPORT
   | SYSID
   | SYSTEM_P
   | TABLES
   | TABLESPACE
   | TEMP
   | TEMPLATE
   | TEMPORARY
   | TEXT_P
   | TIES
   | TRANSACTION
   | TRANSFORM
   | TRIGGER
   | TRUNCATE
   | TRUSTED
   | TYPE_P
   | TYPES_P
   | UESCAPE
   | UNBOUNDED
   | UNCOMMITTED
   | UNENCRYPTED
   | UNKNOWN
   | UNLISTEN
   | UNLOGGED
   | UNTIL
   | UPDATE
   | VACUUM
   | VALID
   | VALIDATE
   | VALIDATOR
   | VALUE_P
   | VARYING
   | VERSION_P
   | VIEW
   | VIEWS
   | VOLATILE
   | WHITESPACE_P
   | WITHIN
   | WITHOUT
   | WORK
   | WRAPPER
   | WRITE
   | XML_P
   | YEAR_P
   | YES_P
   | ZONE
   // REDSHIFT-SPECIFIC KEYWORDS (added to support their use as column names/identifiers)
   | DEFINITION | DATASHARE | PUBLICACCESSIBLE | INCLUDENEW
   | IAM_ROLE | CATALOG_ROLE | CATALOG_ID | HIVE | METASTORE | URI
   | POSTGRES | MYSQL | SECRET_ARN | KINESIS | KAFKA | MSK
   | AUTHENTICATION | AUTHENTICATION_ARN | SESSION_TOKEN | MTLS
   | MASKING | RLS | IDENTITY | PROVIDER | PROTECTED
   | MODEL | TARGET | SAGEMAKER | AUTO | MODEL_TYPE | PROBLEM_TYPE
   | OBJECTIVE | PREPROCESSORS | HYPERPARAMETERS | XGBOOST | MLP
   | LINEAR_LEARNER | KMEANS | FORECAST | REGRESSION | BINARY_CLASSIFICATION
   | MULTICLASS_CLASSIFICATION | S3_BUCKET | TAGS | KMS_KEY_ID | S3_GARBAGE_COLLECT
   | MAX_CELLS | MAX_RUNTIME | HORIZON | FREQUENCY | PERCENTILES | MAX_BATCH_ROWS
   | UNLOAD | MANIFEST | ADDQUOTES | ALLOWOVERWRITE | CLEANPATH
   | MAXFILESIZE | ROWGROUPSIZE | BZIP2 | GZIP | ZSTD
   | DATABASES | DATASHARES | GRANTS | USE | CANCEL
   | SESSION_AUTHORIZATION | SESSION_CHARACTERISTICS | COMPRESSION | LIBRARY | APPEND
   | MB | GB | ACCOUNT | NAMESPACE | DESCRIBE
   | NONATOMIC | MANAGEDBY | ADX | REMOVE | DUPLICATES
   | BEDROCK | MODEL_ID | PROMPT | SUFFIX | REQUEST_TYPE | RESPONSE_TYPE
   | RAW | UNIFIED | SUPER | CI | CS | PLPYTHONU
   | FILLTARGET | IGNOREEXTRA | CREATEUSER | NOCREATEUSER | REGION | PORT
   | REDSHIFT | IAM | CREATEDB | NOCREATEDB | RESTRICTED | UNLIMITED
   | EXTERNALID | TIMEOUT | SYSLOG | CREDENTIALS | UNRESTRICTED | PARAMETERS
   | APPLICATION_ARN | AUTO_CREATE_ROLES | COMPROWS | PROVIDER_URL | PROVIDER_URL_PORT
   | ATTRIBUTE_MAP | PROVIDER_ARN | ASSUME_ROLE_ARN | PROPERTIES
   | AVRO | RCFILE | SEQUENCEFILE | TEXTFILE | ORC | ION | LAMBDA | FIXEDWIDTH
   | PARQUET | LZOP | REMOVEQUOTES | TRUNCATECOLUMNS | FILLRECORD
   | BLANKSASNULL | EMPTYASNULL | MAXERROR | DATEFORMAT | TIMEFORMAT
   | ACCEPTINVCHARS | ACCEPTANYDATE | IGNOREHEADER | IGNOREBLANKLINES
   | COMPUPDATE | STATUPDATE | EXPLICIT_IDS | READRATIO | ROUNDEC
   | TRIMBLANKS | PRESET | ACCESS_KEY_ID | SECRET_ACCESS_KEY
   | SESSION_TOKEN_KW | HEADER | SETTINGS | FUNCTION_NAME
   ;

col_name_keyword
   : BETWEEN
   | BIGINT
   | bit
   | BOOLEAN_P
   | CHAR_P
   | character
   | COALESCE
   | DEC
   | DECIMAL_P
   | EXISTS
   | EXTRACT
   | FLOAT_P
   | GREATEST
   | GROUPING
   | INOUT
   | INT_P
   | INTEGER
   | INTERVAL
   | JSON
   | IGNOREHEADER | IGNOREBLANKLINES | TRUNCATECOLUMNS | FILLRECORD
   | BLANKSASNULL | EMPTYASNULL | ACCEPTINVCHARS | ACCEPTANYDATE  
   | DATEFORMAT | TIMEFORMAT | COMPUPDATE | STATUPDATE
   | MAXERROR | READRATIO | MANIFEST | ENCRYPTED
   | REMOVEQUOTES | EXPLICIT_IDS | ROUNDEC | TRIMBLANKS
   | FIXEDWIDTH | ACCESS_KEY_ID | SECRET_ACCESS_KEY | SESSION_TOKEN_KW
   | GZIP | BZIP2 | LZOP | ZSTD | AVRO | PARQUET | ORC
   | REGION | DELIMITER | ENCODING | COMPRESSION | QUOTE | COMPROWS
   | LEAST
   | NATIONAL
   | NCHAR
   | NONE
   | NORMALIZE
   | NULLIF
   | numeric
   | OFFSET
   | OUT_P
   | OVERLAY
   | POSITION
   | PRECISION
   | REAL
   | ROW
   | SETOF
   | SMALLINT
   | SUBSTRING
   | TIME
   | TIMESTAMP
   | TREAT
   | TRIM
   | VALUES
   | VARCHAR
   | XMLATTRIBUTES
   | XMLCONCAT
   | XMLELEMENT
   | XMLEXISTS
   | XMLFOREST
   | XMLNAMESPACES
   | XMLPARSE
   | XMLPI
   | XMLROOT
   | XMLSERIALIZE
   | XMLTABLE
   | builtin_function_name
   ;

type_func_name_keyword
   : AUTHORIZATION
   | BINARY
   | COLLATION
   | CONCURRENTLY
   | CROSS
   | CURRENT_SCHEMA
   | FREEZE
   | FULL
   | ILIKE
   | INNER_P
   | IS
   | ISNULL
   | JOIN
   | LIKE
   | NATURAL
   | NOTNULL
   | OUTER_P
   | OVERLAPS
   | SIMILAR
   | TABLESAMPLE
   | VERBOSE
   ;

reserved_keyword
   : ALL
   | ANALYSE
   | ANALYZE
   | AND
   | ANY
   | ARRAY
   | AS
   | ASC
   | ASYMMETRIC
   | BOTH
   | CASE
   | CAST
   | CHECK
   | COLLATE
   | COLUMN
   | CONSTRAINT
   | CREATE
   | CURRENT_CATALOG
   | CURRENT_DATE
   | CURRENT_ROLE
   | CURRENT_TIME
   | CURRENT_TIMESTAMP
   | CURRENT_USER
   //                 | DEFAULT
   | DEFERRABLE
   | DESC
   | DISTINCT
   | DO
   | ELSE
   | END_P
   | EXCEPT
   | FALSE_P
   | FETCH
   | FOR
   | FOREIGN
   | FROM
   | GRANT
   | GROUP_P
   | HAVING
   | IN_P
   | INITIALLY
   | INTERSECT
/*
from pl_gram.y, line ~2982
	 * Fortunately, INTO is a fully reserved word in the main grammar, so
	 * at least we need not worry about it appearing as an identifier.
*/


   //                 | INTO
   | LATERAL_P
   | LEADING
   | LIMIT
   | LOCALTIME
   | LOCALTIMESTAMP
   | NOT
   | NULL_P
   | OFFSET
   | ON
   | ONLY
   | OR
   | ORDER
   | PLACING
   | PRIMARY
   | REFERENCES
   | RETURNING
   | SELECT
   | SESSION_USER
   | SOME
   | SYMMETRIC
   | TABLE
   | THEN
   | TO
   | TRAILING
   | TRUE_P
   | UNION
   | UNIQUE
   | USER
   | USING
   | VARIADIC
   | WHEN
   | WHERE
   | WINDOW
   | WITH
   ;

builtin_function_name
   : XMLCOMMENT
   | XML_IS_WELL_FORMED
   | XML_IS_WELL_FORMED_DOCUMENT
   | XML_IS_WELL_FORMED_CONTENT
   | XMLAGG
   | XPATH
   | XPATH_EXISTS
   | ABS
   | CBRT
   | CEIL
   | CEILING
   | DEGREES
   | DIV
   | EXP
   | FACTORIAL
   | FLOOR
   | GCD
   | LCM
   | LN
   | LOG
   | LOG10
   | MIN_SCALE
   | MOD
   | PI
   | POWER
   | RADIANS
   | ROUND
   | SCALE
   | SIGN
   | SQRT
   | TRIM_SCALE
   | TRUNC
   | WIDTH_BUCKET
   | RANDOM
   | SETSEED
   | ACOS
   | ACOSD
   | ACOSH
   | ASIN
   | ASIND
   | ASINH
   | ATAN
   | ATAND
   | ATANH
   | ATAN2
   | ATAN2D
   | COS
   | COSD
   | COSH
   | COT
   | COTD
   | SIN
   | SIND
   | SINH
   | TAN
   | TAND
   | TANH
   | BIT_LENGTH
   | CHAR_LENGTH
   | CHARACTER_LENGTH
   | LOWER
   | OCTET_LENGTH
   | OCTET_LENGTH
   | UPPER
   | ASCII
   | BTRIM
   | CHR
   | CONCAT
   | CONCAT_WS
   | FORMAT
   | INITCAP
   | LENGTH
   | LPAD
   | LTRIM
   | MD5
   | PARSE_IDENT
   | PG_CLIENT_ENCODING
   | QUOTE_IDENT
   | QUOTE_LITERAL
   | QUOTE_NULLABLE
   | REGEXP_COUNT
   | REGEXP_INSTR
   | REGEXP_LIKE
   | REGEXP_MATCH
   | REGEXP_MATCHES
   | REGEXP_REPLACE
   | REGEXP_SPLIT_TO_ARRAY
   | REGEXP_SPLIT_TO_TABLE
   | REGEXP_SUBSTR
   | REPEAT
   | REPLACE
   | REVERSE
   | RPAD
   | RTRIM
   | SPLIT_PART
   | STARTS_WITH
   | STRING_TO_ARRAY
   | STRING_TO_TABLE
   | STRPOS
   | SUBSTR
   | TO_ASCII
   | TO_HEX
   | TRANSLATE
   | UNISTR
   | AGE
   | DATE_BIN
   | DATE_PART
   | DATE_TRUNC
   | ISFINITE
   | JUSTIFY_DAYS
   | JUSTIFY_HOURS
   | JUSTIFY_INTERVAL
   | MAKE_DATE
   | MAKE_INTERVAL
   | MAKE_TIME
   | MAKE_TIMESTAMP
   | MAKE_TIMESTAMPTZ
   | CLOCK_TIMESTAMP
   | NOW
   | STATEMENT_TIMESTAMP
   | TIMEOFDAY
   | TRANSACTION_TIMESTAMP
   | TO_TIMESTAMP
   | JUSTIFY_INTERVAL
   | JUSTIFY_INTERVAL
   | TO_CHAR
   | TO_DATE
   | TO_NUMBER
   | CURRENT_USER
   ;

/************************************************************************************************************************************************************/
/*PL/SQL GRAMMAR */


/*PLSQL grammar */

   /************************************************************************************************************************************************************/ pl_function
   : comp_options pl_block opt_semi?
   ;

comp_options
   : comp_option*
   ;

comp_option
   : sharp OPTION DUMP
   | sharp PRINT_STRICT_PARAMS option_value
   | sharp VARIABLE_CONFLICT ERROR
   | sharp VARIABLE_CONFLICT USE_VARIABLE
   | sharp VARIABLE_CONFLICT USE_COLUMN
   ;

sharp
   : Operator
   ;

option_value
   : sconst
   | reserved_keyword
   | plsql_unreserved_keyword
   | unreserved_keyword
   ;

opt_semi
   : SEMI
   ;
   // exception_sect means opt_exception_sect in original grammar, don't be confused!

pl_block
   : decl_sect BEGIN_P proc_sect exception_sect? END_P opt_label?
   ;

decl_sect
   : opt_block_label? (decl_start decl_stmts?)?
   ;

decl_start
   : DECLARE
   ;

decl_stmts
   : decl_stmt+
   ;

label_decl
   : LESS_LESS any_identifier GREATER_GREATER
   ;

decl_stmt
   : decl_statement
   | DECLARE
   | label_decl
   ;

decl_statement
   : decl_varname
     (
          ALIAS FOR decl_aliasitem
        | decl_const? decl_datatype decl_collate? decl_notnull? decl_defval?
        | opt_scrollable? CURSOR decl_cursor_args? decl_is_for decl_cursor_query
     ) SEMI
   ;

opt_scrollable
   : NO SCROLL
   | SCROLL
   ;

decl_cursor_query
   : selectstmt
   ;

decl_cursor_args
   : OPEN_PAREN decl_cursor_arglist CLOSE_PAREN
   ;

decl_cursor_arglist
   : decl_cursor_arg (COMMA decl_cursor_arg)*
   ;

decl_cursor_arg
   : decl_varname decl_datatype
   ;

decl_is_for
   : IS
   | FOR
   ;

decl_aliasitem
   : PARAM
   | colid
   ;

decl_varname
   : any_identifier
   ;

decl_const
   : CONSTANT
   ;

decl_datatype
   : typename
   ; //TODO: $$ = read_datatype(yychar);

decl_collate
   : COLLATE any_name
   ;

decl_notnull
   : NOT NULL_P
   ;

decl_defval
   : decl_defkey sql_expression
   ;

decl_defkey
   : assign_operator
   | DEFAULT
   ;

assign_operator
   : EQUAL
   | COLON_EQUALS
   ;

proc_sect
   : proc_stmt*
   ;

proc_stmt
   : pl_block SEMI
   | stmt_return
   | stmt_raise
   | stmt_assign
   | stmt_if
   | stmt_case
   | stmt_loop
   | stmt_while
   | stmt_for
   | stmt_foreach_a
   | stmt_exit
   | stmt_assert
   | stmt_execsql
   | stmt_dynexecute
   | stmt_perform
   | stmt_call
   | stmt_getdiag
   | stmt_open
   | stmt_fetch
   | stmt_move
   | stmt_close
   | stmt_null
   | stmt_commit
   | stmt_rollback
   | stmt_set
   ;

stmt_perform
   : PERFORM expr_until_semi SEMI
   ;

stmt_call
   : CALL any_identifier OPEN_PAREN opt_expr_list? CLOSE_PAREN SEMI
   | DO any_identifier OPEN_PAREN opt_expr_list? CLOSE_PAREN SEMI
   ;

opt_expr_list
   : expr_list
   ;

stmt_assign
   : assign_var assign_operator sql_expression SEMI
   ;

stmt_getdiag
   : GET getdiag_area_opt? DIAGNOSTICS getdiag_list SEMI
   ;

getdiag_area_opt
   : CURRENT_P
   | STACKED
   ;

getdiag_list
   : getdiag_list_item (COMMA getdiag_list_item)*
   ;

getdiag_list_item
   : getdiag_target assign_operator getdiag_item
   ;

getdiag_item
   : colid
   ;

getdiag_target
   : assign_var
   ;

assign_var
   : (any_name | PARAM) (OPEN_BRACKET expr_until_rightbracket CLOSE_BRACKET)*
   ;

stmt_if
   : IF_P expr_until_then THEN proc_sect stmt_elsifs stmt_else? END_P IF_P SEMI
   ;

stmt_elsifs
   : (ELSIF a_expr THEN proc_sect)*
   ;

stmt_else
   : ELSE proc_sect
   ;

stmt_case
   : CASE opt_expr_until_when? case_when_list opt_case_else? END_P CASE SEMI
   ;

opt_expr_until_when
   : sql_expression
   ;

case_when_list
   : case_when+
   ;

case_when
   : WHEN expr_list THEN proc_sect
   ;

opt_case_else
   : ELSE proc_sect
   ;

stmt_loop
   : opt_loop_label? loop_body
   ;

stmt_while
   : opt_loop_label? WHILE expr_until_loop loop_body
   ;

stmt_for
   : opt_loop_label? FOR for_control loop_body
   ;
   //TODO: rewrite using read_sql_expression logic?

for_control
   : for_variable IN_P
     (
          cursor_name opt_cursor_parameters?
        | selectstmt
        | explainstmt
        | EXECUTE a_expr opt_for_using_expression?
        | opt_reverse? a_expr DOT_DOT a_expr opt_by_expression?
     )
   ;

opt_for_using_expression
   : USING expr_list
   ;

opt_cursor_parameters
   : OPEN_PAREN a_expr (COMMA a_expr)* CLOSE_PAREN
   ;

opt_reverse
   : REVERSE
   ;

opt_by_expression
   : BY a_expr
   ;

for_variable
   : any_name_list
   ;

stmt_foreach_a
   : opt_loop_label? FOREACH for_variable foreach_slice? IN_P ARRAY a_expr loop_body
   ;

foreach_slice
   : SLICE iconst
   ;

stmt_exit
   : exit_type opt_label? opt_exitcond? SEMI
   ;

exit_type
   : EXIT
   | CONTINUE_P
   ;
   //todo implement RETURN statement according to initial grammar line 1754

stmt_return
   : RETURN (NEXT sql_expression | QUERY (EXECUTE a_expr opt_for_using_expression? | selectstmt) | opt_return_result?) SEMI
   ;

opt_return_result
   : sql_expression
   ;
   //https://www.postgresql.org/docs/current/plpgsql-errors-and-messages.html

   //RAISE [ level ] 'format' [, expression [, ... ]] [ USING option = expression [, ... ] ];

   //RAISE [ level ] condition_name [ USING option = expression [, ... ] ];

   //RAISE [ level ] SQLSTATE 'sqlstate' [ USING option = expression [, ... ] ];

   //RAISE [ level ] USING option = expression [, ... ];

   //RAISE ;

stmt_raise
   : RAISE opt_stmt_raise_level? sconst opt_raise_list? opt_raise_using? SEMI
   | RAISE opt_stmt_raise_level? identifier opt_raise_using? SEMI
   | RAISE opt_stmt_raise_level? SQLSTATE sconst opt_raise_using? SEMI
   | RAISE opt_stmt_raise_level? opt_raise_using? SEMI
   | RAISE
   ;

opt_stmt_raise_level
   : DEBUG
   | LOG
   | INFO
   | NOTICE
   | WARNING
   | EXCEPTION
   ;

opt_raise_list
   : (COMMA a_expr)+
   ;

opt_raise_using
   : USING opt_raise_using_elem_list
   ;

opt_raise_using_elem
   : identifier EQUAL a_expr
   ;

opt_raise_using_elem_list
   : opt_raise_using_elem (COMMA opt_raise_using_elem)*
   ;
   //todo imnplement

stmt_assert
   : ASSERT sql_expression opt_stmt_assert_message? SEMI
   ;

opt_stmt_assert_message
   : COMMA sql_expression
   ;

loop_body
   : LOOP proc_sect END_P LOOP opt_label? SEMI
   ;
   //TODO: looks like all other statements like INSERT/SELECT/UPDATE/DELETE are handled here;

   //pls take a look at original grammar

stmt_execsql
   : make_execsql_stmt SEMI
/*K_IMPORT
            | K_INSERT
            | t_word
            | t_cword
*/


   ;
   //https://www.postgresql.org/docs/current/plpgsql-statements.html#PLPGSQL-STATEMENTS-SQL-NORESULT

   //EXECUTE command-string [ INTO [STRICT] target ] [ USING expression [, ... ] ];

stmt_dynexecute
   : EXECUTE a_expr (
/*this is silly, but i have to time to find nice way to code */

   opt_execute_into? opt_execute_using? | opt_execute_using? opt_execute_into? |) SEMI
   ;

opt_execute_using
   : USING opt_execute_using_list
   ;

opt_execute_using_list
   : a_expr (COMMA a_expr)*
   ;

opt_execute_into
   : INTO STRICT_P? into_target
   ;
   //https://www.postgresql.org/docs/current/plpgsql-cursors.html#PLPGSQL-CURSOR-OPENING

   //OPEN unbound_cursorvar [ [ NO ] SCROLL ] FOR query;

   //OPEN unbound_cursorvar [ [ NO ] SCROLL ] FOR EXECUTE query_string

   //                                     [ USING expression [, ... ] ];

   //OPEN bound_cursorvar [ ( [ argument_name := ] argument_value [, ...] ) ];

stmt_open
   : OPEN
     (
          cursor_variable opt_scroll_option? FOR (selectstmt | EXECUTE sql_expression opt_open_using?)
        | colid (OPEN_PAREN opt_open_bound_list CLOSE_PAREN)?
     ) SEMI
   ;

opt_open_bound_list_item
   : colid COLON_EQUALS a_expr
   | a_expr
   ;

opt_open_bound_list
   : opt_open_bound_list_item (COMMA opt_open_bound_list_item)*
   ;

opt_open_using
   : USING expr_list
   ;

opt_scroll_option
   : opt_scroll_option_no? SCROLL
   ;

opt_scroll_option_no
   : NO
   ;
   //https://www.postgresql.org/docs/current/plpgsql-cursors.html#PLPGSQL-CURSOR-OPENING

   //FETCH [ direction { FROM | IN } ] cursor INTO target;

stmt_fetch
   : FETCH direction = opt_fetch_direction? opt_cursor_from? cursor_variable INTO into_target SEMI
   ;

into_target
   : expr_list
   ;

opt_cursor_from
   : FROM
   | IN_P
   ;

opt_fetch_direction
   : NEXT
   | PRIOR
   | FIRST_P
   | LAST_P
   | ABSOLUTE_P a_expr
   | RELATIVE_P a_expr
   | a_expr
   | ALL
   | (FORWARD | BACKWARD) (a_expr | ALL)?
   ;
   //https://www.postgresql.org/docs/current/plpgsql-cursors.html#PLPGSQL-CURSOR-OPENING

   //MOVE [ direction { FROM | IN } ] cursor;

stmt_move
   : MOVE opt_fetch_direction? cursor_variable SEMI
   ;

stmt_close
   : CLOSE cursor_variable SEMI
   ;

stmt_null
   : NULL_P SEMI
   ;

stmt_commit
   : COMMIT plsql_opt_transaction_chain? SEMI
   ;

stmt_rollback
   : ROLLBACK plsql_opt_transaction_chain? SEMI
   ;

plsql_opt_transaction_chain
   : AND NO? CHAIN
   ;

stmt_set
   : SET any_name TO DEFAULT SEMI
   | RESET (any_name | ALL) SEMI
   ;

cursor_variable
   : colid
   | PARAM
   ;

exception_sect
   : EXCEPTION proc_exceptions
   ;

proc_exceptions
   : proc_exception+
   ;

proc_exception
   : WHEN proc_conditions THEN proc_sect
   ;

proc_conditions
   : proc_condition (OR proc_condition)*
   ;

proc_condition
   : any_identifier
   | SQLSTATE sconst
   ;
   //expr_until_semi:

   //;

   //expr_until_rightbracket:

   //;

   //expr_until_loop:

   //;

opt_block_label
   : label_decl
   ;

opt_loop_label
   : label_decl
   ;

opt_label
   : any_identifier
   ;

opt_exitcond
   : WHEN expr_until_semi
   ;

any_identifier
   : colid
   | plsql_unreserved_keyword
   ;

plsql_unreserved_keyword
   : ABSOLUTE_P
   | ALIAS
   | AND
   | ARRAY
   | ASSERT
   | BACKWARD
   | CALL
   | CHAIN
   | CLOSE
   | COLLATE
   | COLUMN
   //| COLUMN_NAME
   | COMMIT
   | CONSTANT
   | CONSTRAINT
   //| CONSTRAINT_NAME
   | CONTINUE_P
   | CURRENT_P
   | CURSOR
   //| DATATYPE
   | DEBUG
   | DEFAULT
   //| DETAIL
   | DIAGNOSTICS
   | DO
   | DUMP
   | ELSIF
   //| ERRCODE
   | ERROR
   | EXCEPTION
   | EXIT
   | FETCH
   | FIRST_P
   | FORWARD
   | GET
   //| HINT

   //| IMPORT
   | INFO
   | INSERT
   | IS
   | LAST_P
   //| MESSAGE

   //| MESSAGE_TEXT
   | MOVE
   | NEXT
   | NO
   | NOTICE
   | OPEN
   | OPTION
   | PERFORM
   //| PG_CONTEXT

   //| PG_DATATYPE_NAME

   //| PG_EXCEPTION_CONTEXT

   //| PG_EXCEPTION_DETAIL

   //| PG_EXCEPTION_HINT
   | PRINT_STRICT_PARAMS
   | PRIOR
   | QUERY
   | RAISE
   | RELATIVE_P
   | RESET
   | RETURN
   //| RETURNED_SQLSTATE
   | ROLLBACK
   //| ROW_COUNT
   | ROWTYPE
   | SCHEMA
   //| SCHEMA_NAME
   | SCROLL
   | SET
   | SLICE
   | SQLSTATE
   | STACKED
   | TABLE
   //| TABLE_NAME
   | TYPE_P
   | USE_COLUMN
   | USE_VARIABLE
   | VARIABLE_CONFLICT
   | WARNING
   | OUTER_P
   ;

sql_expression
   : opt_target_list? into_clause? from_clause? where_clause? group_clause? having_clause? window_clause?
   ;

expr_until_then
   : sql_expression
   ;

expr_until_semi
   : sql_expression
   ;

expr_until_rightbracket
   : a_expr
   ;

expr_until_loop
   : a_expr
   ;

make_execsql_stmt
   : stmt opt_returning_clause_into?
   ;

opt_returning_clause_into
   : INTO opt_strict? into_target
   ;
