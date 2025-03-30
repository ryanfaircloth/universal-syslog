#!/usr/bin/env bash
set -o errexit

cluster_name="us"
reg_name='local-registry'

kind delete cluster --name ${cluster_name}

podman rm -f ${reg_name}