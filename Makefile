DOT_FILES = $(shell find . -type f -maxdepth 1 -name '.*' -not -name '*.sh' -not -name '.DS_Store' | sort | xargs basename -a)
BIN_FILES = $(shell find bin -type f -maxdepth 1 -name '*' | sort | xargs basename -a)

.PHONY: install dot bin
install: dot bin

dot:
	@for file in $(DOT_FILES); do [ ! -h $(HOME)/$${file} ] && ln -s $(PWD)/$${file} $(HOME)/$${file} && echo "\033[32m$${file}\033[0m" || echo "\033[1;30m$${file}\033[0m"; done

bin:
	@for file in $(BIN_FILES); do [ ! -h $(HOME)/bin/$${file} ] && ln -s $(PWD)/bin/$${file} $(HOME)/bin/$${file} && echo "\033[32mbin/$${file}\033[0m" || echo "\033[1;30mbin/$${file}\033[0m"; done

