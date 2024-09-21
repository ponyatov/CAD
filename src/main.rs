fn main() {
    let argv: Vec<String> = std::env::args().collect();
    arg(0, &argv[0]);
    for (k, v) in argv.into_iter().skip(1).enumerate() {
        arg(k, &v);
    }
}

fn arg(argc: usize, argv: &str) {
    eprintln!("argv[{argc}] = <{argv}>");
}
