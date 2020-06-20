# Cloud Computing

## Requirements

* Google Cloud Account
* AWS account
* Linux
* Python3
* [kubectl]{https://kubernetes.io/docs/tasks/tools/install-kubectl/}
* [Docker]{https://docs.docker.com/get-docker/} 
* [Docker-Machine]{https://docs.docker.com/machine/install-machine/}

## Install Google SDK

Tutorial here: <https://cloud.google.com/sdk/docs/downloads-apt-get>

First we add the Cloud SDK distribution URI with:


`echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list`

`sudo apt-get install apt-transport-https ca-certificates gnupg`

We import the Google Cloud public key

`curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -`

Update and install the Cloud SDK.

`sudo apt-get update && sudo apt-get install google-cloud-sdk`

You should now have it installed. To start using it you should now connect to the account you are going to use.

`gcloud init`

You will be asked about which project you will want to connect to. 

You should create a new one, by running the folowing command

```
gcloud projects create "[PROJECT_ID]" \
  --name="Example Project"
```

or use the GUI console.

If you create a project with a non-default region or zone, make sure to check region vars 
are correctly configured thorough out the project.

### Activate APIs

Make sure billing is activated for your project and activate required API's

#### GUI

1. Go to the Google Cloud Platform.
2. Select your project on the top-left corner.
2. Search for API's on the list and enable them.

* Compute Engine API
* Translation API
* Kubernetes Engine
* Cloud SQL
* CLoud Storage
* Cloud Container Registry
* Filestore API

#### CLI

```
gcloud services enable [API_URL] --async
gcloud services enable file.googleapis.com --async
gcloud services enable sqladmin --async
gcloud services enable container.googleapis.com --async
gcloud services enable compute.googleapis.com --async
gcloud services enable translate.googleapis.com --async
gcloud services enable kubernetes.googleapis.com --async
```

### Make a service account

First start by creating it with `gcloud iam service-accounts create [NAME]`.

We can then grant permissions to this service-account, for now it is owner, though it should be carefully considered if that is the case.

`gcloud projects add-iam-policy-binding [PROJECT_ID] --member "serviceAccount:[NAME]@[PROJECT_ID].iam.gserviceaccount.com" --role "roles/owner"`

## Install AWS CLI

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/installdir
```

### Install Kaggle CLI

```
pip3 install kaggle
```

## Configure Credentials

You can setup all credentials by running inside the main project dir

`bash Scripts/set_credentials.sh`

or mannualy by following this instructions.

### Generate the Google's JSON key file

```
gcloud iam service-accounts keys create service-acc-gcloud.json --iam-account [NAME]@[PROJECT_ID].iam.gserviceaccount.com
mkdir ~/.gcloud
mv service-acc-gcloud.json ~/.gcloud
```

Make sure the json file is inside the ~/.gcloud folder

### Setup AWS credentials file

```
mkdir ~/.aws
cat > ~/.aws/credentials << ENDOFFILE
[default]
aws_access_key_id = [ACCESS_KEY]
aws_secret_access_key = [SECRET_ACCESS_KEY]
ENDOFFILE
cat > ~/.aws/config << ENDOFFILE
[default]
region=us-east-1
ENDOFFILE
```

### Setup Kaggle credentials file

```
mkdir ~/.kaggle
cp Storage/kaggle.json ~/.kaggle
```






