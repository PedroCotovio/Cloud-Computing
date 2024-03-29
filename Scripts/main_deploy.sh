#! /bin/bash

# Vars

export WORKERS=4
export SDMANAGER_REPLICAS=5
export BUCKET='cortex-ibs-domain-prediction-2'
export GCLOUD_BUCKET='gcloud-computing-fcul'
export GCP_REGION='us-central1'
export SPARK_CLUSTER=pyspark-cluster

# Credentials

export GOOGLE_APPLICATION_CREDENTIALS=~/.gcloud/service-acc-gcloud.json

export GCP_PROJECT_ID=$(
python3 <<EOF
import json
import os
with open(os.environ.get("GOOGLE_APPLICATION_CREDENTIALS")) as json_file:
 print(json.load(json_file)["project_id"])
EOF
)

gcloud auth configure-docker
echo 'Y' | gcloud auth application-default login

#Dataset

bash Storage/setup.sh

# Rest API

bash Rest_API/main_init.sh

export REST_ENDPOINT_FULL=$(kubectl get ingress | grep "api-ingress")
export REST_ENDPOINT=$(
python3 <<EOF
import os
ip = os.environ.get("REST_ENDPOINT_FULL")
ip = ip.split(' ')
for var in ip:
     try:
        test = int(var[0])
        print(var)
        break
     except:
        pass

EOF
)

# Spark

bash Spark-CN/main_init.sh

export SC=$(gcloud dataproc clusters list --region=$GCP_REGION | grep "pyspark-cluster"| head -1)
export CONFIRM=$(
python3 <<EOF
import os
cluster = os.environ.get("SPARK_CLUSTER")
sc = os.environ.get("SC")
conf = cluster.split(' ')[0]
if conf == cluster: print('OK')
EOF
)

# Cortex

bash Cortex/Scripts/main_init.sh

export ENDPOINT=$(cortex get domain-classifier-batch | grep "endpoint:" | head -1)
export ENDPOINT=$(
python3 <<EOF
import os
ip = os.environ.get("ENDPOINT")
print(ip.replace('endpoint: ', ''))
EOF
)

# Web APP

bash Web-APP/main_init.sh

export WEBAPP=$(docker-machine ip swarm-manager-2)

sleep 30

# Echo Endpoints

## Rest API

if [ -z ${REST_ENDPOINT} ]
then
  echo "Rest API not running"
else
  echo "Rest API running at '$REST_ENDPOINT'"
fi

## SPARK

if [ -z ${CONFIRM} ]
then
  echo "SPARK Cluster not running"
else
  echo "SPARK Cluster running at '$SPARK_CLUSTER'"
fi

## Cortex

if [ -z ${ENDPOINT} ]
then
  echo "Cortex not running"
else
  echo "Cortex running at '$ENDPOINT'"
fi

## WEB APP

if [ -z ${WEBAPP} ]
then
  echo "Web Application not running"
else
  echo "Web Application running at '$WEBAPP'"
fi

#Open Web APP in firefox

/usr/bin/firefox $WEBAPP
/usr/bin/firefox --new-window $WEBAPP:8080