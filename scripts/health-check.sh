#!/bin/bash

set -u

echo
echo "========================================"
echo " Jira 11.2 Health Check"
echo "========================================"

echo
echo "[1] Docker containers"
docker compose ps

echo
echo "[2] PostgreSQL"

if docker exec jira-postgres \
    pg_isready -U jira -d jiradb >/dev/null 2>&1
then
    echo "OK - PostgreSQL is healthy"
else
    echo "ERROR - PostgreSQL is unavailable"
    exit 1
fi

echo
echo "[3] Jira HTTP"

if curl -fsS http://localhost:8080/status >/dev/null 2>&1
then
    echo "OK - Jira HTTP endpoint responding"
else
    echo "WARNING - Jira HTTP endpoint not responding"
fi

echo
echo "[4] Jira version"

docker exec jira-11.2 \
    "${JIRA_INSTALL}/bin/version.sh" 2>/dev/null || true

echo
echo "[5] PostgreSQL version"

docker exec jira-postgres \
    psql -U jira -d jiradb \
    -c "SELECT version();" \
    | head -5

echo
echo "Health check complete."