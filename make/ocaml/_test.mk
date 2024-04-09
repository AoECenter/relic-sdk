.PHONY: unit-test
unit-test:
	dune runtest tests/unit --root $$(pwd) --instrument-with bisect_ppx --force

.PHONY: integration-test
integration-test:
	dune runtest tests/integration --root $$(pwd) --instrument-with bisect_ppx --force

test:
	find . -name '*.coverage' | xargs rm -f
	make integration-test || exit 1
	make unit-test || exit 1
	bisect-ppx-report merge combined.coverage _build/default/tests/**/*.coverage 
	bisect-ppx-report html combined.coverage
	bisect-ppx-report summary combined.coverage
