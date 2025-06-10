# Task 3 (Moderate)

## Prerequisites:
- Apply the manifests with command:
make apply

## Starting State:
A distributed application is deployed using Kubernetes manifests. The application is not functioning correctly, with requests failing and data not being processed as expected.

## Objective:
Diagnose and fix all the issues so that the application functions correctly.

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
- You may need to create or adjust ConfigMaps, Secrets, and other resources to fix the issues.
- Be mindful of resource requests and limits to fit within the namespace's ResourceQuota and LimitRange.

## After the task is done:
- After making changes, verify the task by running:
make verify

- If successfully verified, delete the applied manifests by running the command (if you get errors on deletion, it likely means that "make verify" already deleted everything):
make delete

- Move to the next task using command:
cd ../task4_moderate