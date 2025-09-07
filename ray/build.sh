#!/bin/bash
export RAY_VERSION="2.49.1" &&\
export BUILD_IMG_TAG="registry.cluster.local/ray:${RAY_VERSION}" &&\
podman build -t $BUILD_IMG_TAG . --build-arg RAY_VERSION=$RAY_VERSION &&\
podman save -o image.tar $BUILD_IMG_TAG &&\
k3s ctr -n k8s.io i import image.tar &&\
rm image.tar
