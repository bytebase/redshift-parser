# New Implementation Plan for Redshift SQL Commands

## Total Commands: 113

## File Naming Convention
- Each command gets its own file: `{command_name}.g4`
- Test files have the same name: `{command_name}.sql`
- Use underscores for multi-word commands: `alter_database.g4`

## Implementation Status

### A Commands (23 commands)
1. ✓ ABORT - abort.g4
2. ⏳ ALTER DATABASE - alter_database.g4
3. ✓ ALTER DATASHARE - alter_datashare.g4
4. ⏳ ALTER DEFAULT PRIVILEGES - alter_default_privileges.g4
5. ✓ ALTER EXTERNAL SCHEMA - alter_external_schema.g4
6. ✓ ALTER EXTERNAL VIEW - alter_external_view.g4
7. ⏳ ALTER FUNCTION - alter_function.g4
8. ⏳ ALTER GROUP - alter_group.g4
9. ✓ ALTER IDENTITY PROVIDER - alter_identity_provider.g4
10. ✓ ALTER MASKING POLICY - alter_masking_policy.g4
11. ⏳ ALTER MATERIALIZED VIEW - alter_materialized_view.g4
12. ✓ ALTER RLS POLICY - alter_rls_policy.g4
13. ⏳ ALTER ROLE - alter_role.g4
14. ⏳ ALTER PROCEDURE - alter_procedure.g4
15. ⏳ ALTER SCHEMA - alter_schema.g4
16. ✓ ALTER SYSTEM - alter_system.g4
17. ⏳ ALTER TABLE - alter_table.g4
18. ✓ ALTER TABLE APPEND - alter_table_append.g4
19. ⏳ ALTER USER - alter_user.g4
20. ✓ ANALYZE - analyze.g4
21. ✓ ANALYZE COMPRESSION - analyze_compression.g4
22. ✓ ATTACH MASKING POLICY - attach_masking_policy.g4
23. ✓ ATTACH RLS POLICY - attach_rls_policy.g4

### B Commands (1 command)
24. ✓ BEGIN - begin.g4

### C Commands (29 commands)
25. ✓ CALL - call.g4
26. ✓ CANCEL - cancel.g4
27. ✓ CLOSE - close.g4
28. ✓ COMMENT - comment.g4
29. ✓ COMMIT - commit.g4
30. ✓ COPY - copy.g4
31. ⏳ CREATE DATABASE - create_database.g4
32. ✓ CREATE DATASHARE - create_datashare.g4
33. ✓ CREATE EXTERNAL FUNCTION - create_external_function.g4
34. ✓ CREATE EXTERNAL MODEL - create_external_model.g4
35. ✓ CREATE EXTERNAL SCHEMA - create_external_schema.g4
36. ✓ CREATE EXTERNAL TABLE - create_external_table.g4
37. ✓ CREATE EXTERNAL VIEW - create_external_view.g4
38. ⏳ CREATE FUNCTION - create_function.g4
39. ⏳ CREATE GROUP - create_group.g4
40. ✓ CREATE IDENTITY PROVIDER - create_identity_provider.g4
41. ✓ CREATE LIBRARY - create_library.g4
42. ✓ CREATE MASKING POLICY - create_masking_policy.g4
43. ⏳ CREATE MATERIALIZED VIEW - create_materialized_view.g4
44. ✓ CREATE MODEL - create_model.g4
45. ⏳ CREATE PROCEDURE - create_procedure.g4
46. ✓ CREATE RLS POLICY - create_rls_policy.g4
47. ⏳ CREATE ROLE - create_role.g4
48. ⏳ CREATE SCHEMA - create_schema.g4
49. ⏳ CREATE TABLE - create_table.g4
50. ⏳ CREATE TABLE AS - create_table_as.g4
51. ⏳ CREATE USER - create_user.g4
52. ⏳ CREATE VIEW - create_view.g4

### D Commands (22 commands)
53. ✓ DEALLOCATE - deallocate.g4
54. ✓ DECLARE - declare.g4
55. ✓ DELETE - delete.g4
56. ✓ DESC DATASHARE - desc_datashare.g4
57. ✓ DESC IDENTITY PROVIDER - desc_identity_provider.g4
58. ✓ DETACH MASKING POLICY - detach_masking_policy.g4
59. ✓ DETACH RLS POLICY - detach_rls_policy.g4
60. ⏳ DROP DATABASE - drop_database.g4
61. ✓ DROP DATASHARE - drop_datashare.g4
62. ✓ DROP EXTERNAL VIEW - drop_external_view.g4
63. ⏳ DROP FUNCTION - drop_function.g4
64. ⏳ DROP GROUP - drop_group.g4
65. ✓ DROP IDENTITY PROVIDER - drop_identity_provider.g4
66. ✓ DROP LIBRARY - drop_library.g4
67. ✓ DROP MASKING POLICY - drop_masking_policy.g4
68. ✓ DROP MODEL - drop_model.g4
69. ⏳ DROP MATERIALIZED VIEW - drop_materialized_view.g4
70. ⏳ DROP PROCEDURE - drop_procedure.g4
71. ✓ DROP RLS POLICY - drop_rls_policy.g4
72. ⏳ DROP ROLE - drop_role.g4
73. ⏳ DROP SCHEMA - drop_schema.g4
74. ⏳ DROP TABLE - drop_table.g4
75. ⏳ DROP USER - drop_user.g4
76. ⏳ DROP VIEW - drop_view.g4

### E Commands (3 commands)
77. ✓ END - end.g4
78. ✓ EXECUTE - execute.g4
79. ✓ EXPLAIN - explain.g4

### F Commands (1 command)
80. ✓ FETCH - fetch.g4

### G Commands (1 command)
81. ✓ GRANT - grant.g4

### I Commands (2 commands)
82. ✓ INSERT - insert.g4
83. ⏳ INSERT (external table) - insert_external_table.g4

### L Commands (1 command)
84. ✓ LOCK - lock.g4

### M Commands (1 command)
85. ✓ MERGE - merge.g4

### P Commands (1 command)
86. ✓ PREPARE - prepare.g4

### R Commands (4 commands)
87. ✓ REFRESH MATERIALIZED VIEW - refresh_materialized_view.g4
88. ✓ RESET - reset.g4
89. ✓ REVOKE - revoke.g4
90. ✓ ROLLBACK - rollback.g4

### S Commands (19 commands)
91. ✓ SELECT - select.g4
92. ⏳ SELECT INTO - select_into.g4
93. ✓ SET - set.g4
94. ⏳ SET SESSION AUTHORIZATION - set_session_authorization.g4
95. ⏳ SET SESSION CHARACTERISTICS - set_session_characteristics.g4
96. ⏳ SHOW - show.g4
97. ✓ SHOW COLUMNS - show_columns.g4
98. ✓ SHOW EXTERNAL TABLE - show_external_table.g4
99. ✓ SHOW DATABASES - show_databases.g4
100. ✓ SHOW GRANTS - show_grants.g4
101. ✓ SHOW MODEL - show_model.g4
102. ✓ SHOW DATASHARES - show_datashares.g4
103. ✓ SHOW PROCEDURE - show_procedure.g4
104. ✓ SHOW SCHEMAS - show_schemas.g4
105. ⏳ SHOW TABLE - show_table.g4
106. ✓ SHOW TABLES - show_tables.g4
107. ✓ SHOW VIEW - show_view.g4
108. ✓ START TRANSACTION - start_transaction.g4

### T Commands (1 command)
109. ✓ TRUNCATE - truncate.g4

### U Commands (3 commands)
110. ✓ UNLOAD - unload.g4
111. ✓ UPDATE - update.g4
112. ✓ USE - use.g4

### V Commands (1 command)
113. ✓ VACUUM - vacuum.g4

## Summary
- **Total Commands**: 113
- **Already Implemented**: 77 (but in grouped files)
- **Need Individual Files**: All 113 commands
- **Missing Implementations**: 36 commands (mostly standard PostgreSQL commands)

## New Approach
1. Create individual .g4 file for each command
2. Create corresponding .sql test file for each command
3. Batch implementation by first letter for efficiency
4. Each file focuses on one specific command with all its variations