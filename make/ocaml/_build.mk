.PHONY: watch
build: $(BUILD_DEPS)
	dune build

.PHONY: watch
watch: $(BUILD_DEPS)
	dune build -w
