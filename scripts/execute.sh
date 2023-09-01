#!/usr/bin/env bash

# Allow the container to write into the folder
chmod a+w output

# Execute the migration script inside the container.
docker-compose exec -u postgres postgres sh -c /var/lib/postgresql/pgloader.sh
