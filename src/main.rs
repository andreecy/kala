use std::env;
use std::fs::File;
use std::io::prelude::*;

mod lexer;

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
        Ok(_) => {},
    }

    let mut lx = lexer::Lexer::new(&contents);
    lx.lex();
}
