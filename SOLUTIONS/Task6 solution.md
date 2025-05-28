# SOLUTION for Task 6 (Complex)

## Problems

1. **Ingress**:
   - References `frontend` instead of `frontend-service`.

2. **CronJob**:
   - References `DB_PASS` in `myapp-secret`, but that key is missing.

3. **IngressClass**
   - ingressClass.yaml is missing.

## Steps to Fix

1. **Ingress**:
   - Fix the service name from `frontend` to `frontend-service`.
"""
   pathType: Prefix
   backend:
   service:
      name: frontend-service
      port:
         number: 80
"""

2. **CronJob/Secret**:
   - Add `DB_PASS` to `myapp-secret` or remove the environment variable if not needed.

3. **IngressClass**
   - Add ingressClass.yaml:
"""
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  name: task-ingressClass
spec:
  controller: k8s.io/ingress-nginx
"""

## Verify
- Run:
make verify

- K8sGPT should report "No problems detected," and the in-cluster wget should succeed w