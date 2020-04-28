#!/usr/bin/env bash
set -euxi

#terraform workspace select dev || terraform workspace new dev
terraform plan  -refresh=true -out="plan.tfplan"
terraform apply -input=false -refresh=true "plan.tfplan"
