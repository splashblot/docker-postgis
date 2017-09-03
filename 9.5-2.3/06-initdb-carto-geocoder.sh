#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Load geocoder into both template_database and $POSTGRES_DB
for DB in template_postgis "$POSTGRES_DB"; do
	echo "Loading geocoder into  $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
CREATE EXTENSION IF NOT EXISTS plpythonu;
CREATE EXTENSION IF NOT EXISTS cartodb;
CREATE EXTENSION IF NOT EXISTS cdb_geocoder;
CREATE EXTENSION IF NOT EXISTS plproxy;
CREATE EXTENSION IF NOT EXISTS observatory;
CREATE EXTENSION IF NOT EXISTS cdb_dataservices_server;
CREATE EXTENSION IF NOT EXISTS cdb_dataservices_client;

SELECT CDB_Conf_SetConf(
    'redis_metadata_config',
    '{"redis_host": "localhost", "redis_port": 6379, "sentinel_master_id": "", "timeout": 0.1, "redis_db": 5}'
);
SELECT CDB_Conf_SetConf(
    'redis_metrics_config',
    '{"redis_host": "localhost", "redis_port": 6379, "sentinel_master_id": "", "timeout": 0.1, "redis_db": 5}'
);

SELECT CDB_Conf_SetConf(
    'user_config',
    '{"is_organization": false, "entity_name": "geocoder"}'
);

SELECT CDB_Conf_SetConf(
    'server_conf',
    '{"environment": "development"}'
);

SELECT cartodb.cdb_conf_setconf('logger_conf', '{"geocoder_log_path": "/tmp/geocodings.log"}');

-- dummy conf from https://github.com/CartoDB/dataservices-api/blob/master/server/extension/test/sql/00_install_test.sql
SELECT cartodb.cdb_conf_setconf('heremaps_conf', '{"geocoder": {"app_id": "dummy_id", "app_code": "dummy_code", "geocoder_cost_per_hit": 1}, "isolines": {"app_id": "dummy_id", "app_code": "dummy_code"}}');
SELECT cartodb.cdb_conf_setconf('mapzen_conf', '{"routing": {"api_key": "routing_dummy_api_key", "monthly_quota": 1500000}, "geocoder": {"api_key": "geocoder_dummy_api_key", "monthly_quota": 1500000}, "matrix": {"api_key": "matrix_dummy_api_key", "monthly_quota": 1500000}}');
SELECT cartodb.cdb_conf_setconf('data_observatory_conf', '{"connection": {"whitelist": ["ethervoid"], "production": "host=localhost port=5432 dbname=dataservices_db user=geocoder_api", "staging": "host=localhost port=5432 dbname=dataservices_db user=geocoder_api"}, "monthly_quota": 100000}');
EOSQL
done
