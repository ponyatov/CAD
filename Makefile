# var
MODULE  = $(notdir $(CURDIR))
module  = $(shell echo $(MODULE) | tr A-Z a-z)
OS      = $(shell uname -o|tr / _)
NOW     = $(shell date +%d%m%y)
REL     = $(shell git rev-parse --short=4 HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
CORES  ?= $(shell grep processor /proc/cpuinfo | wc -l)

# dirs
CWD = $(CURDIR)
BIN = $(CWD)/bin
DOC = $(CWD)/doc
SRC = $(CWD)/src
TMP = $(CWD)/tmp

# tool
CURL   = curl -L -o
CF     = clang-format

# src
C  += src/$(MODULE).cpp
H  += inc/$(MODULE).hpp
S  += src/$(MODULE).lex src/$(MODULE).yacc
S  += $(C) $(H) CMakeLists.txt
# CP += tmp/$(MODULE).parser.cpp tmp/$(MODULE).lexer.cpp
# HP += tmp/$(MODULE).parser.hpp
F  += lib/$(MODULE).ini
S  += $(F)

# all
.PHONY: all
all: bin/$(MODULE) $(F)
	$^

# format
.PHONY: format
format: tmp/format_cpp
tmp/format_cpp: $(C) $(H)
	$(CF) -style=file -i $? && touch $@

# rule
bin/$(MODULE): $(S) $(CP) $(CH) Makefile
	cmake -S $(CWD) -B $(TMP)/$(MODULE) -DAPP=$(MODULE)
	$(MAKE) -C $(TMP)/$(MODULE)
tmp/$(MODULE).parser.cpp: src/$(MODULE).yacc
	bison -o $@ $<
tmp/$(MODULE).lexer.cpp: src/$(MODULE).lex
	flex -o $@ $<

# install
.PHONY: install update updev
install: $(OS)_install doc gz
	$(MAKE) update
update:  $(OS)_update
updev:   update $(OS)_updev

.PHONY: GNU_Linux_install GNU_Linux_update GNU_Linux_updev
GNU_Linux_install:
GNU_Linux_update:
ifneq (,$(shell which apt))
	sudo apt update
	sudo apt install -u `cat apt.txt`
endif
# Debian 10
ifeq ($(shell lsb_release -cs),buster)
#	sudo apt install -t buster-backports kicad
endif
GNU_Linux_updev:
	sudo apt install -yu `cat apt.dev`

.PHONY: vscode
vscode: ~/.vscode/extensions/forth
~/.vscode/extensions/forth:
	ln -fs ~/CAD/.vscode $@

# merge
MERGE += README.md Makefile .gitignore apt.txt apt.dev LICENSE $(S)
MERGE += .vscode bin doc inc src tmp

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
	git push -v && git push -v --tags
	$(MAKE) shadow

.PHONY: zip
zip:
	git archive \
		--format zip \
		--output $(TMP)/$(MODULE)_$(NOW)_$(REL).src.zip \
	HEAD
