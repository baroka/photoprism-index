```shell
Docker image for monitoring photo folder and reindex photoprism

PREREQUISITES
 - Docker installed
 - photoprism/photoprism:
   - container name: photoprism
   - container port: 2342

INSTALLATION
 - Docker compose example: 

# Photoprism-index
  photoprism-index:
    container_name: photoprism-index
    image: baroka/photoprism-index:latest
    restart: unless-stopped
    networks:
      - t2_proxy
    security_opt:
      - no-new-privileges:true
    volumes:
      - $DATADIR/_Mis documentos/Fotos:/home/photo:ro
    environment:
      - TZ=$TZ
      - PGID=$PGID
      - PUID=$PUID
      - PHOTOPRISM_ADMIN_USER=$PHOTOPRISM_ADMIN_USER
      - PHOTOPRISM_ADMIN_PASSWORD=$PHOTOPRISM_ADMIN_PASSWORD

 - $DATADIR points to your local data path
 - $PHOTOPRISM_ADMIN_USER and $PHOTOPRISM_ADMIN_PASSWORD are your Photoprism admin user and password
```
