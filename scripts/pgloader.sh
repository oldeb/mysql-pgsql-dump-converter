#!/usr/bin/env bash

# Stop script execution on error.
set -e

# Migrate the content of the MySQL database into the PgSQL database.
pgloader $PGLOADER_OPTIONS \
"mysql://$MYSQL_USER:$MYSQL_PASSWORD@mysql:3306/$MYSQL_DATABASE" \
"postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@localhost:5432/$POSTGRES_DB"

# Dump the PgSQL database into a file.
filename="/tmp/output/mysql_to_pgsql--`date +"%d%m%Y%H%M"`.sql"
pg_dump $POSTGRES_DB $PG_DUMP_OPTIONS --file=$filename
chmod 777 ${filename}
sed -i '/CREATE SCHEMA database;/d' $filename
sed -i 's/database./public./g' $filename
echo "Task sucessfully completed."
