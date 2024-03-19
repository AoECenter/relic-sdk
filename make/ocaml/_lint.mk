.PHONY: lint
lint:
	dune build @fmt

.PHONY: fix
fix:
	dune build @fmt --auto-promote
