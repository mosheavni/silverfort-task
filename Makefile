.PHONY: all certs build run clean k8s-load k8s-secret k8s-deploy k8s-forward k8s-clean

CONTAINER_NAME = silverfort-web
IMAGE = silverfort-web:latest
CLUSTER_NAME = silverfort

all: certs build run

certs:
	@bash generate_certs.sh

build:
	docker build -t $(IMAGE) .

run:
	docker run -d \
		--name $(CONTAINER_NAME) \
		--hostname $(CONTAINER_NAME) \
		-p 443:8443 \
		-v $(PWD)/certs:/app/certs:ro \
		$(IMAGE)

clean:
	docker rm -f $(CONTAINER_NAME) || true

# Kubernetes
k8s-load:
	kind load docker-image $(IMAGE) --name $(CLUSTER_NAME)

k8s-secret:
	kubectl create secret generic silverfort-tls \
		--from-file=cert.pem=certs/cert.pem \
		--from-file=key.pem=certs/key.pem \
		--dry-run=client -o yaml > k8s/secret.yaml

k8s-deploy: k8s-load k8s-secret
	kubectl apply -f k8s/

k8s-forward:
	kubectl port-forward svc/silverfort-web 8443:443

k8s-clean:
	kubectl delete -f k8s/ --ignore-not-found
