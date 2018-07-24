ARG FROM_IMG_REGISTRY=docker.io
ARG FROM_IMG_REPO=qnib
ARG FROM_IMG_NAME="horovod-base"
ARG FROM_IMG_TAG="latest"
ARG FROM_IMG_HASH=""
FROM ${FROM_IMG_REGISTRY}/${FROM_IMG_REPO}/${FROM_IMG_NAME}:${FROM_IMG_TAG}${DOCKER_IMG_HASH}

# TensorFlow version is tightly coupled to CUDA and cuDNN so it should be selected carefully
ENV TENSORFLOW_VERSION=1.9.0
ENV PYTORCH_VERSION=0.4.0

# Install TensorFlow and Keras
RUN pip install tensorflow-gpu==${TENSORFLOW_VERSION} keras h5py

# Install PyTorch
RUN PY=$(echo ${PYTHON_VERSION} | sed s/\\.//); \
    if [[ ${PYTHON_VERSION} == 3* ]]; then \
        pip install http://download.pytorch.org/whl/cu90/torch-${PYTORCH_VERSION}-cp${PY}-cp${PY}m-linux_x86_64.whl; \
    else \
        pip install http://download.pytorch.org/whl/cu90/torch-${PYTORCH_VERSION}-cp${PY}-cp${PY}mu-linux_x86_64.whl; \
    fi; \
    pip install torchvision
