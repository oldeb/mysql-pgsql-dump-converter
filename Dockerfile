FROM postgres:14-alpine
RUN apk update && apk add --no-cache wget sudo pgloader
COPY scripts/pgloader.sh /var/lib/postgresql/pgloader.sh
