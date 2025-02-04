<h2 align="center">
    <a href="https://httpie.io" target="blank_">
        <img height="100" alt="nullplatform" src="https://nullplatform.com/favicon/android-chrome-192x192.png" />
    </a>
    <br>
    <br>
    Nullplatform IAC GCP Provider
    <br>
</h2>

# Setting up AKS with OpenTofu, Helm and Istio

### Prerequisite

Before we proceed and provision AKs Cluster using OpenTofu, there are a few commands or tools you need to have in the server where you will be creating the cluster from.

    1. gcloud

    gcloud auth login
    gcloud set project <<project>>
   
    2. helm

    3. nullplatform token 


For null tokens see [here](../docs/null_token.md).

### Assumptions

The following details makes the following assumptions.

    You have gcloud cli configured  - gcloud auth login


## Quick Setup

Optional save the backend to one of your preference

Initialize the project to pull all the modules used

    tofu init \
        -backend-config="storage_account_name=yourstorageaccount" \
        -backend-config="container_name=your-container-name" \
        -backend-config="key=path/to/terraform/state"

Validate that the project is correctly setup. 

    tofu validate

Run the plan command to see all the resources that will be created

    tofu plan \
        -var="project_id=my-orject" \
        -var="api_key=my-null-api-key" \
        -var="domain_name=poc.nullapps.io" \
        -var="nrn=organization=1:account-2" 

When you ready, run the apply command to create the resources. 

    tofu apply \
        -var="project_id=my-orject" \
        -var="api_key=my-null-api-key" \
        -var="domain_name=poc.nullapps.io" \
        -var="nrn=organization=1:account-2" 

## Domain delegation

If you decided to use a nullplatform subdomain, take note of the name servers created by terraform, provide Nullplatform team with the values for the domain delegation

## Cleanup the Resources we Created

When we are done testing the setup and don't require the resources created anymore, we can use the steps below to remove them. 

    1.1     
    
    tofu init \
        -backend-config="storage_account_name=yourstorageaccount" \
        -backend-config="container_name=your-container-name" \
        -backend-config="key=path/to/terraform/state"

    1.2 tofu destroy
