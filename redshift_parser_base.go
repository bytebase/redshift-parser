package parser

import (
	"strings"

	"github.com/antlr4-go/antlr/v4"
)

type RedshiftParserBase struct {
	*antlr.BaseParser

	parseErrors []*RedshiftParseError
}

func NewRedshiftParserBase(input antlr.TokenStream) *RedshiftParserBase {
	return &RedshiftParserBase{
		BaseParser: antlr.NewBaseParser(input),
	}
}

func (receiver *RedshiftParserBase) GetParsedSqlTree(script string, line int) antlr.ParserRuleContext {
	parser := getRedshiftParser(script)
	result := parser.Root()
	for _, err := range parser.parseErrors {
		receiver.parseErrors = append(receiver.parseErrors, &RedshiftParseError{
			Number:  err.Number,
			Offset:  err.Offset,
			Line:    err.Line + line,
			Column:  err.Column,
			Message: err.Message,
		})
	}
	return result
}

func (receiver *RedshiftParserBase) ParseRoutineBody(localContextInterface ICreatefunc_opt_listContext) {
	localContext, ok := localContextInterface.(*Createfunc_opt_listContext)
	if !ok {
		return
	}

	var lang string
	for _, coi := range localContext.AllCreatefunc_opt_item() {
		createFuncOptItemContext, ok := coi.(*Createfunc_opt_itemContext)
		if !ok || createFuncOptItemContext.LANGUAGE() == nil {
			continue
		}
		nonReservedWordOrSConstContextInterface := createFuncOptItemContext.Nonreservedword_or_sconst()
		if nonReservedWordOrSConstContextInterface == nil {
			continue
		}
		nonReservedWordOrSConstContext, ok := nonReservedWordOrSConstContextInterface.(*Nonreservedword_or_sconstContext)
		if !ok {
			continue
		}
		nonReservedWordContextInterface := nonReservedWordOrSConstContext.Nonreservedword()
		if nonReservedWordContextInterface == nil {
			continue
		}
		nonReservedWordContext, ok := nonReservedWordContextInterface.(*NonreservedwordContext)
		if !ok {
			continue
		}
		identifierInterface := nonReservedWordContext.Identifier()
		if identifierInterface == nil {
			continue
		}
		identifier, ok := identifierInterface.(*IdentifierContext)
		if !ok {
			continue
		}
		node := identifier.Identifier()
		if node == nil {
			continue
		}
		lang = node.GetText()
		break
	}
	if lang == "" {
		return
	}

	var funcAs *Createfunc_opt_itemContext
	for _, coi := range localContext.AllCreatefunc_opt_item() {
		ctx, ok := coi.(*Createfunc_opt_itemContext)
		if !ok || ctx.AS() == nil {
			continue
		}
		as := ctx.Func_as()
		if as != nil {
			funcAs = ctx
			break
		}
	}
	if funcAs == nil {
		return
	}

	funcAsContextInterface := funcAs.Func_as()
	if funcAsContextInterface == nil {
		return
	}
	funcAsContext, ok := funcAsContextInterface.(*Func_asContext)
	if !ok {
		return
	}
	sConstContextInterface := funcAsContext.Sconst(0)
	if sConstContextInterface == nil {
		return
	}
	sConstContext, ok := sConstContextInterface.(*SconstContext)
	if !ok {
		return
	}
	text := GetRoutineBodyString(sConstContext)
	line := sConstContext.GetStart().GetLine()
	parser := getRedshiftParser(text)
	switch lang {
	case "plpgsql":
		funcAs.Func_as().(*Func_asContext).Definition = parser.Plsqlroot()
	case "sql":
		funcAs.Func_as().(*Func_asContext).Definition = parser.Root()
	}
	for _, err := range parser.parseErrors {
		receiver.parseErrors = append(receiver.parseErrors, &RedshiftParseError{
			Number:  err.Number,
			Offset:  err.Offset,
			Line:    err.Line + line,
			Column:  err.Column,
			Message: err.Message,
		})
	}
}

func TrimQuotes(s string) string {
	if s == "" {
		return s
	}
	return s[1 : len(s)-2]
}

func unquote(s string) string {
	result := strings.Builder{}
	length := len(s)
	index := 0
	for index < length {
		c := s[index]
		result.WriteByte(c)
		if c == '\'' && index < length-1 && (s[index+1] == '\'') {
			index++
		}
		index++
	}
	return result.String()
}

func GetRoutineBodyString(rule *SconstContext) string {
	if rule.Anysconst() == nil {
		return ""
	}
	anySConstContext := rule.Anysconst().(*AnysconstContext)

	stringConstant := anySConstContext.StringConstant()
	if stringConstant != nil {
		return unquote(TrimQuotes(stringConstant.GetText()))
	}

	unicodeEscapeStringConstant := anySConstContext.UnicodeEscapeStringConstant()
	if unicodeEscapeStringConstant != nil {
		return TrimQuotes(unicodeEscapeStringConstant.GetText())
	}

	escapeStringConstant := anySConstContext.EscapeStringConstant()
	if escapeStringConstant != nil {
		return TrimQuotes(escapeStringConstant.GetText())
	}

	result := strings.Builder{}
	for _, node := range anySConstContext.AllDollarText() {
		result.WriteString(node.GetText())
	}
	return result.String()
}

func getRedshiftParser(script string) *RedshiftParser {
	stream := antlr.NewInputStream(script)
	lexer := NewRedshiftLexer(stream)
	tokenStream := antlr.NewCommonTokenStream(lexer, 0)
	parser := NewRedshiftParser(tokenStream)
	errorListener := new(RedshiftParserErrorListener)
	errorListener.grammar = parser
	parser.AddErrorListener(errorListener)
	return parser
}
