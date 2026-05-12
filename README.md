# Silverfort DevOps Task

## Prerequisites

- Docker
- `kind` cluster (`kind create cluster` if not already running)
- `kind` cli (can be installed with `brew install kind`)
- `kubectl`

## Quick Start

### Docker

```bash
make all
```

Access: <https://localhost:3000>

### Kind

Create the cluster:

```bash
kind create cluster --name silverfort
```

Deploy the app:

```bash
# Image must be built first (make build)
make k8s-deploy  # loads image into kind + creates TLS secret + applies manifests
make k8s-forward # port-forward svc to localhost:8443
```
