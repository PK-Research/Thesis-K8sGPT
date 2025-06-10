#!/usr/bin/env bash
set -e

# Start code-server as 'coder' user in the background
sudo -iu coder /usr/local/lib/code-server/bin/code-server /workspace/tasks --host 0.0.0.0 --port 8080 &
CODE_SERVER_PID=$!

# Wait for code-server to start responding
sleep 10

sed -i 's/\/home\/YOUR_USER_HERE\/.minikube/\/home\/coder\/.minikube/g' /home/coder/.kube/config

sleep 10

# Install ngrok (if not already done in Dockerfile)
sudo apt-get update && sudo apt-get install -y gnupg
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
    | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt-get update && sudo apt-get install -y ngrok

# Add ngrok auth token
ngrok config add-authtoken YOUR_TOKEN_HERE

# Run ngrok in the background
ngrok http 8080 &
NGROK_PID=$!

# Wait for ngrok to spin up
sleep 10

# Print ngrok tunnels to logs
curl http://127.0.0.1:4040/api/tunnels

# Keep the container running by waiting on code-server process
wait $CODE_SERVER_PID
