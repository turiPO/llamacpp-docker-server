#!/bin/bash

# Set default values for optional arguments
N_PREDICT=10
STOP=()

# Help message function
print_help() {
    echo "Usage: ./your_script.sh [OPTIONS]"
    echo "Options:"
    echo "  -p, --prompt PROMPT    Specify the prompt (default: 'Once upon a time')"
    echo "  -n, --n-predict N      Specify the number of predictions (default: 10)"
    echo "  -s, --stop STOP        Specify the stop condition (default: [])"
    echo "  -h, --help             Display this help message"
    exit 0
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -p|--prompt)
        PROMPT="$2"
        shift
        shift
        ;;
        -n|--n-predict)
        N_PREDICT="$2"
        shift
        shift
        ;;
        -s|--stop)
        STOP=("$2")
        shift
        shift
        ;;
        -h|--help)
        print_help
        ;;
        *)  # Unknown option
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
done

# Use default prompt if not provided
PROMPT=${PROMPT:-"Once upon a time"}

# Send POST request using curl
curl -X POST -H "Content-Type: application/json" -d '{
  "n_predict": '"$N_PREDICT"',
  "prompt": "'"$PROMPT"'",
  "stop": '"$(jq -n --argjson stop "${STOP[*]}" '[ $stop[] ]' | tr -d '\n')"'
}' http://localhost:8080/completion
