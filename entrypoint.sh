#!/bin/bash

# Parameters passed with script invocation
APP_NAME=$1
TASK=$2
TASK_NAME=$3

# Constants for auth and targeting space
CF_API=https://api.fr.cloud.gov
CF_USERNAME=$4
CF_PASSWORD=$5
CF_ORG=$6
CF_SPACE=$7

if [[ -z ${APP_NAME} ]]; then
  echo "You must specify an app name"
  exit 1
fi

if [[ -z ${TASK} ]]; then
  echo "You must specify a task to run"
  exit 1
fi

if [[ -z ${TASK_NAME} ]]; then
  echo "You must specify a name for your task"
  exit 1
fi

# Authenticate with cloud.gov and target space
cf api "$CF_API"
cf auth "$CF_USERNAME" "$CF_PASSWORD"
cf target -o "$CF_ORG" -s "$CF_SPACE"

# Run task
cf run-task $APP_NAME "$TASK" --name $TASK_NAME