#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create role publicuser if it does not exist
"${psql[@]}" <<- 'EOSQL'
DO
$$
BEGIN
   IF NOT EXISTS (
      SELECT *
      FROM   pg_catalog.pg_user
      WHERE  usename = 'publicuser') THEN

      CREATE ROLE publicuser LOGIN;
   END IF;
END
$$ LANGUAGE plpgsql;

CREATE EXTENSION crankshaft WITH VERSION 'dev';"
EOSQL
