#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the Metabase DB
"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE webodm_dev;
ALTER DATABASE webodm_dev SET postgis.gdal_enabled_drivers TO 'GTiff';
ALTER DATABASE webodm_dev SET postgis.enable_outdb_rasters TO True;
EOSQL
