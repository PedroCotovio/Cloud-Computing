#! /bin/bash

gsutil mb -b on -l us-east1 gs://$GCLOUD_BUCKET/

gsutil cp sdmanager_db.json gs://$GCLOUD_BUCKET/fixture_dirs