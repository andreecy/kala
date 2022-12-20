use std::env;
use std::fs::File;
use std::io::prelude::*;
use std::str::FromStr;

#[derive(Debug)]
enum TokenType {
    Let,
    Identifier,
    Assign,
    String,
}

#[derive(Debug)]
struct Token {
    pub token_type: TokenType,
    pub literal: String,
}

impl Token {
    pub fn new(token_type: TokenType, value: &str) -> Token {
        Token {
            token_type,
            literal: String::from(value),
        }
    }
}

#[derive(Debug)]
struct Lexer {
    tokens: Vec<Token>,
}

impl Lexer {
    pub fn new(contents: &str) -> Lexer {
        let mut tokens: Vec<Token> = vec![];
        let token = Token::new(TokenType::String, "bar");
        tokens.push(token);

        Lexer { tokens: tokens }
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let path = &args[1];

    // Open the path in read-only mode, returns `io::Result<File>`
    let mut file = match File::open(&path) {
        Err(why) => panic!("couldn't open {}: {}", path, why),
        Ok(file) => file,
    };

    // Read the file contents into a string, returns `io::Result<usize>`
    let mut contents = String::new();
    match file.read_to_string(&mut contents) {
        Err(why) => panic!("couldn't read {}: {}", path, why),
        Ok(_) => println!("{} contains:\n{}", path, contents),
    }

    let lexer = Lexer::new(&contents);
    println!("{:?}", lexer);
}
