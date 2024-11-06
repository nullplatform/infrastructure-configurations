<h2 align="center">
    <a href="https://httpie.io" target="blank_">
        <img height="100" alt="nullplatform" src="https://nullplatform.com/favicon/android-chrome-192x192.png" />
    </a>
    <br>
    <br>
    Nullplatform IAC DNS Delegation
    <br>
</h2>

# Purpose

This procedure will help you complete the DNS delegation using Route53 through OpenTofu. This step is only required if the configuration used in public consisted on using a nullapps.io domain

### Prerequisite

Before we proceed and provision AKs Cluster using OpenTofu, there are a few commands or tools you need to have in the server where you will be creating the cluster from.

    1. awscli
    2. OpenTofu

### Assumptions

The following details makes the following assumptions.

    You have aws cli configured


## Quick Setup

Optional save the backend to one of your preference

Initialize the project to pull all the modules used

    tofu init

Validate that the project is correctly setup. 

    tofu validate

Run the plan command to see all the resources that will be created

    tofu plan

When you ready, run the apply command to create the resources. 

    tofu apply


## Domain delegation

If you decided to use a nullplatform subdomain, take note of the name servers created by terraform

```
tofu output name_servers
```

Ask nullplatform to complete the delegation by going [here](../../private/aws/dns/delegation)

## Cleanup the Resources we Created

When we are done testing the setup and don't require the resources created anymore, we can use the steps below to remove them. 

    1.1 tofu init

    1.2 tofu destroy

If you get errors deleting the resources, remove the .terraform folder and destroy again.

    2.1 rm -rf .terraform

    2.2 tofu destroy
