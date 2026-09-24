#!/bin/bash

set -e

echo
echo "========================================"
echo " Jira 11.2 TRAINING RESET"
echo "========================================"

echo
echo "This will:"
echo
echo "  - Stop Jira"
echo "  - Stop PostgreSQL"
echo "  - DELETE the PostgreSQL database"
echo "  - DELETE Jira application data"
echo "  - RETAIN the Docker volumes"
echo "  - Restart the containers"
echo
echo "This operation cannot be undone."
echo

read -r -p "Type RESET to continue: " CONFIRM

if [ "${CONFIRM}" != "RESET" ]; then
    echo
    echo "Reset cancelled."
    exit 0
fi

echo
echo "[1/6] Stopping Jira..."

docker compose stop jira

echo
echo "[2/6] Removing Jira container..."

docker compose rm -f jira

echo
echo "[3/6] Removing PostgreSQL container..."

docker compose rm -f postgres

echo
echo "[4/6] Removing database volume..."

docker volume rm jira_112_postgres_data 2>/dev/null || true

echo
echo "[5/6] Removing Jira application-data volume..."

docker volume rm jira_112_data 2>/dev/null || true

echo
echo "[6/6] Recreating clean environment..."

docker compose up -d

echo
echo "========================================"
echo " RESET COMPLETE"
echo "========================================"

echo
echo "Containers:"
docker compose ps

echo
echo "Volumes:"
docker volume ls | grep jira_112 || true

echo
echo "Jira will now initialise as a clean installation."