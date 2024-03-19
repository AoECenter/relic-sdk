.PHONY: install
install:
	opam install . --deps-only

.PHONY: install-all
install-all:
	opam install . --deps-only --with-test --with-doc
