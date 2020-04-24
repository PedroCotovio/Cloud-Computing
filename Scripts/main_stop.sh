#! /bin/bash

cd "${0%/*}"

export GOOGLE_APPLICATION_CREDENTIALS="~/.gcloud/service-acc-gcloud.json"
export GCLOUD_BUCKET='gcloud-computing-fcul-17'

export GCP_PROJECT_ID=$(
/usr/bin/python3 <<EOF
import json
import os
with open(os.environ.get("GOOGLE_APPLICATION_CREDENTIALS")) as json_file:
 print(json.load(json_file)["project_id"])
EOF
)

export BUCKET='cortex-ibs-domain-prediction'

#Dataset

bash Storage/clean.sh

#Cortex

bash Cortex/Scripts/main_finish.sh

#Rest API

bash REST_API/main_finish.sh

#WebAPP

bash Web-APP/main_finish.sh