FROM python:3.11-bullseye AS hetzner-base

ARG shared_workspace=/opt/workspace

# Setup basic environment and python
RUN mkdir -p ${shared_workspace} && \
    apt-get update -y --fix-missing && \
    apt-get install -y --no-install-recommends \
    sudo \
    curl \
    vim \
    unzip \
    rsync \ 
    openjdk-11-jdk \
    build-essential \
    software-properties-common \
    ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV SHARED_WORKSPACE=${shared_workspace}

VOLUME ${shared_workspace}

CMD ["bash"]