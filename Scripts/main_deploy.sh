#! /bin/bash

# Vars

export WORKERS=4
export SDMANAGER_REPLICAS=5
export BUCKET='cortex-ibs-domain-prediction'
export GCLOUD_BUCKET='gcloud-computing-fcul-17'

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

# Cortex

bash Cortex/Scripts/main_init.sh

export ENDPOINT=$(cortex get domain-classifier-batch | grep "endpoint:" | head -1)

# Rest API

bash REST_API/main_init.sh

export REST_ENDPOINT=$(kubectl get services | grep "rest-api")

# Web APP

bash WEBAPP/main_init.sh

export WEBAPP=$(docker-machine ip swarm-manager-2)

# Echo Endpoints

## Cortex

if [ -z ${ENDPOINT} ]
then
  echo "Cortex not running"
else
  echo "Cortex running at '$ENDPOINT'"
fi

## Rest API

if [ -z ${REST_ENDPOINT} ]
then
  echo "Rest API not running"
else
  echo "Rest API running at '$REST_ENDPOINT'"
fi

## WEB APP

if [ -z ${WEBAPP} ]
then
  echo "Web Application not running"
else
  echo "Web Application running at '$WEBAPP'"
fi

#Open Web APP in firefox

PORT=8080
/usr/bin/firefox $WEBAPP
/usr/bin/firefox --new-window $WEBAPP:$PORT