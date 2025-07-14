#!/usr/bin/env bash

# This simple script interacts with the datadog API
# You need jq to parse the JSON

# If you pass no arguments it returns all monitors.
# If you pass the monitor ID it gives you additional info about that monitor

api_key=$DATADOG_API_KEY
app_key=$DATADOG_APP_KEY

if [ "$#" -eq 1 ]; then

monitor_id=$1

curl -s -G "https://app.datadoghq.com/api/v1/monitor/${monitor_id}" \
     -d "api_key=${api_key}" \
     -d "application_key=${app_key}" \
     -d "group_states=all" | jq
else
  curl -s -G "https://app.datadoghq.com/api/v1/monitor" \
       -d "api_key=${api_key}" \
       -d "application_key=${app_key}" | jq '.[] | {id: .id,name: .name,query: .query,message: .message,notify_no_data: .options.notify_no_data, full_window: .options.require_full_window}'
fi
