#! /bin/bash

gsutil mb -b on -l us-east1 gs://$GCLOUD_BUCKET/

kaggle datasets download -d cloudcomputing17/rest-api-data

unzip rest-api-data.zip

gsutil cp DummyData.csv gs://$GCLOUD_BUCKET/dataset.csv
gsutil cp MANUF_IBS.csv gs://$GCLOUD_BUCKET/MANUF_IBS.csv
gsutil cp sfdata_classes.csv gs://$GCLOUD_BUCKET/sfdata_classes.csv
gsutil cp sfdata_constrains.csv gs://$GCLOUD_BUCKET/sfdata_constrains.csv
gsutil cp sfdata_category.csv gs://$GCLOUD_BUCKET/sfdata_category.csv

rm rest-api-data.zip

rm DummyData.csv
rm MANUF_IBS.csv
rm sfdata_classes.csv
rm sfdata_constrains.csv
rm sfdata_category.csv


