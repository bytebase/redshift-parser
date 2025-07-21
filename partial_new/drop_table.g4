grammar drop_table;

options {
    tokenVocab = RedshiftLexer;
    superClass = RedshiftParserBase;
}

// DROP TABLE statement
// Syntax: DROP TABLE [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
dropTableStmt
    : DROP TABLE ifExists? tableNameList cascadeRestrict?
    ;

ifExists
    : IF EXISTS
    ;

tableNameList
    : tableName (COMMA tableName)*
    ;

tableName
    : schemaQualifiedName
    ;

schemaQualifiedName
    : (schemaName DOT)? relationName
    ;

schemaName
    : colId
    ;

relationName
    : colId
    ;

cascadeRestrict
    : CASCADE
    | RESTRICT
    ;

colId
    : IDENT
    | unreservedKeyword
    | colNameKeyword
    | typeNameKeyword
    | reservedKeyword
    ;

// Keywords that can be used as column/table identifiers
unreservedKeyword
    : ABORT
    | ABSOLUTE
    | ACCESS
    | ACTION
    | ADD
    | ADMIN
    | AFTER
    | AGGREGATE
    | ALSO
    | ALTER
    | ALWAYS
    | ASSERTION
    | ASSIGNMENT
    | AT
    | ATTRIBUTE
    | BACKWARD
    | BEFORE
    | BEGIN
    | BY
    | CACHE
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
    | COMMENT
    | COMMENTS
    | COMMIT
    | COMMITTED
    | CONFIGURATION
    | CONNECTION
    | CONSTRAINTS
    | CONTENT
    | CONTINUE
    | CONVERSION
    | COPY
    | COST
    | CSV
    | CURRENT
    | CURSOR
    | CYCLE
    | DATA
    | DATABASE
    | DAY
    | DEALLOCATE
    | DECLARE
    | DEFAULTS
    | DEFERRED
    | DEFINER
    | DELETE
    | DELIMITER
    | DELIMITERS
    | DICTIONARY
    | DISABLE
    | DISCARD
    | DOCUMENT
    | DOMAIN
    | DOUBLE
    | DROP
    | EACH
    | ENABLE
    | ENCODING
    | ENCRYPTED
    | ENUM
    | ESCAPE
    | EVENT
    | EXCLUDE
    | EXCLUDING
    | EXCLUSIVE
    | EXECUTE
    | EXPLAIN
    | EXTENSION
    | EXTERNAL
    | FAMILY
    | FIRST
    | FOLLOWING
    | FORCE
    | FORWARD
    | FUNCTION
    | FUNCTIONS
    | GLOBAL
    | GRANTED
    | HANDLER
    | HEADER
    | HOLD
    | HOUR
    | IDENTITY
    | IF
    | IMMEDIATE
    | IMMUTABLE
    | IMPLICIT
    | INCLUDING
    | INCREMENT
    | INDEX
    | INDEXES
    | INHERIT
    | INHERITS
    | INLINE
    | INSENSITIVE
    | INSERT
    | INSTEAD
    | INVOKER
    | ISOLATION
    | KEY
    | LABEL
    | LANGUAGE
    | LARGE
    | LAST
    | LC_COLLATE
    | LC_CTYPE
    | LEVEL
    | LISTEN
    | LOAD
    | LOCAL
    | LOCATION
    | LOCK
    | MAPPING
    | MATCH
    | MAXVALUE
    | MINUTE
    | MINVALUE
    | MODE
    | MONTH
    | MOVE
    | NAME
    | NAMES
    | NEXT
    | NO
    | NOTHING
    | NOTIFY
    | NOWAIT
    | NULLS
    | OBJECT
    | OF
    | OFF
    | OIDS
    | OPERATOR
    | OPTION
    | OPTIONS
    | OWNED
    | OWNER
    | PARSER
    | PARTIAL
    | PARTITION
    | PASSING
    | PASSWORD
    | PLANS
    | PRECEDING
    | PREPARE
    | PREPARED
    | PRESERVE
    | PRIOR
    | PRIVILEGES
    | PROCEDURAL
    | PROCEDURE
    | PROGRAM
    | QUOTE
    | RANGE
    | READ
    | REASSIGN
    | RECHECK
    | RECURSIVE
    | REF
    | REFRESH
    | REINDEX
    | RELATIVE
    | RELEASE
    | RENAME
    | REPEATABLE
    | REPLACE
    | REPLICA
    | RESET
    | RESTART
    | RESTRICT
    | RETURNS
    | REVOKE
    | ROLE
    | ROLLBACK
    | ROWS
    | RULE
    | SAVEPOINT
    | SCHEMA
    | SCROLL
    | SEARCH
    | SECOND
    | SECURITY
    | SEQUENCE
    | SEQUENCES
    | SERIALIZABLE
    | SERVER
    | SESSION
    | SET
    | SHARE
    | SHOW
    | SIMPLE
    | SNAPSHOT
    | STABLE
    | STANDALONE
    | START
    | STATEMENT
    | STATISTICS
    | STDIN
    | STDOUT
    | STORAGE
    | STRICT
    | STRIP
    | SYSID
    | SYSTEM
    | TABLES
    | TABLESPACE
    | TEMP
    | TEMPLATE
    | TEMPORARY
    | TEXT
    | TRANSACTION
    | TRIGGER
    | TRUNCATE
    | TRUSTED
    | TYPE
    | UNBOUNDED
    | UNCOMMITTED
    | UNENCRYPTED
    | UNKNOWN
    | UNLISTEN
    | UNTIL
    | UPDATE
    | VACUUM
    | VALID
    | VALIDATOR
    | VALUE
    | VARYING
    | VERSION
    | VIEW
    | VOLATILE
    | WHITESPACE
    | WITHOUT
    | WORK
    | WRAPPER
    | WRITE
    | XML
    | YEAR
    | YES
    | ZONE
    ;

colNameKeyword
    : BETWEEN
    | BIGINT
    | BOOLEAN
    | CHAR
    | CHARACTER
    | COALESCE
    | DEC
    | DECIMAL
    | EXISTS
    | EXTRACT
    | FLOAT
    | GREATEST
    | GROUPING
    | INOUT
    | INT
    | INTEGER
    | INTERVAL
    | LEAST
    | NATIONAL
    | NCHAR
    | NONE
    | NULLIF
    | NUMERIC
    | OUT
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
    | XMLPARSE
    | XMLPI
    | XMLROOT
    | XMLSERIALIZE
    ;

typeNameKeyword
    : AUTHORIZATION
    | BINARY
    | COLLATION
    | CONCURRENTLY
    | CROSS
    | CURRENT_SCHEMA
    | FREEZE
    | FULL
    | ILIKE
    | INNER
    | IS
    | ISNULL
    | JOIN
    | LEFT
    | LIKE
    | NATURAL
    | NOTNULL
    | OUTER
    | OVER
    | OVERLAPS
    | RIGHT
    | SIMILAR
    | VERBOSE
    | FREEZE
    ;

reservedKeyword
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
    | DEFAULT
    | DEFERRABLE
    | DESC
    | DISTINCT
    | DO
    | ELSE
    | END
    | EXCEPT
    | FALSE
    | FETCH
    | FOR
    | FOREIGN
    | FROM
    | GRANT
    | GROUP
    | HAVING
    | IN
    | INITIALLY
    | INTERSECT
    | INTO
    | LEADING
    | LIMIT
    | LOCALTIME
    | LOCALTIMESTAMP
    | NOT
    | NULL
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
    | TRUE
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