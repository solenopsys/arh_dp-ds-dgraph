#!/bin/sh

build_push(){
  docker buildx build  --platform ${ARCHS} -f dgraph.Dockerfile -t ${REGISTRY}/${NAME}:latest  --output=type=registry,registry.insecure=true --push .
}

helm_build_push(){
  FN=${NAME}-${VER}.tgz
  rm ${FN}
  helm package ./install --version ${VER}
  curl --data-binary "@${FN}" http://helm.klogsolenopsys.org/api/charts
}

REGISTRY=registry.klogsolenopsys.org
NAME=solenopsys-ds-dgraph
ARCHS="linux/amd64,linux/arm64"
VER=0.1.4

helm_build_push
build_push





