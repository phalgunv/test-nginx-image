#!/usr/bin/env bash
docker build --no-cache -t my-image:latest .
# To get the image ID:
IMAGE_ID=$(docker images --filter "reference=my-image:latest" --format "{{.ID}}")

# Now you can use the IMAGE_ID variable:
echo "Image ID: $IMAGE_ID"

CONTAINER_ID=$(docker run -it --rm -d $IMAGE_ID)
#CONTAINER_ID=$(docker run -it --rm --sysctl net.ipv4.ip_unprivileged_port_start=1024 -d $IMAGE_ID)

echo "Container ID: $CONTAINER_ID"
# The non-root user 1001
docker exec -it $CONTAINER_ID id

# Check unprivileged port
docker exec -it $CONTAINER_ID sysctl net.ipv4.ip_unprivileged_port_start
docker exec -it $CONTAINER_ID cat /etc/nginx/nginx.conf | grep listen

# Ensure that the Nginx server is running
docker exec -it $CONTAINER_ID curl localhost
docker exec -it $CONTAINER_ID ps -ef
docker exec -it $CONTAINER_ID netstat -tulnp