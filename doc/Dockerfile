FROM nginx:1.25.4-bookworm

RUN rm -rf /usr/share/nginx/html
COPY _build/default/_doc/_html/relic-sdk /usr/share/nginx/html
COPY _build/default/_doc/_html/odoc.support /usr/share/nginx/html/odoc.support
