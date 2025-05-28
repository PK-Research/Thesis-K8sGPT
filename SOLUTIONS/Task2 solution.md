# SOLUTION for task2_simple

## Problems
1. The Deployment references `key: password` in `myapp-secret`, but `secret.yaml` only defines `username`.
2. The Deployment tries to mount a ConfigMap named `myconfig`, which doesn't exist at all.

## Steps to Fix
1. Either add `password` to `myapp-secret`, or remove the reference if not needed.
2. Create a ConfigMap named `myconfig` (or remove the volume reference) so the Pod can mount it.

## Verify
- Run command:
make verify

- K8sGPT should report "No problems detected," and the in-cluster wget should succeed with NG