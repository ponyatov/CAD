# var
MODULE = $(notdir $(CURDIR))
REL    = $(shell git rev-parse --short=4    HEAD)
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
NOW    = $(shell date +%d%m%y)

# version
JQUERY_VER = 3.7.1

# cross
TARGET = wasm32-unknown-unkown

# dir
CWD   = $(CURDIR)
TMP   = $(CWD)/tmp
CAR   = $(HOME)/.cargo/bin
REF   = $(CWD)/ref
GZ    = $(HOME)/gz

# tool
CURL   = curl -L -o
CF     = clang-format -style=file -i
RUSTUP = $(CAR)/rustup
CARGO  = $(CAR)/cargo
GITREF = git clone --depth 1

# src
R += $(wildcard src/*.rs)
R += $(wildcard src/gui/*.rs)
R += $(wildcard src/gx/*.rs)
R += $(wildcard config/src/*.rs)
R += $(wildcard server/src/*.rs)
C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)
J += $(wildcard server/static/*.js)

# all
.PHONY: run all tests
all: $(R)
	$(CARGO) build
run: lib/$(MODULE).ini $(R)
	RUST_LOG=debug $(CARGO) run -- $<
tests: $(R)
	$(CARGO) test --all

.PHONY: server
server: $(R)
	$(CARGO) run -p $@

# format
.PHONY: format
format: tmp/format_rs tmp/format_js
tmp/format_rs: $(R)
	$(CARGO) check --workspace && $(CARGO) fmt && touch $@
tmp/format_js: $(J)
	$(CF) $? && touch $@

# rule

# doc
.PHONY: doc
doc: \
	$(HOME)/doc/Rust/The_Rust_Programming_Language.pdf \
	$(HOME)/doc/CAD/IGS_ru.pdf \
	$(HOME)/doc/CAD/Fundamentals-of-Computer-Graphics-Fourth-Edition.pdf

$(HOME)/doc/Rust/The_Rust_Programming_Language.pdf:
	$(CURL) $@ https://www.scs.stanford.edu/~zyedidia/docs/rust/rust_book.pdf
$(HOME)/doc/CAD/IGS_ru.pdf:
	$(CURL) $@ https://github.com/ponyatov/CAD/releases/download/230924-01f4/IGS_ru.pdf
$(HOME)/doc/CAD/Fundamentals-of-Computer-Graphics-Fourth-Edition.pdf:
	$(CURL) $@ https://github.com/ponyatov/CAD/releases/download/230924-01f4/Fundamentals-of-Computer-Graphics-Fourth-Edition.pdf
# http://repo.darmajaya.ac.id/5422/1/Fundamentals%20of%20Computer%20Graphics%2C%20Fourth%20Edition%20%28%20PDFDrive%20%29.pdf


.PHONY: doxy
doxy: $(R)
	$(CARGO) doc --no-deps --document-private-items \
					--workspace --target-dir docs

# install
.PHONY: install update ref gz
install: doc ref gz $(RUSTUP)
	$(MAKE) rust update
update: $(RUSTUP)
	sudo apt update
	sudo apt install -uy `cat apt.txt`
	$(RUSTUP) self update ; $(RUSTUP) update stable
gz:  cdn

.PHONY: rust
rust: $(RUSTUP)
	$(RUSTUP) component add rustfmt
	$(CARGO)  install wasm-bindgen-cli
	$(RUSTUP) target add $(TARGET)
$(RUSTUP):
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# cdn
CDNJS = https://cdnjs.cloudflare.com/ajax/libs
.PHONY: cdn
cdn: \
	server/static/cdn/jquery.min.js
server/static/cdn/jquery.min.js:
	$(CURL) $@ $(CDNJS)/jquery/$(JQUERY_VER)/jquery.min.js

# ref
ref: \
	ref/lvgl/README.md \
	ref/micromath/README.md ref/vector2math/README.md

ref/lvgl/README.md:
	$(GITREF) -b release/v5 https://github.com/lvgl/lvgl.git ref/lvgl

ref/micromath/README.md:
	$(GITREF) https://github.com/tarcieri/micromath.git ref/micromath

ref/vector2math/README.md:
	$(GITREF) https://github.com/kaikalii/vector2math.git ref/vector2math

# merge
MERGE += Makefile README.md apt.txt LICENSE
MERGE += .clang-format .doxygen .gitignore
MERGE += .vscode bin doc img lib inc src tmp ref
MERGE += .cargo Cargo.* *.toml

.PHONY: dev
dev:
	git push -v
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)

.PHONY: shadow
shadow:
	git push -v
	git checkout $@
	git pull -v

.PHONY: rust
rust:
	git push -v
	git checkout $@
	git pull -v

.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v --tags
	$(MAKE) rust

.PHONY: zip
zip:
	git archive \
		--format zip \
		--output $(TMP)/$(MODULE)_$(NOW)_$(REL).src.zip \
	HEAD
