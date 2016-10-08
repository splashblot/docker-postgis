#!/bin/bash
#
# Init script to success tests.
#

PGUSER=postgres psql -c "CREATE EXTENSION crankshaft WITH VERSION 'dev';"
