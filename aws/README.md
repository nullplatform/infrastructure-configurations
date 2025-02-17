<h2 align="center">
    <a href="https://httpie.io" target="blank_">
        <img height="100" alt="nullplatform" src="https://nullplatform.com/favicon/android-chrome-192x192.png" />
    </a>
    <br>
    <br>
    Nullplatform IAC AWS Provider
    <br>
</h2>

# Setting up EKS with OpenTofu, Helm and a Load balancer

### Prerequisite

Before we proceed and provision EKS Cluster using OpenTofu, there are a few commands or tools you need to have in the server where you will be creating the cluster from.

    1. awscli
   
    2. kubectl

    3. null token

For null tokens see [here](../docs/null_token.md).

### Assumptions

The following details makes the following assumptions.

    You have aws cli configured  - aws configure

    You have created s3 bucket that will act as the backend of the project. 

## Quick Setup

Update the `backend.tf` and update the s3 bucket and the region of your s3 bucket. Update the profile if you are not using the default profile. 

Update the `variables.tf` profile and region variables if you are not using the default profile or region used. 

Initialize the project to pull all the modules used

    tofu init \
        -backend-config="bucket=your-s3-bucket-name" \
        -backend-config="key=path/to/terraform/state" \
        -backend-config="region=us-west-2" \
        -backend-config="encrypt=true" \
        -backend-config="dynamodb_table=your-dynamodb-table"

Validate that the project is correctly setup. 

    tofu validate

Run the plan command to see all the resources that will be created

    tofu plan \
        -var="domain_name=mycustomdomain.io" \
        -var="api_key=your-api-key-here" \
        -var="organization=myorganization" \
        -var="account=myaccount" \
        -var="namespace=mynamespace" \
        -var="region=us-east-1"

When you ready, run the apply command to create the resources. 

    tofu apply \
        -var="domain_name=mypoc.nullapps.io" \
        -var="api_key=your-api-key-here" \
        -var="organization=myorganization" \
        -var="account=myaccount" \
        -var="namespace=mynamespace" \
        -var="region=us-east-1"


## Setup Steps. 

A VPC will be created with three Public Subnets and three Private Subnets in three different Availability Zones. Traffic from Private Subnets will route through the NAT Gateway and traffic from Public Subnets will route through the Internet Gateway.
Kubernetes Cluster Nodes will be created as part of Auto-Scaling groups and will reside in Private Subnets. The Application Load balancer will be created in the Public Subnets.

## Cleanup the Resources we Created

When we are done testing the setup and don't require the resources created anymore, we can use the steps below to remove them. 


    tofu init \
        -backend-config="bucket=your-s3-bucket-name" \
        -backend-config="key=path/to/terraform/state" \
        -backend-config="region=us-west-2" \
        -backend-config="encrypt=true" \
        -backend-config="dynamodb_table=your-dynamodb-table"
    
    tofu destroy \
        -var="domain_name=mypoc.nullapps.io" \
        -var="api_key=your-api-key-here" \
        -var="organization=myorganization" \
        -var="account=myaccount" \
        -var="namespace=mynamespace" \
        -var="region=us-east-1"


If you get errors deleting the resources, remove the .terraform folder and destroy again.

    2.1 rm -rf .terraform

    2.2 tofu destroy
