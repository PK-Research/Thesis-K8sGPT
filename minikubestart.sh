docker build -t research-env:latest .

#!/usr/bin/env bash
set -e

# 1. Stop & delete any existing Minikube
minikube stop || true
minikube delete || true

# 2. Start a fresh Minikube (tweak flags as needed)
minikube start \
  --embed-certs

# 3. Patch kubeconfig to replace 127.0.0.1:<PORT> with host.docker.internal:<PORT>.
#    The [0-9]\+ portion captures the random port that Minikube assigns.
#    Adjust the path to .kube/config if needed.
sed -i 's|server: https://127\.0\.0\.1:\([0-9]\+\)|server: https://host.docker.internal:\1|' /home/YOUR_USER_HERE/.kube/config

echo "Minikube started and kubeconfig updated. Current contexts:"
kubectl config get-contexts

# 4. Insecure skip TLS verification
kubectl config set-cluster minikube --insecure-skip-tls-verify=true

docker run -it --rm \
  -v /home/YOUR_USER_HERE/.kube:/home/coder/.kube \
  -e KUBECONFIG=/home/coder/.kube/config \
  --add-host=host.docker.internal:host-gateway \
  --name research-env \
  research-env:latest