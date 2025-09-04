#!/bin/bash
export BUILD_IMG_TAG="registry.cluster.local/ray:2.49.0" &&\
podman build -t $BUILD_IMG_TAG . &&\
podman save -o image.tar $BUILD_IMG_TAG &&\
k3s ctr -n k8s.io i import image.tar &&\
rm image.tar
