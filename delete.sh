#!/bin/sh
# This script deletes a SAM application stack using a specified environment.

# Usage:
# ./delete.sh <env>
# Example:
# ./delete.sh prod
# ./delete.sh dev
# ./delete.sh localstack

set -e

export Env="$1"

if [ -z "$Env" ]; then
  echo "Error: No environment provided. Usage: ./delete.sh <env>"
  exit 1
fi

config_file="samconfig-${Env}.toml"
stack_name="${Env}-hello-js"

if [ ! -f "$config_file" ]; then
  echo "Error: Config file '$config_file' not found."
  exit 1
fi

echo "Deleting stack $stack_name using config $config_file..."

# Choose profile if localstack
if [ "$Env" = "localstack" ]; then
  sam delete \
    --stack-name "$stack_name" \
    --config-file "$config_file" \
    --profile localstack \
    --no-prompts
else
  sam delete \
    --stack-name "$stack_name" \
    --config-file "$config_file" \
    --no-prompts
fi
