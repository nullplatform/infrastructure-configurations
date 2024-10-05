<h2 align="center">
    <a href="https://httpie.io" target="blank_">
        <img height="100" alt="nullplatform" src="https://nullplatform.com/favicon/android-chrome-192x192.png" />
    </a>
    <br>
    <br>
    Nullplatform IAC Configuration Blueprints
    <br>
</h2>

# Setting up EKS with Terraform, Helm and a Load balancer

### Prerequisite

Before we proceed and provision EKS Cluster using Terraform, there are a few commands or tools you need to have in the server where you will be creating the cluster from.

    1. awscli
   
    2. go

    3. Terraform

    4. kubectl

    5. helm

### Assumptions

The following details makes the following assumptions.

    You have aws cli configured  - aws configure

    You have created s3 bucket that will act as the backend of the project. 

## Quick Setup

Clone the repository:

    git clone git@github.com:nullplatform/infrastructure-configurations.git

Change directory;

    cd infrastructure-configurations

Update the `backend.tf` and update the s3 bucket and the region of your s3 bucket. Update the profile if you are not using the default profile. 

Update the `variables.tf` profile and region variables if you are not using the default profile or region used. 


Initialize the project to pull all the modules used

    terraform init

Validate that the project is correctly setup. 

    terraform validate

Run the plan command to see all the resources that will be created

    terraform plan

When you ready, run the apply command to create the resources. 

    terraform apply

## Setup Steps. 

A VPC will be created with three Public Subnets and three Private Subnets in three different Availability Zones. Traffic from Private Subnets will route through the NAT Gateway and traffic from Public Subnets will route through the Internet Gateway.
Kubernetes Cluster Nodes will be created as part of Auto-Scaling groups and will reside in Private Subnets. The Application Load balancer will be created in the Public Subnets.

## Cleanup the Resources we Created

When we are done testing the setup and don't require the resources created anymore, we can use the steps below to remove them. 

    1.1 terraform init

    1.2 terraform destroy

If you get errors deleting the resources, remove the .terraform folder and destroy again.

    2.1 rm -rf .terraform

    2.2 terraform destroy
