.PHONY: all build run clean k8s-load k8s-forward k8s-clean

CONTAINER_NAME = silverfort-web
IMAGE = silverfort-web:latest
CLUSTER_NAME = silverfort

all: build run

build:
	docker build -t $(IMAGE) .

run:
	docker run -d \
		--name $(CONTAINER_NAME) \
		--hostname $(CONTAINER_NAME) \
		-p 3000:3000 \
		$(IMAGE)

clean:
	docker rm -f $(CONTAINER_NAME) || true

# Kubernetes
k8s-load:
	kind load docker-image $(IMAGE) --name $(CLUSTER_NAME)

k8s-deploy: k8s-load
	kubectl apply -f k8s/

k8s-forward:
	kubectl port-forward svc/silverfort-web 3000:3000

k8s-clean:
	kubectl delete -f k8s/ --ignore-not-found
