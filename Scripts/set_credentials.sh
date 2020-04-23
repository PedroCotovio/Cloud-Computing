#! /bin/bash

#Gcloud
PROJECT_ID=your_project
NAME=your_iam_name
#AWS
ACCESS_KEY= your_access_key_id
SECRET_ACCESS_KEY= your_secret_access_key


#-------------------------------------#

gcloud iam service-accounts keys create service-acc-gcloud.json --iam-account $NAME@$PROJECT_ID.iam.gserviceaccount.com
mkdir ~/.gcloud
mv service-acc-gcloud.json ~/.gcloud


mkdir ~/.aws
cat > ~/.aws/credentials << ENDOFFILE
[default]
aws_access_key_id = $ACCESS_KEY
aws_secret_access_key = $SECRETE_ACCESS_KEY
ENDOFFILE

cat > ~/.aws/config << ENDOFFILE
[default]
region=us-east-1
ENDOFFILE

mkdir ~/.kaggle
cp Storage/kaggle.json ~/.gcloud


