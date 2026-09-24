#!/bin/bash

set -e

echo "========================================"
echo " Jira Software 11.2.0"
echo "========================================"

echo
echo "Java:"
java -version

echo
echo "JIRA_HOME:    ${JIRA_HOME}"
echo "JIRA_INSTALL: ${JIRA_INSTALL}"

echo
echo "Waiting for PostgreSQL..."

until nc -z "${JIRA_DB_HOST}" "${JIRA_DB_PORT:-5432}"; do
    echo "PostgreSQL not ready..."
    sleep 3
done

echo "PostgreSQL is available."

chown -R jira:jira "${JIRA_HOME}"

echo
echo "Starting Jira..."

exec gosu jira \
    "${JIRA_INSTALL}/bin/start-jira.sh" \
    -fg