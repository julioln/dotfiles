#!/bin/bash

set -e

d=$(date +%Y-%m)

echo "Date: ${d}"

echo "Backing up package list"
mkdir -p /home/julio/Backups/neander/$d/pacman
pacman -Q | gzip -9 > /home/julio/Backups/neander/$d/pacman/pkg_list.gz

echo "Backing up file checksums"
mkdir -p /home/julio/Backups/neander/$d/file_list
find /etc -type f -exec md5sum '{}' \+ 2>/dev/null | gzip -9 > /home/julio/Backups/neander/$d/file_list/checksums_etc.gz &
find /var -type f -exec md5sum '{}' \+ 2>/dev/null | gzip -9 > /home/julio/Backups/neander/$d/file_list/checksums_var.gz &
find /home/julio -type f -exec md5sum '{}' \+ 2>/dev/null | gzip -9 > /home/julio/Backups/neander/$d/file_list/checksums_home_julio.gz &

wait

echo "Uploading files to S3"
aws s3 sync /etc "s3://julio-spock-backup/neander/$d/etc" --delete --acl bucket-owner-full-control --profile s3_backup_user --storage-class GLACIER --no-follow-symlinks &
aws s3 sync /var "s3://julio-spock-backup/neander/$d/var" --delete --acl bucket-owner-full-control --profile s3_backup_user --storage-class GLACIER --no-follow-symlinks --exclude "cache/*" --exclude "tmp/*" --exclude "log/*" --exclude "run/*" &
aws s3 sync /home/julio "s3://julio-spock-backup/neander/$d/home/julio" --delete --acl bucket-owner-full-control --profile s3_backup_user --storage-class GLACIER --no-follow-symlinks --exclude ".cache/*" --exclude ".local/share/containers/*" --exclude "**/.cache/*" &

wait

echo "All done"
