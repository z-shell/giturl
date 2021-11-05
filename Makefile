NAME=giturl

INSTALL?=install -c
PREFIX?=/usr/local
BIN_DIR?=$(DESTDIR)$(PREFIX)/bin
SHARE_DIR?=$(DESTDIR)$(PREFIX)/share/$(NAME)
DOC_DIR?=$(DESTDIR)$(PREFIX)/share/doc/$(NAME)

all: zgiturl

zgiturl: giturl.main lib/script_preamble lib/script_vars lib/math_functions lib/codes_huffman lib/coding_functions
	cat lib/script_preamble > zgiturl
	cat lib/script_vars lib/math_functions lib/codes_huffman lib/coding_functions giturl.main >> zgiturl
	chmod a+x zgiturl

install: zgiturl
	$(INSTALL) -d $(SHARE_DIR)
	$(INSTALL) -d $(DOC_DIR)
	cp zgiturl $(BIN_DIR)
	cp README.md NEWS LICENSE $(DOC_DIR)

uninstall:
	rm -f $(BIN_DIR)/zgiturl
	rm -f $(DOC_DIR)/README.md $(DOC_DIR)/NEWS $(DOC_DIR)/LICENSE
	[ -d $(DOC_DIR) ] && rmdir $(DOC_DIR) || true
	rm -f $(SHARE_DIR)/*
	[ -d $(SHARE_DIR) ] && rmdir $(SHARE_DIR) || true

clean:
	rm -f zgiturl

.PHONY: all install uninstall
