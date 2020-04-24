#! /bin/bash

gsutil mb -b on -l us-east1 gs://$GCLOUD_BUCKET/

kaggle datasets download -d cloudcomputing17/rest-api-data

unzip rest-api-data.zip

gsutil cp DummyData.csv gs://$GCLOUD_BUCKET/dataset

mv sdmanager_db.json Web-APP/sfdata/fixtures/

rm rest-api-data.zip
rm DummyData.csv


