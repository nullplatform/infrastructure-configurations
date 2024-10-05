#!/bin/bash

# Check if at least one argument is provided
if [ $# -lt 3 ]; then
  echo "Usage: $0 DOMAIN_NAME ORGANIZATION NS1 NS2 NS3 NS4"
  echo "Example: ./create_delegation.sh bombo.nullapps.io bombo ns-1213.awsdns-23.org. ns-1858.awsdns-40.co.uk. ns-373.awsdns-46.com. ns-825.awsdns-39.net."
  exit 1
fi



export TF_VAR_domain_name=$1
export TF_VAR_organization=$2
shift 2


# Capture the remaining arguments as tags (Terraform array)
NAME_SERVERS_ARGS=("$@")

# Convert the tags array into a comma-separated string within brackets for Terraform
NAME_SERVERS_ARGS=$(printf "\"%s\"," "${NAME_SERVERS_ARGS[@]}")
export TF_VAR_name_servers="[${NAME_SERVERS_ARGS%,}]" # Remove the trailing comma

rm -rf .terraform
tofu init
tofu apply
rm -rf .terraform

