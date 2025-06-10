# SOLUTION for Task 1

## Problem
- The Service’s selector uses `app: front-end`, but the Deployment and Pods use `app: frontend`. 
- As a result, the Service has no endpoints, and traffic fails.

## Steps to Fix
1. Update `service.yaml` to match the Deployment’s label:
   ```yaml
   selector:
     app: frontend

## Verify
- Run command:
make verify

- K8sGPT should report "No problems detected," and the in-cluster wget should succeed with "Hello from Task 1!".