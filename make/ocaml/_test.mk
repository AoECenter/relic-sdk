.PHONY: test
test:
	find . -name '*.coverage' | xargs rm -f
	dune runtest  --root $$(pwd) --instrument-with bisect_ppx --force
	bisect-ppx-report html
	bisect-ppx-report summary
