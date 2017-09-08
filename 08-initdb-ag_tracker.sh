#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the Agroguia Track DB
"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE ag_tracker;
EOSQL
