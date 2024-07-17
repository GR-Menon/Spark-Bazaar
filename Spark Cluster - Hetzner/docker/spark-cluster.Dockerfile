FROM hetzner-base 

# Specify Spark version
ARG spark_version=3.5.1


# Setup the directories for our Spark and Hadoop installations
ENV SPARK_HOME=${SPARK_HOME:-"/opt/spark"}
ENV HADOOP_HOME=${HADOOP_HOME:-"/opt/hadoop"}

RUN mkdir -p ${HADOOP_HOME} && mkdir -p ${SPARK_HOME}

# Set runtime directory
WORKDIR ${SPARK_HOME}

# Download and install Spark
RUN apt-get update -y --fix-missing && \
    curl https://archive.apache.org/dist/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop3.tgz -o spark-${spark_version}-bin-hadoop3.tgz \
    && tar xvzf spark-${spark_version}-bin-hadoop3.tgz --directory /opt/spark --strip-components 1 \
    && rm -rf spark-${spark_version}-bin-hadoop3.tgz

# Setup Spark related environment variables
ENV PATH="/opt/spark/sbin:/opt/spark/bin:${PATH}"
ENV SPARK_VERSION=${spark_version}
ENV SPARK_MASTER="spark://spark-master:7077"
ENV SPARK_MASTER_HOST=spark-master
ENV SPARK_MASTER_PORT=7077
ENV PYSPARK_PYTHON=python3

# Copy Spark default config to working directory
COPY conf/spark-defaults.conf "$SPARK_HOME/conf"

RUN chmod u+x /opt/spark/sbin/* && \
    chmod u+x /opt/spark/bin/*

ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH

# Copy appropriate entrypoint script
COPY entrypoint.sh /opt/spark/entrypoint.sh
RUN sudo chmod +x /opt/spark/entrypoint.sh

ENTRYPOINT ["/opt/spark/entrypoint.sh"]