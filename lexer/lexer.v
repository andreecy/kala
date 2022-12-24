module lexer

import token

pub struct Lexer {
mut:
	input    string
	pos      int
	// current pos in input (points to current char)
	read_pos int
	// current reading pos in input (after current char)
	ch       byte
	// current char under examination
}

pub fn new(input string) Lexer {
	mut l := Lexer{
		input: input
	}
	l.read_char()
	return l
}

fn (mut l Lexer) read_char() {
	if l.read_pos >= l.input.len {
		l.ch = 0
	} else {
		l.ch = l.input[l.read_pos]
	}
	l.pos = l.read_pos
	l.read_pos += 1
}

fn (l Lexer) peek_char() byte {
	if l.read_pos >= l.input.len {
		return 0
	}
	return l.input[l.read_pos]
}

pub fn (mut l Lexer) next_token() token.Token {
	mut tok := token.Token{}
	l.skip_whitespaces()
	match l.ch {
		`=` {
			if l.peek_char() == `=` {
				ch := l.ch
				l.read_char()
				tok = token.Token{token.eq, ch.str() + l.ch.str()}
				l.read_char()
			} else {
				tok = new_token(token.assign, l.ch)
				l.read_char()
			}
		}
		`;` {
			tok = new_token(token.semicolon, l.ch)
			l.read_char()
		}
		`(` {
			tok = new_token(token.l_paren, l.ch)
			l.read_char()
		}
		`)` {
			tok = new_token(token.r_paren, l.ch)
			l.read_char()
		}
		`,` {
			tok = new_token(token.colon, l.ch)
			l.read_char()
		}
		`+` {
			tok = new_token(token.plus, l.ch)
			l.read_char()
		}
		`-` {
			tok = new_token(token.minus, l.ch)
			l.read_char()
		}
		`*` {
			tok = new_token(token.asterisk, l.ch)
			l.read_char()
		}
		`/` {
			tok = new_token(token.slash, l.ch)
			l.read_char()
		}
		`!` {
			if l.peek_char() == `=` {
				ch := l.ch
				l.read_char()
				tok = token.Token{token.not_eq, ch.str() + l.ch.str()}
				l.read_char()
			} else {
				tok = new_token(token.assign, l.ch)
				l.read_char()
			}
		}
		`<` {
			tok = new_token(token.lt, l.ch)
			l.read_char()
		}
		`>` {
			tok = new_token(token.gt, l.ch)
			l.read_char()
		}
		`{` {
			tok = new_token(token.l_brace, l.ch)
			l.read_char()
		}
		`}` {
			tok = new_token(token.r_brace, l.ch)
			l.read_char()
		}
		0 {
			tok.literal = ''
			tok.token_type = token.eof
		}
		else {
			if is_letter(l.ch) {
				tok.literal = l.read_identifier()
				tok.token_type = token.lookup_identifier(tok.literal)
			} else if l.ch.is_digit() {
				tok.token_type = token.int
				tok.literal = l.read_number()
			} else {
				tok = new_token(token.illegal, l.ch)
			}
		}
	}
	l.read_char()
	return tok
}

fn new_token(token_type token.TokenType, ch byte) token.Token {
	return token.Token{
		token_type: token_type
		literal: ch.ascii_str()
	}
}

fn (mut l Lexer) read_identifier() string {
	pos := l.pos
	for is_letter(l.ch) {
		l.read_char()
	}
	return l.input[pos..l.pos]
}

fn is_letter(a byte) bool {
	return (a >= `a` && a <= `z`) || (a >= `A` && a <= `Z`) || (a == `_`)
}

fn (mut l Lexer) skip_whitespaces() {
	for l.ch == ` ` || l.ch == `\t` || l.ch == `\n` || l.ch == `\r` {
		l.read_char()
	}
}

fn (mut l Lexer) read_number() string {
	pos := l.pos
	for l.ch.is_digit() {
		l.read_char()
	}
	return l.input[pos..l.pos]
}

fn is_digit(ch byte) bool {
	return `0` <= ch && ch <= `9`
}
