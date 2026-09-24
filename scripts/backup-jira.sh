#!/bin/bash

set -e

BACKUP_DIR="$(cd "$(dirname "$0")/../backups" && pwd)"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

BACKUP_FILE="${BACKUP_DIR}/jira-db-${TIMESTAMP}.sql.gz"

mkdir -p "${BACKUP_DIR}"

echo
echo "========================================"
echo " Jira PostgreSQL Backup"
echo "========================================"

echo
echo "Database : jiradb"
echo "Output   : ${BACKUP_FILE}"

docker exec jira-postgres \
    pg_dump \
    -U jira \
    -d jiradb \
    --clean \
    --if-exists \
    | gzip > "${BACKUP_FILE}"

echo
echo "Backup completed."

ls -lh "${BACKUP_FILE}"