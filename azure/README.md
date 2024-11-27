<h2 align="center">
    <a href="https://httpie.io" target="blank_">
        <img height="100" alt="nullplatform" src="https://nullplatform.com/favicon/android-chrome-192x192.png" />
    </a>
    <br>
    <br>
    Nullplatform IAC Azure Provider
    <br>
</h2>

# Setting up AKS with OpenTofu, Helm and Istio

### Prerequisite

Before we proceed and provision AKs Cluster using OpenTofu, there are a few commands or tools you need to have in the server where you will be creating the cluster from.

    1. azcli

    az login --service-principal -u <<user>> -p <<pass>> --tenant <<tenant>>
   
    2. helm

    3. nullplatform token 


For null tokens see [here](../docs/null_token.md).

### Assumptions

The following details makes the following assumptions.

    You have az cli configured  - az login


## Quick Setup

Optional save the backend to one of your preference

Initialize the project to pull all the modules used

    tofu init \
        -backend-config="storage_account_name=yourstorageaccount" \
        -backend-config="container_name=your-container-name" \
        -backend-config="key=path/to/terraform/state"

Validate that the project is correctly setup. 

    tofu validate

Create a new workspace
    tofu workspace new $ORGANIZATION_NAME
    tofu workspace select $ORGANIZATION_NAME

Run the plan command to see all the resources that will be created

    tofu plan \
        -var="azure_subscription_id=12345678-1234-1234-1234-123456789abc" \
        -var="azure_resource_group_name=myResourceGroup" \
        -var="azure_vnet={name=\"myVnet\", address_space=[\"10.0.0.0/16\"]}" \
        -var="azure_credential={client_id=\"client-id\", client_secret=\"client-secret\"}" \
        -var="azure_tenant_id=abcdef12-3456-7890-abcd-ef1234567890" \
        -var="location=eastus" \
        -var="domain_name=example.com" \
        -var="cluster_name=myAKSCluster" \
        -var="organization=myOrganizationSlug" \
        -var="organization_id=org-123456" \
        -var="account=myAccountSlug" \
        -var="account_id=acc-123456" \
        -var="np_api_key=my-api-key" \
        -var="namespace=myNamespace"

When you ready, run the apply command to create the resources. 

    tofu apply \
        -var="azure_subscription_id=12345678-1234-1234-1234-123456789abc" \
        -var="azure_resource_group_name=myResourceGroup" \
        -var="azure_vnet={name=\"myVnet\", address_space=[\"10.0.0.0/16\"]}" \
        -var="azure_credential={client_id=\"client-id\", client_secret=\"client-secret\"}" \
        -var="azure_tenant_id=abcdef12-3456-7890-abcd-ef1234567890" \
        -var="location=eastus" \
        -var="domain_name=example.com" \
        -var="cluster_name=myAKSCluster" \
        -var="organization=myOrganizationSlug" \
        -var="organization_id=org-123456" \
        -var="account=myAccountSlug" \
        -var="account_id=acc-123456" \
        -var="np_api_key=my-api-key" \
        -var="namespace=myNamespace"

## Domain delegation

If you decided to use a nullplatform subdomain, take note of the name servers created by terraform, provide Nullplatform team with the values for the domain delegation

## Install nullplatform helm chart

Install our chart to support log ingestion and to configure the gateway. Follow the setup of the repository [here](https://github.com/nullplatform/helm-charts)

NOTE: AKS module installs metric server for us, no need for the chart to do it again

1.- Login into azure
```
az account set --subscription your_subscription
az login
```
2.- Configure kubectl with the context of the aks cluster created
```
az aks get-credentials --admin --resource-group your_resource_group --name your_cluster
```
3.- Grab the tls certificate secret name
```
kubectl get secrets -n gateways
```
4.- Install the chart
```
helm install nullplatform-base nullplatform/nullplatform-base \
--set metricsServer.enabled=false \
--set global.provider=aks \
--set tls.secretName=wildcard-domain-poc-tls #<-- this name should be the same taken from #3
```
*NOTE*: After installing this chart it might be needed to re run tofu to create the certificate

*NOTE*: Review any other argument for configuring [logging](https://github.com/nullplatform/helm-charts/tree/main/charts/base).

5.- When we create the scope Pick Kubernetes
5.1- Enable Datadog Logging from Advanced settings in the scope view and follow [this](https://docs.nullplatform.com/docs/scopes/datadog) procedure

## Cleanup the Resources we Created

When we are done testing the setup and don't require the resources created anymore, we can use the steps below to remove them. 

    1.1     
    
    tofu init \
        -backend-config="storage_account_name=yourstorageaccount" \
        -backend-config="container_name=your-container-name" \
        -backend-config="key=path/to/terraform/state"

    1.2 tofu destroy
