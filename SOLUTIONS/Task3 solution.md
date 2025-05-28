# SOLUTION for Task 3 (Missing ConfigMap Key)

## Problem
- The Deployment references a ConfigMap key named `welcome`, but the actual ConfigMap (`task3-config`) only has `title`. This mismatch triggers a missing key error.

## Steps to Fix
1. Update either the ConfigMap to include a key called `welcome`, or change the Deployment to use `title`.
2. Once aligned, the container should correctly set WELCOME_MESSAGE. 
   - For instance, define `welcome: "Hello from Task 3"` in the ConfigMap,
     or change `key: welcome` to `key: title` in the Deployment.

## Verify
- Run command:
make verify

- K8sGPT should report "No problems detected," and the in-cluster wget should succeed with "Hel