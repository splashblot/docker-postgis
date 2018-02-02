#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the OpenDuty DB
"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE openduty;
EOSQL
