#! /bin/bash

gsutil rm -r gs://$GCLOUD_BUCKET

rm Web-APP/sfdata/fixtures/sdmanager_db.json