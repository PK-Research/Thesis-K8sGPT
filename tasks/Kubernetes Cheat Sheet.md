# Alias kubectl
alias k=kubectl

# Launch K9s:
k9s

# Create a pod from a YAML file.
kubectl create -f <pod-definition.yaml> 	

# List all pods in the cluster.
kubectl get pods

# Describe a specific pod.
kubectl describe pod <pod-name>

# Get logs from a pod.
kubectl logs <pod-name>

# Stream logs from a pod.
kubectl logs -f <pod-name>

# Get logs with a specific label.
kubectl logs -l <label-key>=<label-value>

# Delete a pod.
kubectl delete pod <pod-name>

# Create a pod with the name.
kubectl create pod <pod-name>

# List all pods in a namespace.
kubectl get pod -n <namespace_name>

# List all config maps.
kubectl get configmaps

# List all secrets.
kubectl get secrets

# Describe a specific config map.
kubectl describe configmap <config-map-name>

# Describe a specific secret.
kubectl describe secret <secret-name>

# Delete a specific secret.
kubectl delete secret <secret_name>

# Delete a specific config map.
kubectl delete configmap <config-map-name>