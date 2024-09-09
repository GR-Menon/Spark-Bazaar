# -- Build Cluster Images

docker build \
  -f docker/hetzner-base.Dockerfile \
  -t hetzner-base .

docker build \
  -f docker/spark-cluster.Dockerfile \
  -t spark-cluster .

docker build \
  -f docker/jupyterlab.Dockerfile \
  -t jupyterlab .

docker build \
  -f docker/llama8b.Dockerfile \
  -t llama8b .