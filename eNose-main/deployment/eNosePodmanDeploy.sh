#!/bin/bash

# Create a pod with 2 containers: enose-api and enose-app

if [ $# -lt 2 ]; then
    echo "Usage: $0 mqttServerIP mqttServerPort"
    exit 1
fi

MQTT_SERVER_IP=$1
MQTT_SERVER_PORT=$2

# Remove existing containers if they exist
docker rm -f enose-api enose-app 2>/dev/null

# Pull the latest images
docker pull quay.io/andyyuen/enose-api:1.0
docker pull quay.io/andyyuen/enose-app:1.0

# Run enose-api container
docker run -d --rm --name enose-api -p 7001:7000 quay.io/andyyuen/enose-api:1.0

# Run enose-app container
docker run -d --rm --name enose-app -e MQTT_SERVER_IP=$MQTT_SERVER_IP -e MQTT_SERVER_PORT=$MQTT_SERVER_PORT -p 7005:7005 quay.io/andyyuen/enose-app:1.0

exit 0
