#!/bin/bash

url="https://api.sportmonks.com/v3/$ENDPOINT?per_page=50&include=fixture;type"

while true; do

  # Make the request using curl and retrieve the response
  response=$(curl -s $url -H "Authorization: $SPORTMONKS_API_TOKEN")

  # Check if the "message" key exists in the response
  has_message=$(echo $response | jq -r 'has("message")')
  if [ $has_message == true ]; then
    error_message=$(echo $response | jq -r '.message')
    echo Error: $error_message
    exit 1
  fi
  
  # Get the current page number from the response
  page=$(echo $response | jq -r '.pagination.current_page')
  echo Page $page

  # Extract data from the response using jq and persist it
  echo $response | jq -cr '.data[]' >> data.json

  # Check if there is a next page
  url=$(echo $response | jq -r '.pagination.next_page')
  if [ "$url" == null ]; then
    break
  fi

done
