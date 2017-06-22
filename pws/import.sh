#!/bin/bash
set -e
root_path=$(dirname $BASH_SOURCE)
source $root_path/config

set -x


make_dash_config() {
  erb title="$TITLE" \
      grootfs_query="$GROOTFS_QUERY" \
      shed_query="$SHED_QUERY" \
      prefix="$PREFIX" \
      $root_path/dash.json.erb
}

parse_datadog_error() {
  json="$1"

  errors_count=$(echo $json | jq '.errors | length')
  if [ $errors_count -gt 0 ]; then
    echo "================================================"
    for i in $(seq 0 $(($(echo $json | jq '.errors | length')-1))); do
      msg=$(echo $json | jq ".errors[$i]" | sed -e 's/^\"//' | sed -e 's/\"$//')
      echo -e $msg
      echo "================================================"
    done
    exit 1
  else
    url=$(echo $json | jq '.url' | sed -e 's/"//g')
    echo "https://app.datadoghq.com$url"
  fi
}

create_dash() {
  data_file_path=$1

  json=$(if [ $DASH_ID -eq 0 ]; then
    url="https://app.datadoghq.com/api/v1/dash?api_key=${API_KEY}"
    url=$url"&application_key=${APP_KEY}"
    curl -sX POST -H "Content-type: application/json" -d @$data_file_path $url
  else
    url="https://app.datadoghq.com/api/v1/dash/${DASH_ID}?api_key=${API_KEY}"
    url=$url"&application_key=${APP_KEY}"
    curl -sX PUT -H "Content-type: application/json" -d @$data_file_path $url
  fi)
  parse_datadog_error "$json"
}

main() {
  make_dash_config > $root_path/dash.json
  create_dash $root_path/dash.json
  rm -f $root_path/dash.json
}

main
