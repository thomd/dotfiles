DOT_FILES = $(shell find . -maxdepth 1 -type f -name '.*' -not -name '*.sh' -not -name '.DS_Store' | sort | xargs -n1 basename)
BIN_FILES = $(shell find bin -maxdepth 1 -type f -name '*' | sort | xargs -n1 basename)

.PHONY: install dot bin

install: dot bin

dot:
	@for file in $(DOT_FILES); do [ ! -h $(HOME)/$${file} ] && ln -s $(PWD)/$${file} $(HOME)/$${file} && echo "\033[32m$${file}\033[0m" || echo "\033[1;30m$${file}\033[0m"; done

bin: $(HOME)/bin
	@for file in $(BIN_FILES); do [ ! -h $(HOME)/bin/$${file} ] && ln -s $(PWD)/bin/$${file} $(HOME)/bin/$${file} && echo "\033[32mbin/$${file}\033[0m" || echo "\033[1;30mbin/$${file}\033[0m"; done

$(HOME)/bin:
	@mkdir -p $(HOME)/bin
