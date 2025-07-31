# Migration Plan: Integrating partial_new/ into Main Grammar Files

## Overview

This document outlines the detailed plan to merge the 113 individual command implementations from `partial_new/` into the main `RedshiftLexer.g4` and `RedshiftParser.g4` files.

## Key Issues Identified

### 1. Naming Convention Conflicts ⚠️ **CRITICAL**

**Current Main Grammar Convention:**
- Parser rules: `analyzestmt`, `callstmt`, `commentstmt` (lowercase, no underscores)
- Lexer tokens: `ABORT`, `WORK`, `TRANSACTION` (simple UPPERCASE)

**Our partial_new/ Implementation:**
- Parser rules: `abortStatement`, `callStmt`, `commentStatement` (camelCase)
- Custom token fragments: `fragment A : [aA];`

**Required Action:**
- Convert ALL rule names from camelCase to lowercase
- Remove custom case fragments, use existing lexer `caseInsensitive = true` option

### 2. Common Rules Already Implemented ⚠️ **CRITICAL**

**Existing Proven Rules (PostgreSQL-based):**
```antlr
a_expr          // General expressions
b_expr          // Basic expressions  
c_expr          // Column expressions
colid           // Column identifiers
func_application // Function calls
rolespec        // Role specifications
```

**Our Custom Implementations:**
- Custom expression parsers
- Custom identifier rules
- Custom function call syntax

**Required Action:**
- Replace our custom rules with existing proven ones
- Audit all expression usages in our commands
- Map our identifiers to existing `colid` pattern

### 3. Token Duplication Issues

**Analysis Needed:**
- Many tokens we defined likely already exist in `RedshiftLexer.g4`
- Need comprehensive audit of existing vs new tokens

### 4. Already Implemented Commands - Conflicts ⚠️ **HIGH PRIORITY**

**Commands with potential conflicts:**
- `analyzestmt` vs our `analyze.g4`
- `callstmt` vs our `call.g4`  
- `commentstmt` vs our `comment.g4`
- `copystmt` vs our `copy.g4`

**Required Action:**
- Compare implementations feature-by-feature
- Use the more complete/correct implementation
- Ensure Redshift-specific features are preserved

### 5. Grammar Structure Issues

**Current Issue:**
- Our files use `grammar Name;` (standalone grammars)
- Main grammar expects parser rules only

**Required Action:**
- Convert to parser rules that integrate into main `stmt` rule
- Remove grammar headers and standalone structure

### 6. Integration Points Missing

**Main stmt Rule Update Required:**
The main `stmt` rule in `RedshiftParser.g4` needs 113 new alternatives:
```antlr
stmt
   : alterusermappingstmt
   | analyzestmt
   | callstmt
   // ... existing rules ...
   | abortstmt          // NEW
   | alterdatabasestmt  // NEW (if different from existing)
   // ... 111 more new rules ...
   ;
```

## Migration Strategy

### Phase 1: Analysis & Audit ⏱️ **Est: 2-3 days**

#### 1.1 Conflict Analysis
- [ ] Compare existing vs new implementations for each command
- [ ] Identify commands that need merging vs replacement
- [ ] Document differences and choose best implementation

#### 1.2 Token Audit  
- [ ] List all tokens used in `partial_new/` files
- [ ] Check which tokens already exist in `RedshiftLexer.g4`
- [ ] Create mapping of new tokens needed

#### 1.3 Rule Mapping
- [ ] Create comprehensive mapping: `camelCase → lowercase_convention`
- [ ] Identify common rule replacements: `our_rule → existing_rule`
- [ ] Document dependency chain for complex rules

### Phase 2: Preparation ⏱️ **Est: 3-4 days**

#### 2.1 Naming Convention Conversion
- [ ] Create conversion script for rule names
- [ ] Convert all `partial_new/` files to use lowercase naming
- [ ] Remove custom case-insensitive fragments

#### 2.2 Common Rule Replacement
- [ ] Replace custom expression rules with `a_expr`, `b_expr`, `c_expr`
- [ ] Replace custom identifier rules with `colid`
- [ ] Replace custom function calls with `func_application`
- [ ] Update all rule references accordingly

#### 2.3 Token Deduplication
- [ ] Remove tokens that already exist in main lexer
- [ ] Prepare list of truly new tokens to add

### Phase 3: Integration ⏱️ **Est: 4-5 days**

#### 3.1 Lexer Integration (`RedshiftLexer.g4`)
- [ ] Add new required tokens following existing patterns
- [ ] Ensure alphabetical ordering is maintained
- [ ] Verify no duplicate tokens

#### 3.2 Parser Integration (`RedshiftParser.g4`)
- [ ] Add all new statement rules to the file
- [ ] Update main `stmt` rule with all 113 new alternatives
- [ ] Resolve any rule conflicts (existing vs new implementations)
- [ ] Maintain proper grouping/organization

#### 3.3 Dependency Resolution
- [ ] Ensure all referenced rules exist
- [ ] Add any missing supporting rules
- [ ] Verify rule hierarchy is correct

### Phase 4: Testing & Validation ⏱️ **Est: 2-3 days**

#### 4.1 Grammar Compilation
- [ ] Build grammar with ANTLR
- [ ] Fix any compilation errors
- [ ] Ensure no circular dependencies

#### 4.2 Basic Functionality Testing
- [ ] Test parsing of sample statements for each command
- [ ] Verify existing functionality still works
- [ ] Check against `examples/` SQL files

#### 4.3 Regression Testing
- [ ] Run existing parser tests
- [ ] Ensure no breaking changes to existing functionality
- [ ] Validate new command parsing

## Detailed Implementation Steps

### Step 1: Create Analysis Tools

```bash
# Create scripts to help with the migration
./tools/analyze_conflicts.sh      # Compare existing vs new implementations  
./tools/audit_tokens.sh           # List token usage
./tools/convert_naming.sh         # Convert camelCase to lowercase
./tools/validate_references.sh    # Check rule dependencies
```

### Step 2: Handle Specific Command Categories

#### Commands with Existing Implementations (Need Careful Merge)
1. **ANALYZE** - Compare with existing `analyzestmt`
2. **CALL** - Compare with existing `callstmt`  
3. **COMMENT** - Compare with existing `commentstmt`
4. **COPY** - Compare with existing `copystmt`

#### New Commands (Direct Integration)
- All ALTER commands specific to Redshift
- All CREATE commands not in PostgreSQL
- All SHOW commands
- All Redshift-specific commands (UNLOAD, etc.)

### Step 3: Priority Order for Integration

#### High Priority (Core Commands)
1. SELECT, INSERT, UPDATE, DELETE
2. CREATE TABLE, DROP TABLE, ALTER TABLE
3. Transaction commands (BEGIN, COMMIT, ROLLBACK)

#### Medium Priority (DDL Commands)  
1. All CREATE/DROP commands
2. All ALTER commands
3. GRANT/REVOKE

#### Lower Priority (Utility Commands)
1. SHOW commands
2. DESCRIBE commands
3. Administrative commands

## Risk Mitigation

### Backup Strategy
- [ ] Create backup of current working grammar files
- [ ] Tag current version in git before changes
- [ ] Create rollback plan

### Incremental Integration
- [ ] Integrate commands in small batches (10-15 at a time)
- [ ] Test after each batch
- [ ] Fix issues before proceeding to next batch

### Validation Checkpoints
- [ ] Grammar compiles successfully
- [ ] Existing tests pass
- [ ] Sample parsing works for new commands
- [ ] Performance impact is acceptable

## Success Criteria

1. ✅ All 113 commands parse correctly
2. ✅ No regression in existing functionality  
3. ✅ Grammar compiles without errors
4. ✅ Test coverage maintained or improved
5. ✅ Documentation updated
6. ✅ Performance impact < 10%

## Timeline Estimate

- **Total Estimated Time:** 11-15 days
- **Phase 1:** 2-3 days
- **Phase 2:** 3-4 days  
- **Phase 3:** 4-5 days
- **Phase 4:** 2-3 days

## Next Actions

1. **Immediate:** Start with Phase 1.1 - Conflict Analysis
2. **Priority:** Focus on commands with existing implementations first
3. **Tools:** Create automation scripts for repetitive tasks
4. **Communication:** Update progress regularly and document decisions

---

*This migration plan will be updated as we discover additional issues or requirements during implementation.*