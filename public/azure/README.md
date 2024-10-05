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

    ```
    az login --service-principal -u <<user>> -p <<pass>> --tenant <<tenant>>
    ```
   
    2. helm

    3. nullplatform token 

    ```
    curl --request POST \
        --url https://authz.nullplatform.io/apikey \
        --header "Authorization: Bearer $NP_TOKEN" \
        --header 'content-type: application/json' \
        --data '{
            "name": "my_token",
            "grants": [
                {
                    "nrn": "organization=<<ORGID>>",
                    "role_id": 572915741
                },
                {
                    "nrn": "organization=<<ORGID>>",
                    "role_id": 642777134
            },
            {
                    "nrn": "organization=<<ORGID>>",
                    "role_id": 515440655
                }
            ],
            "tags": {"machine":true }
        }
        '
    ```

### Assumptions

The following details makes the following assumptions.

    You have az cli configured  - az login


## Quick Setup

Optional save the backend to one of your preference

Initialize the project to pull all the modules used

    tofu init

Validate that the project is correctly setup. 

    tofu validate

Create a new workspace
    tofu workspace new $ORGANIZATION_NAME
    tofu workspace select $ORGANIZATION_NAME

Run the plan command to see all the resources that will be created

    tofu plan

When you ready, run the apply command to create the resources. 

    tofu apply

## Domain delegation

If you decided to use a nullplatform subdomain, take note of the name servers created by terraform

```
tofu output name_servers
tofu output domain_name
```

Ask nullplatform to complete the delegation by going [here](../../private/aws/dns/delegation)

## Install nullplatform helm chart

Install our chart to support log ingestion and to configure the gateway. Follow the setup of the repository [here](https://github.com/nullplatform/helm-charts)

NOTE: AKS module installs metric server for us, no need for the chart to do it again
NOTE: Update the secretName to wildcard-<<YOUR DOMAIN NAME REPLACING . by ->>

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
--set tls.secretName=wildcard-<<your_domain_name | replace "." "-">>-tls #<-- this name should be the same taken from #3
```
*NOTE*: After installing this chart it might be needed to re run tofu to create the certificate

*NOTE*: Review any other argument for configuring [logging](https://github.com/nullplatform/helm-charts/tree/main/charts/base).

5.- Ask Nullplatform team to update settings via api

```
{
  "global.domain": "<<your_domain_name>>",
  "global.useAccountSlugInCustomDomain": "false"
}
```

6.- When we create the scope Pick Kubernetes
6.1- Enable Datadog Logging from Advanced settings in the scope view and follow [this](https://docs.nullplatform.com/docs/scopes/datadog) procedure

## Cleanup the Resources we Created

When we are done testing the setup and don't require the resources created anymore, we can use the steps below to remove them. 

    1.1 tofu init

    1.2 tofu destroy

If you get errors deleting the resources, remove the .terraform folder and destroy again.

    2.1 rm -rf .terraform

    2.2 tofu destroy
