#!/bin/bash
#
# Init script to success tests.
#

PGUSER=postgres psql -c "CREATE EXTENSION plpythonu;"
PGUSER=postgres psql -c "CREATE EXTENSION cartodb;"
