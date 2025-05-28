SERVICE_NAME ?= frontend-service
PORT_FORWARD_PORT ?= 8080
REMOTE_SERVICE_PORT ?= 80
CHECK_ENDPOINT ?= http://localhost:8080

.PHONY: apply delete verify verify-files

apply:
	@echo "Applying Kubernetes manifests for Task 5..."
	kubectl apply -f manifests/

delete:
	@echo "Deleting Kubernetes manifests for Task 5..."
	kubectl delete -f manifests/ || true
	kubectl delete cronjobs --all --cascade=foreground || true

verify:
	@echo "---------- [VERIFY] ----------"
	
	@echo "Running K8sGPT to analyze issues..."
	k8sgpt analyze --explain | tee k8sgpt.log

	@if grep -qi 'No problems detected' k8sgpt.log; then \
		echo "[OK] No problems reported by K8sgpt."; \
	else \
		echo "[ERROR] K8sgpt found issues. Please fix them."; \
		exit 1; \
	fi

	@echo "Testing service from within the cluster..."
	kubectl run testpod --image=busybox --restart=Never --rm -i -- \
		sh -c "wget -qO- http://$(SERVICE_NAME):$(REMOTE_SERVICE_PORT) && echo [OK]"

	@echo "------------------------------------------"
	@echo "Task 5 verified successfully!"
	@echo "Deleting current deployment..."
	$(MAKE) delete

verify-files:
	@echo "---------- [VERIFY-FILES] ----------"
	$(MAKE) delete
	$(MAKE) apply

	@echo "Sleeping 20 seconds to allow Pods (and CronJob) to become ready..."
	sleep 20;

	@echo "Running K8sGPT to analyze issues..."
	k8sgpt analyze --explain | tee k8sgpt.log

	@if grep -qi 'No problems detected' k8sgpt.log; then \
		echo "[OK] No problems reported by K8sgpt."; \
	else \
		echo "[ERROR] K8sgpt found issues. Please fix them."; \
		exit 1; \
	fi

	@echo "Testing service from within the cluster..."
	kubectl run testpod --image=busybox --restart=Never --rm -i -- \
		sh -c "wget -qO- http://$(SERVICE_NAME):$(REMOTE_SERVICE_PORT) && echo [OK]"

	@echo "------------------------------------------"
	@echo "Task 5 verified successfully!"
	@echo "Deleting current deployment..."
	$(MAKE) delete