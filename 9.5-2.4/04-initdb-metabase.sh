#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the Metabase DB
"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE metabase;
EOSQL
