#!/usr/bin/env bash

# Copyright 2021 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

set -eoux pipefail

PROJECT_ROOT=$(git rev-parse --show-toplevel)

# Deploy kind cluster
${PROJECT_ROOT}/hack/kind/kind_install_for_capd.sh

# install cluster-api providers
export CLUSTER_TOPOLOGY=true
export EXP_CLUSTER_RESOURCE_SET=true
clusterctl init --core cluster-api:v1.2.0 --bootstrap kubeadm:v1.2.0 --control-plane kubeadm:v1.2.0 -i docker:v1.2.0

# install kapp-controller
kubectl apply -f https://github.com/vmware-tanzu/carvel-kapp-controller/releases/download/v0.38.4/release.yml
