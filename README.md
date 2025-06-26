# vaultwarden-backup

Backs up your Vaultwarden database every hour.

## Setup

You must mount the `/data` directory of your Vaultwarden container to the `/data` directory of this container.

For example using Docker Compose:

```yaml
services:
  vaultwarden:
    image: vaultwarden/server:latest
    volumes:
      - ./data:/data
  vaultwarden-backup:
    image: ghcr.io/le0developer/vaultwarden-backup:latest
    volumes:
      - ./data:/data
```

## Backup Location

The backups will be stored in the `/backup` directory of this container.
You can mount this directory to your host machine to access the backups or use [`rclone`](#rclone) to sync them to a remote storage.

## Environment Variables

You can set the following environment variables to customize the backup process:

### `HEALTHCHECK_URL`

A URL you can specify which will be called after every successful backup.
Think of this as a keep alive ping. Status monitors can be used to notify you if no ping arrives.

### `RCLONE_REMOTE`

See [rclone](#rclone) for more information.

### `CLEAN`

If set to `true`, after a successful backup, older backups will be deleted.

## rclone

Rclone lets you sync your backups to remote storages.

Set `RCLONE_REMOTE` to the name of your remote storage. See [rclone documentation](https://rclone.org/docs/#environment-variables) for more information and how to set up your environment variables.
