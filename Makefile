all: build test

build:
	antlr -Dlanguage=Go -package parser -visitor -o . RedshiftLexer.g4 RedshiftParser.g4

test: redshift-test pg-test

redshift-test:
	go test -v -run TestRedshiftSpecificParser

pg-test:
	go test -v -run TestRedshiftParser
