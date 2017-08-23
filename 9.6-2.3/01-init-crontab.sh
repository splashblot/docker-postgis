#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Setup pg_dumpapp via crontab
if [ "$POSTGRES_BACKUPS_CRONTAB" ]; then
		# echo "0 0 * * * pg_dumpall -c | gzip > /data/backups/pg_dumpall-`date +%Y-%m-%d-%H-%M-%S`.sql.gz >> /dev/stdout 2>&1" > crontab.conf
        echo "${POSTGRES_BACKUPS_CRONTAB}" > crontab.conf
        crontab /tmp/crontab.conf
        cron
        echo "Running backups as a cron job (${POSTGRES_BACKUPS_CRONTAB})"
fi
