# Start from Ubuntu base image
FROM ubuntu:22.04

# Set ARGs for versions
ARG KUBECTL_VERSION="v1.27.3"
ARG MINIKUBE_VERSION="v1.30.1"
ARG K9S_VERSION="v0.27.4"
ARG K8SGPT_VERSION="v0.3.48"
ARG CODE_SERVER_VERSION="4.96.4"
ARG COPILOT_VERSION="1.262.0"

ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies (including 'make')
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    tar \
    bash \
    git \
    openssh-client \
    openssl \
    gnupg \
    lsb-release \
    iptables \
    sudo \
    passwd \
    make \
    wget \
    vim \
    && rm -rf /var/lib/apt/lists/*

ENV EDITOR=vim

# Install only Docker CLI (no Docker Engine) from Docker’s official repository
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo \
       "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update && apt-get install -y --no-install-recommends \
       docker-ce-cli \
       docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/

# Install Minikube
RUN curl -LO "https://storage.googleapis.com/minikube/releases/${MINIKUBE_VERSION}/minikube-linux-amd64" \
    && chmod +x minikube-linux-amd64 \
    && mv minikube-linux-amd64 /usr/local/bin/minikube

# Install K9s
RUN curl -LO "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz" \
    && tar xfz k9s_Linux_amd64.tar.gz \
    && mv k9s /usr/local/bin/ \
    && rm k9s_Linux_amd64.tar.gz

# Install K8sGPT
RUN curl -sL "https://github.com/k8sgpt-ai/k8sgpt/releases/download/${K8SGPT_VERSION}/k8sgpt_Linux_x86_64.tar.gz" -o k8sgpt.tar.gz \
    && tar xfz k8sgpt.tar.gz \
    && mv k8sgpt /usr/local/bin/ \
    && rm k8sgpt.tar.gz

# Install code-server
RUN curl -fOL "https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server-${CODE_SERVER_VERSION}-linux-amd64.tar.gz" \
    && tar xfz code-server-${CODE_SERVER_VERSION}-linux-amd64.tar.gz \
    && mv code-server-${CODE_SERVER_VERSION}-linux-amd64 /usr/local/lib/code-server \
    && rm -f code-server-${CODE_SERVER_VERSION}-linux-amd64.tar.gz

#
# Create the user and directories
#
USER root

# 1) Create a 'docker' group manually since we installed only docker-ce-cli.
# 2) Create the 'coder' group and user.
RUN groupadd -g 1000 coder \
    && groupadd docker || true \
    && useradd -g coder -d /home/coder -m -s /bin/bash coder \
    && mkdir -p /var/run/code-server \
    && chown coder:coder /var/run/code-server \
    && mkdir -p /workspace/tasks \
    && chown -R coder:coder /workspace \
    && mkdir -p /home/coder/.config/k8sgpt \
    && mkdir -p /home/coder/.config/code-server \
    && chown -R coder:coder /home/coder/.config \
    && usermod -aG docker coder

# Grant 'coder' passwordless sudo privileges
RUN echo "coder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/coder && chmod 0440 /etc/sudoers.d/coder

# Switch to coder to install VS Code extensions
USER coder
ENV HOME=/home/coder

# Install extensions as coder before copying config.yaml. ADD OR REMOVE YOUR EXTENSIONS HERE.
RUN /usr/local/lib/code-server/bin/code-server --install-extension redhat.vscode-yaml
RUN /usr/local/lib/code-server/bin/code-server --install-extension formulahendry.code-runner
RUN /usr/local/lib/code-server/bin/code-server --install-extension golang.Go
RUN /usr/local/lib/code-server/bin/code-server --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
RUN /usr/local/lib/code-server/bin/code-server --install-extension ms-vscode.makefile-tools
RUN /usr/local/lib/code-server/bin/code-server --install-extension ms-azuretools.vscode-docker

# Back to root to copy tasks and config files
USER root

# Add tasks directory
COPY tasks /workspace/tasks
RUN chown -R coder:coder /workspace/tasks

# Copy config files after extensions are installed
COPY k8sgpt.yaml /home/coder/.config/k8sgpt/k8sgpt.yaml
COPY config.yaml /home/coder/.config/code-server/config.yaml
RUN chown -R coder:coder /home/coder/.config

# Install Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Copy startup script
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# By setting WORKDIR, terminals and code-server default folder is /workspace/tasks
WORKDIR /workspace/tasks

# Expose code-server port
EXPOSE 8080

# Use startup.sh as the default CMD
CMD ["/startup.sh"]
