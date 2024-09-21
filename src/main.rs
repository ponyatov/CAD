#![allow(unused_imports)]

mod gui;
mod gx;

// #[macro_use]
// extern crate log;
// extern crate env_logger;

/// program entry point
/// * `argv` command line arguments
fn main() {
    env_logger::init();
    let argv: Vec<String> = std::env::args().collect();
    arg(0, &argv[0]);
    for (k, v) in argv.into_iter().enumerate().skip(1) {
        arg(k, &v);
    }
    gx::init();
    gui::init();
}

/// dump single command line argument
/// * `argc` index
/// * `argv` value
fn arg(argc: usize, argv: &str) {
    log::info!("argv[{argc}] = {argv:?}");
}
