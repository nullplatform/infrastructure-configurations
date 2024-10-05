# Introduction
Before reading this helm chart I want you to let you know: I hate it

## Why
As we want an smooth interacion while creating and configuring the resource dependencies for Nullplatform POC, we wanted to make the steps as little and automatic as possible. Given said that the approach of running OpenTofu seemed suitable for many reasons like being an industry standard.

The problem with CRD is that Kubernetes provider for tofu does not allow to create the cluster at same moment of applying manifests (See [here](https://github.com/hashicorp/terraform-provider-kubernetes-alpha/issues/199) for further details).

Considering alternatives to execute terraform the more suitable was create an small helm chart locally setup so that is easy for tofu to pick it up and use the provider configured after the cluster was created.

## Test the template

```
helm
 template ./chart --set subscriptionId=1234 --set resourceGroupName=david --set hostedZoneName=pedro.com --set clientId=1233
 ```

 Will render the template and produce a manifest ready to use (use this only for testing changes on the CRDs, to apply just use tofu)
