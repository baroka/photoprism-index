#!/bin/sh
# Entrypoint for photoprism-index

# Files
watchDir="/home/photo"

update_index() {
	echo "index database.."
	local endpoint=http://photoprism:2342/api/v1/index
	curl -X POST -H 'Content-Type: application/json' $endpoint -d '{"username":"$PHOTOPRISM_ADMIN_USER","password":"$PHOTOPRISM_ADMIN_PASSWORD"}'
}

# Monitorize photo folder
echo "photoprism-index start.."

inotifywait -m -e create,delete,move,modify,attrib $watchDir | while read line; do  
  echo "changes detected.. ${line}"
  update_index
done