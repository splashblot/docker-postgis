#!/bin/bash
#
# Init script to success tests.
#

PGUSER=postgres psql -c "CREATE EXTENSION IF NOT EXISTS plpythonu;"
PGUSER=postgres psql -c "CREATE EXTENSION IF NOT EXISTS cartodb;"
