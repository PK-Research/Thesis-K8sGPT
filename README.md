# Prerequisites
- Docker
- K8sGPT (You need to install and config this locally to get your `k8sgpt.yaml`)
- Kubectl

# Before running
1. Configure K8sGPT and add a backend. Replace contents of `k8sgpt.yaml` in this folder with contents of your `k8sgpt.yaml`.
2. Configure password in `config.yaml`.
3. Replace YOUR_USER_HERE in `minikubestart.sh` path with your current user.
4. Replace YOUR_USER_HERE and YOUR_TOKEN_HERE in `startup.sh`.
4. Choose your extensions in Dockerfile.

# How to run
Run the start script "minikubestart.sh": `sh minikubestart.sh`.

The script does the following:
1. Builds docker image `research-env:latest`.
2. Stops and deletes any existing Minikube.
3. Starts a fresh Minikube with `--embed-certs`.
4. Configs kubectl with `Insecure skip TLS verification`.
5. Runs `research-env:latest`

The address to container will be shown in terminal once the setup is complete.

# In the container
1. Set your VSCode preferences.
2. Start working on the tasks.

# Notes
This is an insecure container with external access via Ngrok tunnel. Only use this for temporary testing and research.