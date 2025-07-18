package parser_test

import (
	"testing"

	"github.com/antlr4-go/antlr/v4"
	rsparser "github.com/bytebase/redshift-parser"
	"github.com/stretchr/testify/require"
)

func TestRedshiftSyntax(t *testing.T) {
	statement := `CREATE TABLE t(id INT IDENTITY(1, 1));`
	rsLexer, rsParser := newParser(rsparser.EngineRedshift, statement)
	rsLexerErrors := &CustomErrorListener{}
	rsLexer.RemoveErrorListeners()
	rsLexer.AddErrorListener(rsLexerErrors)

	rsParserErrors := &CustomErrorListener{}
	rsParser.RemoveErrorListeners()
	rsParser.AddErrorListener(rsParserErrors)

	tree := rsParser.Root()
	require.NotNil(t, tree, "Redshift parser should not return nil tree")
	require.Equal(t, 0, rsLexerErrors.errors)
	require.Equal(t, 0, rsParserErrors.errors)

	pgLexer, pgParser := newParser(rsparser.EnginePostgreSQL, statement)
	pgLexerErrors := &CustomErrorListener{}
	pgLexer.RemoveErrorListeners()
	pgLexer.AddErrorListener(pgLexerErrors)

	pgParserErrors := &CustomErrorListener{}
	pgParser.RemoveErrorListeners()
	pgParser.AddErrorListener(pgParserErrors)

	tree = pgParser.Root()
	require.Equal(t, 0, pgLexerErrors.errors)
	require.Equal(t, 1, pgParserErrors.errors)
}

func newParser(engine rsparser.Engine, stmt string) (*rsparser.RedshiftLexer, *rsparser.RedshiftParser) {
	input := antlr.NewInputStream(stmt)

	lexer := rsparser.NewRedshiftLexer(input)

	stream := antlr.NewCommonTokenStream(lexer, 0)
	p := rsparser.NewRedshiftParser(stream)
	p.Engine = engine
	p.BuildParseTrees = true

	return lexer, p
}
