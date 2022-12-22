#[derive(Debug)]
pub enum TokenType {
    Let,
    Identifier,
    Assign,
    String,
}

#[derive(Debug)]
pub struct Token {
    pub token_type: TokenType,
    pub literal: String,
}

impl Token {
    pub fn new(token_type: TokenType, literal: String) -> Self {
        Self {
            token_type,
            literal,
        }
    }
}

#[derive(Debug)]
pub struct Lexer {
    chars: Vec<char>,
    tokens: Vec<Token>,
    counter: usize,
}

impl Lexer {
    pub fn new(contents: &str) -> Self {
        Self {
            chars: contents.chars().collect(),
            tokens: vec![],
            counter: 0,
        }
    }

    pub fn current_char(&mut self) -> char {
        *self.chars.get(self.counter).unwrap()
    }

    // do lexing or tokenizing the chars
    pub fn lex(&mut self) {
        let mut tokens: Vec<Token> = vec![];

        while self.counter < self.chars.len() {
            let c = self.current_char();

            match c {
                '=' => {
                    self.counter += 1;
                    tokens.push(Token::new(TokenType::Assign, "=".to_owned()))
                }
                '\'' => {
                    
                }
                _ => {
                    self.counter += 1;
                }
            }
        }

        println!("{:?}", tokens);
        self.tokens = tokens;
    }
}
