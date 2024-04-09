.PHONY: lint
lint:
	dune build @fmt
	find lib tests -name '*.c' -exec clang-format -style=file -n {} \;

.PHONY: fix
fix:
	dune build @fmt --auto-promote
	find lib tests -name '*.c' -exec clang-format -style=file -i {} \;
