# build:
#  docker build -t baroka/photoprism-index .

FROM alpine:latest

WORKDIR /work

# Copy entrypoint script
COPY entrypoint.sh .
RUN chmod a+x entrypoint.sh

# Install packages
RUN apk update && apk add --no-cache inotify-tools curl

# Timezone
RUN apk update && apk add tzdata
ARG TZ "Europe/Madrid"
ENV TZ=$TZ
RUN cp /usr/share/zoneinfo/Europe/Madrid /etc/localtime

# Create folders
RUN mkdir /home/photo

# Run the command on container startup
ENTRYPOINT ["/work/entrypoint.sh"]