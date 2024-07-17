FROM eclipse-temurin:17-jre-focal AS hetzner-base


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
        build-essential \
        software-properties-common \
        ssh && \
    apt-get install -y python3 && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV SHARED_WORKSPACE=${shared_workspace}

VOLUME ${shared_workspace}

CMD ["bash"]