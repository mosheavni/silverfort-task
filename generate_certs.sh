#!/usr/bin/env bash
set -euo pipefail

mkdir -p certs

openssl req -x509 \
  -newkey rsa:4096 \
  -keyout certs/key.pem \
  -out certs/cert.pem \
  -days 365 \
  -nodes \
  -subj "/C=IL/ST=Tel-Aviv/L=Tel-Aviv/O=Silverfort/CN=localhost"

echo "Certs generated in ./certs/"
