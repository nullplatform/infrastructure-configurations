# Create Nullplatform apikey

In order to create api keys, you have to have you own api key created and provided by us, but to create further api keys to setup your account, you need to create a new one with roles to operate the providers.

See [here](https://docs.nullplatform.com/docs/authorization/api_keys) for more information about the role ids and their usage

```bash
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
