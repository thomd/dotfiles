SRCDIR ?= $(PWD)
DESTDIR ?= $(HOME)
DOT_FILES = $(shell find $(SRCDIR) -maxdepth 1 -type f -name '.*' -not -name '*.sh' -not -name '.DS_Store' | sort | xargs -n1 basename)
BIN_FILES = $(shell find $(SRCDIR)/bin -maxdepth 1 -type f -name '*' | sort | xargs -n1 basename)

.PHONY: install dot bin

install: dot bin

dot:
	@for file in $(DOT_FILES); do [ ! -h $(DESTDIR)/$${file} ] && ln -fs $(SRCDIR)/$${file} $(DESTDIR)/$${file} && echo "\033[32m$${file}\033[0m" || echo "\033[1;30m$${file}\033[0m"; done

bin: $(DESTDIR)/bin
	@for file in $(BIN_FILES); do [ ! -h $(DESTDIR)/bin/$${file} ] && ln -fs $(SRCDIR)/bin/$${file} $(DESTDIR)/bin/$${file} && echo "\033[32mbin/$${file}\033[0m" || echo "\033[1;30mbin/$${file}\033[0m"; done

$(DESTDIR)/bin:
	@mkdir -p $(DESTDIR)/bin
