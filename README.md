# Spark Bazaar
A collection of Apache Spark cluster setups using Docker.

![Spark Bazaar](assets/spark-bazaar.png)    
</br>   

# Context

This is a pre-cursor to the BigBanyanTree project, an initiative to empower engineering colleges to set up their data engineering clusters and drive interest in data processing and analysis using tools such as Apache Spark.

This work was done in collaboration with [Suchit G](https://www.linkedin.com/in/suchitg04/) under the guidance of [Harsh Singhal](https://www.linkedin.com/in/harshsinghal/).

The data extracted using the `Spark Cluster - Hetzner` has been open-sourced on [HuggingFace](https://huggingface.co/big-banyan-tree).

</br>  

# Basic Cluster

This is a basic [Apache Spark](https://spark.apache.org/) cluster recreated from this blog:     

</br>   

> [Spark Standalone Cluster on Docker](https://medium.com/@MarinAgli1/setting-up-a-spark-standalone-cluster-on-docker-in-layman-terms-8cbdc9fdd14b)

</br>    

The cluster comprises a single `Docker` image running Apache Spark, and its different services orchestrated using 
`Docker Compose`. It uses an entrypoint shell script, to start up different services based on the Spark Workload, like `spark-master`, `spark-worker` and `spark-history-server`.

We also make use of a `Makefile` for ease of spinning up and tearing down the Spark cluster services.

To run the basic cluster, navigate to the `Spark Cluster - Basic` directory and run:
```bash
make run-scaled
```
This will spin up a standalone Spark cluster with 2 worker nodes.

</br>

# Jupyterlab Cluster

This is an Apache Spark cluster in standalone mode, accompanied by a user-friendly Jupyterlab interface to run Spark jobs. This cluster setup is based on this blog:

</br>

> [Apache Spark Cluster with Jupyterlab Interface](https://towardsdatascience.com/apache-spark-cluster-on-docker-ft-a-juyterlab-interface-418383c95445)

</br>

This setup takes a slightly different approach from the one before. Here, we make use of separate Docker images for each of the cluster services such as `spark-master`, `spark-worker`, `jupyterlab` and so on. As before, all these separate Docker images are orchestrated using Docker Compose.

The individual service images also make use of a common `cluster-base` Docker image to build the service on.

To run the jupyterlab cluster, navigate to `Spark Cluster - Jupyterlab` directory and run:
```bash
chmod +x .build.sh
chmod +x .run.sh
./build.sh
./run.sh
```

This will spin up a standalone Spark cluster with 2 worker nodes and a Jupyterlab interface.

</br>

# Hetzner Cluster

This is the Apache Spark cluster setup used in the BigBanyanTree project. It takes a hybrid approach, taking the learnings from the previous two cluster setups.

We use the following Docker images:
- `hetzner-base`: Base image for all services
- `spark-cluster`: Apache Spark image with functionality for `spark-master`, `spark-worker` & `spark-history-server`
- `jupyterlab`: Image for Jupyterlab interface
- `llama8b`: Image for `Meta-Llama-3.1-8B-Instruct` service using `llamafile`

Check out the `llama8b` service setup here : https://datascience.fm/llamafile-an-executable-llm/

Check out an in-detail explanation of this entire setup here: https://datascience.fm/zero-to-spark-apache-spark-cluster-setup/
