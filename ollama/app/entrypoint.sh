#!/bin/bash



# Start the Ollama service in the background
/usr/local/bin/ollama serve &

# Wait for Ollama service to be fully up and running
while ! curl --silent $OLLAMA_BASE_URL; do
    echo "Waiting for Ollama server to start..."
    sleep 1
done

echo -e "\n======Ollama server has started.=========="

# Check if the LLM environment variable is set and not empty
if [ -z "$LLM" ]; then
    echo "LLM environment variable is not set. The Clojure script will not execute."
else
    echo "LLM is set to $LLM. Proceeding to run pull_model.clj."
    # Execute the Clojure script
    bb -f /app/pull_model.clj
fi

# call the base image entrypoint
/opt/nvidia/nvidia_entrypoint.sh\

exec "$@"

# Keep the container running if the script finishes
#tail -f /dev/null

