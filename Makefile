ifneq (,$(wildcard ./.env))
    include .env
    export
endif

include make/ocaml/main.mk
