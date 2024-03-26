# Dockerfile for serving project documentation from odoc HTML.
ARG OCAML_VERSION=4.14.0
ARG DEBIAN_VERSION=bookworm
ARG NGINX_VERSION=1.25.4

FROM cr.kruhlmann.dev/debian-${DEBIAN_VERSION}-ocaml-${OCAML_VERSION} as builder

WORKDIR /home/$USERNAME/app
RUN apt-get update \
    && apt-get install -y --no-install-recommends pkgconf libgmp-dev \
    && mkdir /doc \
    && chown -R $USERNAME /doc \
    && chown -R $USERNAME $HOME
USER $USERNAME
COPY --chown=$USERNAME:$USERNAME Makefile dune-project *.opam .gitignore .gitattributes .
COPY --chown=$USERNAME:$USERNAME ./make ./make
COPY --chown=$USERNAME:$USERNAME ./lib ./lib
RUN eval $(opam env) \
    && opam install . --yes --deps-only --with-doc \
    && make docs \
    && cp -r _build/default/_doc/_html/relic-sdk /doc/relic-sdk \
    && cp -r _build/default/_doc/_html/odoc.support /doc/odoc.support

FROM nginx:${NGINX_VERSION}-${DEBIAN_VERSION}

RUN rm -rf /usr/share/nginx/html
COPY --from=builder /doc /usr/share/nginx/html
