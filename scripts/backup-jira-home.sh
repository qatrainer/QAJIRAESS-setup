#!/bin/bash

set -e

BACKUP_DIR="$(cd "$(dirname "$0")/../backups" && pwd)"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

BACKUP_FILE="${BACKUP_DIR}/jira-home-${TIMESTAMP}.tar.gz"

mkdir -p "${BACKUP_DIR}"

echo
echo "Backing up Jira home..."

docker run --rm \
    -v jira_112_data:/source:ro \
    -v "${BACKUP_DIR}:/backup" \
    debian:bookworm-slim \
    tar czf "/backup/jira-home-${TIMESTAMP}.tar.gz" \
    -C /source .

echo
echo "Backup completed:"
ls -lh "${BACKUP_FILE}"