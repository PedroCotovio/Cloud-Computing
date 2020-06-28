#! /bin/bash

gsutil -m rm -r gs://$GCLOUD_BUCKET
gsutil mb -b on -l $GCP_REGION gs://dataproc-staging-us-central1-127237410780-kbeanwbn