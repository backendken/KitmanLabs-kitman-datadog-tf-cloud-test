#!/usr/bin/env bash

# This simple script interacts with the datadog API
# If you pass a timeboard ID it will return its JSON representation
# You need jq to parse the JSON

api_key=$DATADOG_API_KEY
app_key=$DATADOG_APP_KEY

if [ "$#" -eq 1 ]; then

timeboard_id=$1

curl -s -G "https://api.datadoghq.com/api/v1/dash/${timeboard_id}" \
-d "api_key=${api_key}" \
-d "application_key=${app_key}" \
| jq .
else
    echo "Please provide a dashboard/timeboard id"
fi


