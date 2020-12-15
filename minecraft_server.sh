#!/usr/bin/env bash

# cat /opt/minecraft/minecraft_server.sh

USAGE="Usage: $0 [server_folder [jar_file]]"

server_folder=${1:-'/opt/minecraft/minecraft_server'}
jar_file=${2:-'minecraft_server.jar'}

ram_size_mb=$(free -m | grep -F 'Mem:' | awk '{print $2}')
heap_size_min=$( printf "%0.0f%s" $(echo "$ram_size_mb * 0.7" | bc -l ) 'M' )
heap_size_max=$( printf "%0.0f%s" $(echo "$ram_size_mb * 0.9" | bc -l ) 'M' )

cd "$server_folder" && java -server -Xms"$heap_size_min" -Xmx"$heap_size_max" -jar "$jar_file" nogui

# -XX:InitialRAMPercentage=60.0 -XX:MaxRAMPercentage=80.0 -XX:MinRAMPercentage=50.0
