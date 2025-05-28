# SOLUTION for Task 4 (Moderate)

## Problems

1. **Readiness Probe Failure**  
   - The main container's probe is set to `/healthz` which http-echo doesn't serve, so the Pod is never “Ready.”

2. **RBAC Issue**  
   - The sidecar container runs `kubectl get pods` with the `default` ServiceAccount, which lacks permission to list pods. 
   - The provided RoleBinding references `admin-sa` instead of `default`.

3. **Missing ConfigMap Key**  
   - The sidecar tries to load `specialKey` from `sidecar-config`. If `sidecar-config` or `specialKey` is not defined, the Pod events show a missing key error.

## Steps to Fix

1. **Readiness Probe**  
   - Either remove it or change `path: /healthz` to `/`. 
   - Or configure http-echo to actually serve `/healthz`.

2. **RBAC**  
   - Update the RoleBinding to reference the `default` SA, or make a new SA in the Deployment and match it here. 
   - Alternatively, remove the `kubectl get pods` logic if not needed.

3. **sidecar-config**  
   - Create a ConfigMap named `sidecar-config` with a key `specialKey`. 
   - Or remove the environment variable reference if it’s not required.

## Verify
- Run command:

make verify

- K8sGPT should report "No problems detected," and the in-cluster wget should succeed with "Hello