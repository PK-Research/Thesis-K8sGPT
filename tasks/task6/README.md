 Task 6 (Complex)

## Prerequisites:
- Apply the manifests with command:
make apply

## Starting State:
Two Deployments (frontend and backend), Services, an Ingress, and a CronJob are deployed. However, multiple misconfigurations prevent the application from working.

## Objective:
Diagnose and fix all the issues so that:
- The frontend is accessible at `frontend-service:80`.

## You can run K8sGPT with:
- To run a scan using LLM
k8sgpt analyze --explain

- To get the official documentation from Kubernetes:
k8sgpt analyze --explain --with-doc

-  For JSON formatting, use:
k8sgpt analyze --explain --output=json

For more info on and commands, see [K8sGPT Cheat Sheet.md](../K8sGPT%20Cheat%20Sheet.md) in the upper directory.

## Verification:
- To verify current cluster state:
make verify

- To verify .yaml files by first deleting current configurations, then doing a clean apply:
make verify-files

## Note:
- You may need to create or adjust ConfigMaps, Secrets, or other resources to fix the issues.
- Be mindful of resource requests and limits to fit within the namespace's ResourceQuota and LimitRange.

## After the task is done:
- After making changes, verify the task by running:
make verify

- If successfully verified, delete the applied manifests by running:
make delete