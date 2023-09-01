#!/usr/bin/env bash

# Stop script execution on error.
set -e

# Migrate the content of the MySQL database into the PgSQL database.
pgloader --on-error-stop \
mysql://user:password@mysql:3306/database \
postgresql://postgres:root@localhost:5432/postgres

# Dump the PgSQL database into a file.
filename=mysql_to_pgsql--`date +"%d%m%Y%H%M"`.sql
pg_dump postgres > /tmp/output/${filename}
chmod 777 /tmp/output/${filename}
echo "Task sucessfully completed."
