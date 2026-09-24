#!/bin/bash

set -e

if [ -z "${1:-}" ]; then
    echo
    echo "Usage:"
    echo
    echo "  ./scripts/restore-jira.sh backups/jira-db-YYYYMMDD-HHMMSS.sql.gz"
    echo
    exit 1
fi

BACKUP_FILE="$1"

if [ ! -f "${BACKUP_FILE}" ]; then
    echo "ERROR: Backup not found:"
    echo "${BACKUP_FILE}"
    exit 1
fi

echo
echo "========================================"
echo " Jira Database Restore"
echo "========================================"

echo
echo "Backup:"
echo "${BACKUP_FILE}"

echo
echo "Stopping Jira..."

docker compose stop jira

echo
echo "Restoring database..."

gunzip -c "${BACKUP_FILE}" | \
docker exec -i jira-postgres \
    psql -U jira -d jiradb

echo
echo "Starting Jira..."

docker compose start jira

echo
echo "Restore completed."