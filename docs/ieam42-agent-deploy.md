# IBM Edge Application Manager (IEAM) 4.2 Agent - Installation

This page contains the bash commands to automate the deployment of the IEAM 4.2 agent.

## Content

- [Prerequisites](#prerequisites)
- [Install IEAM 4.2 agent on edge node](#install-ieam-42-agent-on-the-edge-node)

### Prerequisites

Install the following tools:
- [make](https://www.gnu.org/software/make/)
- [docker](https://www.ibm.com/links?url=https%3A%2F%2Fdocs.docker.com%2Fget-docker%2F)

## Install IEAM 4.2 agent on the edge node

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
export HZN_EXCHANGE_USER_AUTH=iamapikey:<api-key-generated-in-ieam-installation>
export HZN_EXCHANGE_URL=<ieam-management-hub-ingress>/edge-exchange/v1  # <ieam-management-hub-ingress> is same as CLUSTER_URL, exported in IEAM Installment
export HZN_FSS_CSSURL=<ieam-management-hub-ingress>/edge-css/   # <ieam-management-hub-ingress> is same as CLUSTER_URL, exported in IEAM installation
export HZN_ORG_ID=sandbox-edge-workshop-ieam-cluster    # This should be same organization id you created while Installing IEAM hub
```

3) Create **workspace** directory and copy the files **agent-install.sh** and **agent-uninstall.sh** generated above into **workspace** directory.

```markdown
mkdir /home/ibm-workshop/workspace
cd /home/ibm-workshop/workspace
cp <your_home_dir>/workspace /home/ibm-workshop/workspace   # <your_home_dir> is in your local system
```

4) Install IEAM agent, deploy sample helloworld service and register node. This will create an agreement in between edge agent on the edge node 
   and the agbot on the IEAM.

```markdown
sudo -s -E ./agent-install.sh -i 'css:' -p IBM/pattern-ibm.helloworld -w '*' -T 120
```

5) Validate the service container is running in `docker` on the edge node.

```markdown
docker ps
```

6) Unregister your edge node which will also stop the helloworld service.

```markdown
hzn unregister -Df
```

## Next Step

- [Edge Business Use Case](edge-usecase.md)