#![allow(non_upper_case_globals)]
#![allow(unused_imports)]
#![allow(dead_code)]

extern crate config;
mod gui;
mod gx;

// #[macro_use]
// extern crate log;
// extern crate env_logger;

/// program entry point
/// * `argv` command line arguments
fn main() {
    // logging
    // std::env::set_var("RUST_LOG", "debug");
    env_logger::init();
    log::info!(std::stringify!(main));

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
