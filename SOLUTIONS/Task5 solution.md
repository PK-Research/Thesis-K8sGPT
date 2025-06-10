# SOLUTION for Task 5 (Complex) - Multiple Issues

## Problems

1. **Deployment & ConfigMap**:
   - The Deployment references `missing_key` in `myapp-config`, but the ConfigMap only has `sample_key`.
   - This may cause an environment variable retrieval error or no text shown.

2. **CronJob**:
   - The schedule is invalid (`"* * *"` instead of a 5-field cron format like `"* * * * *"`).
   - The CronJob references `secretKeyRef.key: password`, but `myapp-secret` only has `username`.

## Steps to Fix

1. **Fix the ConfigMap reference**:
   - Either add `user_key` to `myapp-config`, or change the Deployment’s `key: user_key` to `key: sample_key`.
2. **Fix the CronJob**:
   - Change `schedule: "* * * * *"` or another valid cron expression.
   - Either add `password` to `myapp-secret`, or update the CronJob to read `username`.

## Verify
- Run command:
make verify

- K8sGPT should report "No problems detected," and the in-cluster wget should succeed with "Hello from Task 5 (PVC)!" (or whatever text is derived from the corrected key).
- The CronJob should no longer produce errors about invalid schedule or missing secret key.