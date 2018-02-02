#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the Cachet DB
"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE cachet;
EOSQL
