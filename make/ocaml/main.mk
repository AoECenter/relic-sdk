.ONESHELL:
SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

.PHONY: all
all: build

include $(SELF_DIR)/_build.mk
include $(SELF_DIR)/_doc.mk
include $(SELF_DIR)/_install.mk
include $(SELF_DIR)/_lint.mk
include $(SELF_DIR)/_test.mk

