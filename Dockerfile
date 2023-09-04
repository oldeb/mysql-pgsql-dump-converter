ARG POSTGRES_VERSION=14

FROM postgres:${POSTGRES_VERSION}-alpine

RUN apk update && apk add --no-cache wget sudo pgloader

COPY scripts/pgloader.sh /var/lib/postgresql/pgloader.sh
