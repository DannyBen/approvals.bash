#!/usr/bin/env bash

if [[ $1 = "--help" ]]; then
  echo "Usage:"
  echo "  sample-cli-app say MESSAGE"
  echo "  sample-cli-app --help"
elif [[ $1 = "say" ]]; then
  echo "${2:-hi}"
elif [[ $1 = "random" ]]; then
  echo "This line contains changing output [$RANDOM]"
else
  echo "Run sample-cli-app --help for help"
fi