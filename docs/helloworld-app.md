## Prerequisites

- IEAM agent and `hzn` CLI are installed on the edge node.
- **helloworld** service has already been published into IEAM.

# Register edge node and deploy sample Hello World edge service

1) Log in to your edge node using `bash` with the user id `ibm-workshop`. Get the required helloworld node policy file.

```markdown
wget https://raw.githubusercontent.com/open-horizon/examples/master/edge/services/helloworld/horizon/node.policy.json
```

2) Export all the necessary environment variables.

```markdown
export HZN_EXCHANGE_USER_AUTH=iamapikey:<api-key-generated-in-ieam-installation>
export HZN_EXCHANGE_URL=<ieam-management-hub-ingress>/edge-exchange/v1  # <ieam-management-hub-ingress> is same as CLUSTER_URL, exported in IEAM Installment
export HZN_FSS_CSSURL=<ieam-management-hub-ingress>/edge-css/   # <ieam-management-hub-ingress> is same as CLUSTER_URL, exported in IEAM installation
export HZN_ORG_ID=sandbox-edge-workshop-ieam-cluster    # This should be same organization id you created while Installing IEAM hub
```

3) Register your edge node with IEAM using helloworld policy.

```markdown
hzn register --policy node.policy.json
```

4) When the registration completes, use the following command to review the Node policy.

```markdown
hzn policy list
```

5) Validate the helloworld service container is running in `docker` on the edge node.

```markdown
docker ps
```

6) Unregister your edge node which will also stop the helloworld service.

```markdown
hzn unregister -Df
```

## Next Step

- [Edge Workshop Manufacturing Use Case](edge-manufacturing-usecase.md)