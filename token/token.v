module token

type TokenType = string

pub struct Token {
pub mut:
	token_type TokenType
	literal    string
}

pub const (
	illegal   = 'ILLEGAL'
	eof       = 'EOF'

	// Identifiers + literals
	ident     = 'IDENT' // add, foobar, x, y, ...
	int       = 'INT' // 1343456
	// Operators
	assign    = '='
	plus      = '+'
	minus     = '-'
	bang      = '!'
	asterisk  = '*'
	slash     = '/'
	lt        = '<'
	gt        = '>'
	eq        = '=='
	not_eq    = '!='

	// Delimiters
	l_brace      = '{'
	r_brace      = '}'
	l_paren      = '('
	r_paren      = ')'
	semicolon    = ';'
	colon        = ','
	// Keywords
	key_function = 'fn'
	key_let      = 'let'
	key_true     = 'true'
	key_false    = 'false'
	key_if       = 'if'
	key_else     = 'else'
	key_return   = 'return'
	keywords     = {
		'fn': key_function
		'let': key_let
		'true': key_true
		'false': key_false
		'if': key_if
		'else': key_else
		'return': key_return
	}
)

pub fn lookup_identifier(ident_ string) string {
	if ident_ in keywords {
		return ident_
	}
	return ident
}