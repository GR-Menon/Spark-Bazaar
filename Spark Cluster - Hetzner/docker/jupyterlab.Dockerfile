FROM hetzner-base

# -- Layer: JupyterLab
COPY requirements/jlab-reqs.txt requirements.txt

RUN apt-get update -y && \
    apt-get install -y python3-pip wget && \
    pip3 install -r requirements.txt

# -- Runtime

EXPOSE 8888
WORKDIR ${SHARED_WORKSPACE}
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=