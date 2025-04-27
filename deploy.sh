#!/bin/sh

# This script builds and deploys a SAM application using a specified environment.
# Usage:
# ./deploy.sh <env>
# Example:
# ./deploy.sh test
# ./deploy.sh prod
# ./deploy.sh dev
# ./deploy.sh localstack

# Validate environment input
if [ -z "$1" ]; then
  echo "Error: No environment provided. Usage: ./deploy.sh <env>"
  exit 1
fi

Env="$1"
config_file="samconfig-${Env}.toml"

# Validate config file
if [ ! -f "$config_file" ]; then
  echo "Error: Config file '$config_file' not found."
  exit 1
fi

# Build
echo "Building with Env=$Env, config=$config_file..."
if ! sam build --parameter-overrides Env="$Env" --config-file "$config_file"; then
  echo "Error: Build failed."
  exit 1
fi

# Deploy
echo "Deploying stack ${Env}-hello-js..."
if [ "$Env" = "localstack" ]; then
  sam deploy --stack-name "${Env}-hello-js" --parameter-overrides Env="$Env" --config-file "$config_file" --profile localstack
else
  sam deploy --stack-name "${Env}-hello-js" --parameter-overrides Env="$Env" --config-file "$config_file"
fi
