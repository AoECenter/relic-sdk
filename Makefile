ifneq (,$(wildcard ./.env))
    include .env
    export
endif

x:
	set

include make/ocaml/main.mk
