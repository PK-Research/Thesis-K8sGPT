Source: https://github.com/k8sgpt-ai/k8sgpt

# Run a scan with the default analyzers:
k8sgpt analyze --explain
k8sgpt analyze --explain --with-doc

# For JSON formatting, use:
k8sgpt analyze --explain --output=json

# Filter on resource
k8sgpt analyze --explain --filter=Service

## List of filters
Active: 
> Deployment
> ReplicaSet
> StatefulSet
> CronJob
> Node
> MutatingWebhookConfiguration
> Pod
> PersistentVolumeClaim
> Service
> Ingress
> ValidatingWebhookConfiguration
Unused: 
> PodDisruptionBudget
> NetworkPolicy
> Log
> GatewayClass
> Gateway
> HTTPRoute
> HorizontalPodAutoScaler

# HELP
k8sgpt --help

Kubernetes debugging powered by AI

Usage:
  k8sgpt [command]

Available Commands:
  analyze     This command will find problems within your Kubernetes cluster
  auth        Authenticate with your chosen backend
  cache       For working with the cache the results of an analysis
  completion  Generate the autocompletion script for the specified shell
  filters     Manage filters for analyzing Kubernetes resources
  generate    Generate Key for your chosen backend (opens browser)
  help        Help about any command
  integration Integrate another tool into K8sGPT
  serve       Runs k8sgpt as a server
  version     Print the version number of k8sgpt

Flags:
      --config string        Default config file (default is $HOME/.k8sgpt.yaml)
  -h, --help                 help for k8sgpt
      --kubeconfig string    Path to a kubeconfig. Only required if out-of-cluster.
      --kubecontext string   Kubernetes context to use. Only required if out-of-cluster.

Use "k8sgpt [command] --help" for more information about a command.