UNIQUE_NAME=$(date +%Y%m%d%H%M%S)
BACKUP_PATH="/backup/backup_$UNIQUE_NAME.sqlite3"

sqlite3 /data/db.sqlite3 ".backup '$BACKUP_PATH'"

if [ $? -eq 0 ]; then
  # If the HEALTHCHECK_URL is set, send a request to it
  if [ -n "$HEALTHCHECK_URL" ]; then
    wget --quiet --tries=1 --timeout=5 "$HEALTHCHECK_URL"
  fi

  # If rclone is setup, sync the backup
  if [ -n "$RCLONE_REMOTE" ]; then
    rclone copy "$BACKUP_PATH" "$RCLONE_REMOTE" --quiet --transfers=1 --checkers=1
  fi

  # If clean is set, remove older backups
  if [ -n "$CLEAN" ]; then
    find /backup -type f -name "backup_*.sqlite3" -mtime +7 -exec rm {} \;
  fi
fi
