#!/bin/bash

export CONTAINER_PORT=${CONTAINER_PORT:-8200}
export SERVER_HOST=${SERVER_HOST:-0.0.0.0}

# Set default arguments
DEFAULT_ARGS="--host ${SERVER_HOST} --port ${CONTAINER_PORT}"

# Combine default and user-supplied arguments
CMD_ARGS="${DEFAULT_ARGS} $@"

# Run the llamacpp-server command with the environment variable
exec /usr/local/bin/llamacpp-server ${CMD_ARGS}
