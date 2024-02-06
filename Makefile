# var
MODULE  = $(notdir $(CURDIR))
module  = $(shell echo $(MODULE) | tr A-Z a-z)
OS      = $(shell uname -o|tr / _)
NOW     = $(shell date +%d%m%y)
REL     = $(shell git rev-parse --short=4 HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
CORES  ?= $(shell grep processor /proc/cpuinfo | wc -l)

# version
D_VER = 2.106.1

# dir
CWD  = $(CURDIR)
BIN  = $(CWD)/bin
SRC  = $(CWD)/src
TMP  = $(CWD)/tmp
REF  = $(CWD)/ref
GZ   = $(HOME)/gz

# tool
CURL = curl -L -o
CF   = clang-format
DC   = /usr/bin/dmd
DUB  = /usr/bin/dub
RUN  = $(DUB) run   --compiler=$(DC)
BLD  = $(DUB) build --compiler=$(DC)

# src
C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)
D += $(wildcard src/*.d*)
# D += $(wildcard src/X/*.d*)
# D += $(wildcard src/X/extensions/*.d*)

# all
.PHONY: all
all: $(D)
	$(RUN)

# format
format: tmp/format_d
tmp/format_d: $(D)
	$(RUN) dfmt -- -i $? && touch $@

# rule
bin/$(MODULE): $(D) Makefile
	$(BLD)

$(REF)/%/configure: $(GZ)/%.tar.gz
	cd ref ; zcat $< | tar x && chmod +x $@ ; touch $@
$(REF)/%/README.md: $(GZ)/%.tar.gz
	cd ref ; zcat $< | tar x &&               touch $@

# doc
.PHONY: doc
doc: doc/X\ Window\ System\ Protocol.pdf \
     doc/Александреску\ Язык\ D.pdf doc/Programming_in_D.pdf

doc/%: $(HOME)/D/%
	ln -fs "$<" "$@"
doc/%: $(HOME)/doc/X11/%
	ln -fs "$<" "$@"

$(HOME)/doc/X11/X\ Window\ System\ Protocol.pdf:
	$(CURL) "$@" https://www.x.org/releases/X11R7.5/doc/x11proto/proto.pdf

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
