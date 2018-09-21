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
EOSQL

# Load crankshaft into both template_database and $POSTGRES_DB
for DB in template_postgis "$POSTGRES_DB"; do
	echo "Loading crankshaft extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
                CREATE EXTENSION IF NOT EXISTS plpythonu;
                CREATE EXTENSION IF NOT EXISTS crankshaft WITH VERSION 'dev';
EOSQL
done
