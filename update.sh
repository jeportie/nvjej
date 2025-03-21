#!/bin/bash

touch ~/.cache/docker_nv_reset.flag
docker build -t jeportie/nvjej:latest .

# Check for AI API keys file
API_KEYS_FILE=~/ai_api_keys.conf
if [ ! -f "$API_KEYS_FILE" ] || [ ! -s "$API_KEYS_FILE" ]; then
    echo "AI API keys file is missing or empty. Please enter your API keys."
    while true; do
        read -p "Enter API key (or type 'no' to stop): " api_key
        if [ "$api_key" = "no" ]; then
            break
        fi
        echo "$api_key" >> "$API_KEYS_FILE"
    done
    chmod 600 "$API_KEYS_FILE"
fi
