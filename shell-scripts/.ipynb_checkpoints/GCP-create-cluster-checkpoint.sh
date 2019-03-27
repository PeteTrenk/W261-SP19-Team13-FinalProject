#! /usr/bin/env bash

BUCKET="w261-bucket"
CLUSTER="w261-demo"
PROJECT="w261-216504"
JUPYTER_PORT="8123"
PORT="10000"
ZONE=$(gcloud config get-value compute/zone)


# CREATE DATAPROC CLUSTER
gcloud dataproc clusters create ${CLUSTER} \
    --metadata "JUPYTER_PORT=${JUPYTER_PORT}" \
    --metadata "JUPYTER_CONDA_PACKAGES=numpy:pandas:scipy:pyarrow:seaborn:networkx" \
    --properties "spark:spark.jars.packages=graphframes:graphframes:0.7.0-spark2.3-s_2.11" \
    --metadata "JUPYTER_CONDA_CHANNELS=conda-forge" \
    --project ${PROJECT} \
    --bucket ${BUCKET} \
    --image-version "1.3.10-deb9" \
    --initialization-actions \
       gs://dataproc-initialization-actions/jupyter/jupyter.sh \
    --num-preemptible-workers=4 \
    --num-workers=2 \
    --worker-machine-type=n1-standard-8 \
    --master-machine-type=n1-standard-8 
    
# --image-version preview will run in spark 2.4 beta mode, where avro comes included
# --properties "spark:spark.jars.packages=com.databricks:spark-avro_2.11:4.0.0" 

