#!/bin/bash

set -e

URL="http://localhost:8080"

echo "Waiting for Jira..."

for i in {1..60}; do

    if curl -fsS "${URL}/status" >/dev/null 2>&1; then
        echo
        echo "Jira is available."
        exit 0
    fi

    echo "Waiting... ${i}/60"
    sleep 5

done

echo
echo "ERROR: Jira did not become available."
exit 1