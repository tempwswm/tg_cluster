#!/bin/bash
export TG_VERSION="1.1.78" &&\
export BUILD_IMG_TAG="registry.cluster.local/tg-novnc:12_${TG_VERSION}" &&\
podman build -t $BUILD_IMG_TAG . --build-arg TG_VERSION=$TG_VERSION &&\
podman save -o image.tar $BUILD_IMG_TAG &&\
k3s ctr -n k8s.io i import image.tar &&\
rm image.tar
