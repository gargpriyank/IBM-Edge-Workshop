# Deploy IEAM 4.2 agent on edge node

1) Log in to your edge node with root privileges. Install [docker](https://www.ibm.com/links?url=https%3A%2F%2Fdocs.docker.com%2Fget-docker%2F)
and run below commands to add a new user and group and switch log in to new user.
> Note: For edge node only Linux operating system is supported.

```markdown
useradd -s /bin/bash -m -d /home/ibm-workshop -G sudo ibm-workshop  # You are free to choose any user name and group
usermod -g users ibm-workshop
usermod -a -G docker ibm-workshop
passwd ibm-workshop
su - ibm-workshop
```

2) Export all the necessary environment variables.

```markdown
export CLUSTER_URL=https://$(oc get cm management-ingress-ibmcloud-cluster-info -o jsonpath='{.data.cluster_ca_domain}')
export CLUSTER_USER=$(oc -n ibm-common-services get secret platform-auth-idp-credentials -o jsonpath='{.data.admin_username}' | base64 --decode)
export CLUSTER_PW=$(oc -n ibm-common-services get secret platform-auth-idp-credentials -o jsonpath='{.data.admin_password}' | base64 --decode)
export HZN_EXCHANGE_USER_AUTH=iamapikey:<api-key-generated-above>
export HZN_EXCHANGE_URL=<ieam-management-hub-url>/edge-exchange/v1  # <ieam-management-hub-url> is same as CLUSTER_URL
export HZN_FSS_CSSURL=<ieam-management-hub-url>/edge-css/   # <ieam-management-hub-url> is same as CLUSTER_URL
export HZN_ORG_ID=sandbox-edge-workshop-ieam-cluster    # This should be same organization id you created while deploying IEAM hub
```

3) Create **workspace** directory and copy the files **agent-install.sh** and **agent-uninstall.sh** generated in [IBM Edge Admin Workshop](edge-workshop-admin.md) into **workspace** directory.

```markdown
mkdir /home/ibm-workshop/workspace
cd /home/ibm-workshop/workspace
cp <your_home_dir>/workspace /home/ibm-workshop/workspace   # <your_home_dir> is in your local system
```

4) Deploy IEAM agent, deploy sample helloworld service and register node.

```markdown
sudo -s -E ./agent-install.sh -i 'css:' -p IBM/pattern-ibm.helloworld -w '*' -T 120
```
