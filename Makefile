# var
MODULE = $(notdir $(CURDIR))
REL    = $(shell git rev-parse --short=4    HEAD)
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
NOW    = $(shell date +%d%m%y)

# version

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
CF     = clang-format
RUSTUP = $(CAR)/rustup
CARGO  = $(CAR)/cargo
GITREF = git clone --depth 1

# src
R += $(wildcard src/*.rs)
C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)

# all
.PHONY: run all
all: $(R)
	$(CARGO) build
run: lib/$(MODULE).ini $(R)
	$(CARGO) run -- $<

# format
.PHONY: format
format: tmp/format_rs
tmp/format_rs: $(R)
	$(CARGO) check && $(CARGO) fmt && touch $@

# rule
bin/$(MODULE): $(D) Makefile
	$(BLD)

$(REF)/%/configure: $(GZ)/%.tar.gz
	cd ref ; zcat $< | tar x && chmod +x $@ ; touch $@
$(REF)/%/README.md: $(GZ)/%.tar.gz
	cd ref ; zcat $< | tar x &&               touch $@

# doc
.PHONY: doc
doc: doc/The_Rust_Programming_Language.pdf

doc/The_Rust_Programming_Language.pdf: $(HOME)/doc/Rust/The_Rust_Programming_Language.pdf
	cd doc ; ln -fs ../../doc/Rust/The_Rust_Programming_Language.pdf The_Rust_Programming_Language.pdf
$(HOME)/doc/Rust/The_Rust_Programming_Language.pdf:
	$(CURL) $@ https://www.scs.stanford.edu/~zyedidia/docs/rust/rust_book.pdf

.PHONY: doxy
doxy: $(R)
	$(CARGO) doc --no-deps --document-private-items \
					--workspace --target-dir docs

# install
.PHONY: install update gz ref
install: doc gz
	$(MAKE) update
	dub build dfmt
update:
	sudo apt update
	sudo apt install -yu `cat apt.txt`
gz: $(DC) $(DUB)

$(DC) $(DUB): $(HOME)/distr/SDK/dmd_$(D_VER)_amd64.deb
	sudo dpkg -i $< && sudo touch $(DC) $(DUB)
$(HOME)/distr/SDK/dmd_$(D_VER)_amd64.deb:
	$(CURL) $@ https://downloads.dlang.org/releases/2.x/$(D_VER)/dmd_$(D_VER)-0_amd64.deb

.PHONY: ref
ref: ref/DQuick/README.md ref/dlangui/README.md \
     ref/x11/README.md ref/x11d/README.md \
	 ref/arsd/simpledisplay.d

GITREF = git clone -o gh --depth 1

ref/DQuick/README.md:
	$(GITREF) https://github.com/D-Quick/DQuick.git ref/DQuick &
ref/dlangui/README.md:
	$(GITREF) https://github.com/buggins/dlangui.git ref/dlangui &
ref/x11/README.md:
	$(GITREF) https://github.com/nomad-software/x11.git ref/x11 &
ref/x11d/README.md:
	$(GITREF) https://github.com/ZILtoid1991/x11d.git ref/x11d &
ref/arsd/simpledisplay.d:
	$(GITREF) https://github.com/adamdruppe/arsd.git ref/arsd &

.PHONY: meldX
meldX:
	meld src/X ref/x11/source/x11 ref/x11d/source/x11 &

# merge
MERGE += Makefile README.md apt.txt LICENSE
MERGE += .clang-format .editorconfig .doxygen .gitignore
MERGE += .vscode bin doc lib inc src tmp ref

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

.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v --tags
	$(MAKE) shadow

.PHONY: zip
zip:
	git archive \
		--format zip \
		--output $(TMP)/$(MODULE)_$(NOW)_$(REL).src.zip \
	HEAD
