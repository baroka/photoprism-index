#!/bin/sh
# Entrypoint for photoprism-index

# Files
watchDir="/home/photo"

update_index() {
	echo "index database.."
	local photoprism=`docker network inspect t2_proxy | jq '.[].Containers[] | select(.Name == "photoprism") | .IPv4Address' | awk -F[\"\/] '{print $2}'`
	local endpoint=http://$photoprism:2342/api/v1/index
	curl -X POST -H 'Content-Type: application/json' $endpoint -d '{"username":"$PHOTOPRISM_ADMIN_USER","password":"$PHOTOPRISM_ADMIN_PASSWORD"}'
}

# Monitorize photo folder
echo "photoprism-index start.."

inotifywait -m -r -e create,delete,move,modify,attrib $watchDir | while read line; do  
  echo "changes detected.. ${line}"
  update_index
done