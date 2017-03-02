#!/bin/bash

ACCOUNT=personal
ENVIRON=salmond.ca

terraform remote config -backend=s3 -backend-config="bucket=plumbing-tf-state" -backend-config="key=$ENVIRON/terraform.tfstate" -backend-config="region=us-east-1" -backend-config="profile=$ACCOUNT"

echo "AWS account: $ACCOUNT, active terraform environment: $ENVIRON"
