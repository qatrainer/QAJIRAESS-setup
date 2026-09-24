# Normal operation
docker compose up -d && docker compose logs -f jira

# Backup current training environment
./scripts/backup-jira.sh
./scripts/backup-jira-home.sh

# Restore known training baseline
./scripts/restore-baseline.sh

mark all shell scripts executable before use