<h2 align="center">
    <a href="https://httpie.io" target="blank_">
        <img height="100" alt="nullplatform" src="https://nullplatform.com/favicon/android-chrome-192x192.png" />
    </a>
    <br>
    <br>
    Nullplatform IAC Provider Blueprints
    <br>
</h2>

# Purpose

This placeholder contains working examples of configurations that will allow to create infrastructure needed to test Nulplatform organized by supported Cloud Providers

# Index Content

```
.
├── aws
└── azure
```

## Global prerequitites

1. Have a nullplatform organization
2. Have a nullplatform account

## Tools prerequisites
Before we proceed and provision resources using Terraform, there are a tools you need to have in the server where you will be creating any resource.

- OpenTofu
- Helm cli

## Suppored providers

- [AWS](./aws/README.md)
- [Azure](./azure/README.md)
- [GCP](./gcp/README.md)
