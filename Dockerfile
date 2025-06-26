FROM alpine:3

RUN apk add sqlite rclone
COPY ./backup.sh /backup.sh
COPY ./cron /etc/crontabs/root

CMD ["crond", "-f", "-l", "8"]
