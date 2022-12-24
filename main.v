import lexer
import token

fn main(){
	input := "let foo = 5"
	mut l := lexer.new(input)

	mut tok := l.next_token()
	println(tok)
	tok = l.next_token()
	println(tok)
	tok = l.next_token()
	println(tok)
	tok = l.next_token()
	println(tok)

	// for tok := l.next_token(); tok.token_type != token.eof; tok = l.next_token() {
	// 	println(tok)
	// }
}