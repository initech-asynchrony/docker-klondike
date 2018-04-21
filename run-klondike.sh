#!/bin/sh
set -e

if [ -n "$S3_BUCKET" ]; then
  echo "Setting up S3-Sync"
  touch /var/log/s3-sync.log

  echo "Doing initial sync with S3: s3://${S3_BUCKET}"
  /usr/bin/aws s3 sync s3://$S3_BUCKET /klondike/data

  echo "Creating sync cron job..."
  echo "*/1 * * * * /usr/bin/s3-sync.sh ${S3_BUCKET} >> /var/log/s3-sync.log 2>&1" | /usr/bin/crontab -
  echo "Ensure Cron is running in background"
  /usr/sbin/crond
fi

echo "Starting Klondike Server"
mono /klondike/bin/Klondike.SelfHost.exe --interactive --port=8080