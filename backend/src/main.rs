extern crate uci;

use uci::Engine;

fn main() {
    let engine_result = Engine::new("./stockfish/stockfish_13_linux_x64_modern");
    match engine_result {
        Ok(engine) => {
            println!("{:?}", engine.bestmove());
        }
        Err(e) => {
            println!("{:?}", e);
        }
    }
}
