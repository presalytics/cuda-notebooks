#! /bin/bash

set -ex

CUDA_VERSION=11.4.3
BASE_IMAGE=nvidia/cuda:${CUDA_VERSION}-devel-ubuntu20.04
OWNER=cvops-notebook
FOUNDATION_IMAGE=${OWNER}/jupyter-foundation-cuda-${CUDA_VERSION}
BASE_NOTEBOOK_IMAGE=${OWNER}/base-notebook-cuda-${CUDA_VERSION}
MINIMAL_NOTEBOOK_IMAGE=${OWNER}/minimal-notebook-cuda-${CUDA_VERSION}

docker build ./docker-stacks/images/docker-stacks-foundation \
    --build-arg ROOT_CONTAINER=${BASE_IMAGE} \
    -t ${FOUNDATION_IMAGE}

docker build ./docker-stacks/images/base-notebook \
    --build-arg BASE_CONTAINER=${FOUNDATION_IMAGE} \
    -t ${BASE_NOTEBOOK_IMAGE}

docker build ./docker-stacks/images/minimal-notebook \
    --build-arg BASE_CONTAINER=${BASE_NOTEBOOK_IMAGE} \
    -t ${MINIMAL_NOTEBOOK_IMAGE}