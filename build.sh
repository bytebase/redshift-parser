#!/bin/bash
antlr -Dlanguage=Go -package parser -visitor -o . RedshiftLexer.g4 RedshiftParser.g4