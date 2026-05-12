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

Access: <https://localhost:8443>
