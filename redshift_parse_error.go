package parser

type RedshiftParseError struct {
	Number  int
	Offset  int
	Line    int
	Column  int
	Message string
}
