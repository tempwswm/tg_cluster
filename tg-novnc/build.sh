#!/bin/bash
export BUILD_IMG_TAG="registry.cluster.local/tg-novnc:12_1.1.77_v4" &&\
podman build -t $BUILD_IMG_TAG . &&\
podman save -o image.tar $BUILD_IMG_TAG &&\
k3s ctr -n k8s.io i import image.tar &&\
rm image.tar
