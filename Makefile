PREFIX ?= /usr/local
BINDIR := $(PREFIX)/bin

.PHONY: install uninstall

install:
	install -d "$(BINDIR)"
	install -m 755 impf "$(BINDIR)/impf"

uninstall:
	rm -f "$(BINDIR)/impf"
