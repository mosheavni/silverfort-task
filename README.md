# Silverfort DevOps Task

Python app showing the client's IP Address, container name, and current temperature in Tel-Aviv. Served over HTTPS with a self-signed certificate.

## Prerequisites

- Docker
- `kind` cluster (`kind create cluster` if not already running)
- `kind` cli (can be installed with `brew install kind`)
- `kubectl`
- `openssl`

## Quick Start

### Docker

```bash
make all
```

Access: <https://localhost:443>

### Kind

Create the cluster:

```bash
kind create cluster --name silverfort
```

Deploy the app:

```bash
# Image must be built first (make build)
make k8s-deploy
make k8s-forward
```

## Bonus - metrics server

In order to gain more visibility into the app's performance, a simple metrics server is included.

### Installation

```bash
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm repo update
helm upgrade --install --set args={--kubelet-insecure-tls} metrics-server metrics-server/metrics-server --namespace kube-system
```

### Usage

```bash
kubectl top pods
```
