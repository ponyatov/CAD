# src
R += $(wildcard src/*.rs)
S += $(R) Cargo.toml

# merge
MERGE += README.md Makefile apt.Debian .gitignore .clang-format $(S)
MERGE += .vscode bin doc lib inc src tmp ref
