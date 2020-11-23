# IBM Edge Application Manager (IEAM) 4.2 Automation

This project contains the bash script to auomate the deployment of the IEAM 4.2 hub.

## Content

- [Prerequisites](#prerequisites)
- [Deploy IEAM 4.2 and extract edge agent files](#deploy-ieam-42-and-extract-edge-agent-files)

### Prerequisites

The requirements are documented in the 
[Environment Setup](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment). It includes:

- Have an IBM Cloud account with required privileges
- [Install IBM Cloud CLI](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#install-ibm-cloud-cli)
- [Log in to IBM Cloud with the CLI](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#login-to-ibm-cloud)
- Install the tools such as:
  - [make](https://www.gnu.org/software/make/)
  - [IBM Cloud Pak CLI (cloudctl) and OpenShift client CLI (oc)](https://www.ibm.com/support/knowledgecenter/SSFKVV_4.2/cli/cloudctl_oc_cli.html)
  - [docker](https://www.ibm.com/links?url=https%3A%2F%2Fdocs.docker.com%2Fget-docker%2F)

## Deploy IEAM 4.2 and extract edge agent files

1) Log in to your local linux/mac box with admin privileges. 
Retrieve and copy the [entitlement key](https://myibm.ibm.com/products-services/containerlibrary) and set the environment 
variable `IBM_CP_ENTITLEMENT_KEY`.

```markdown
export IBM_CP_ENTITLEMENT_KEY=<Your_IBM_Cloud_Pak_Entitlement_Key>
```

2) Numbered Create `workspace` directory in your local linux/mac box. Download **iac-ibm-openshift-ieam** project code.

```markdown
mkdir <your_home_dir>/workspace
cd <your_home_dir>/workspace
git clone https://github.com/gargpriyank/iac-ibm-openshift-ieam.git
cd iac-ibm-openshift-ieam
chmod +x script/*.sh
```
3) Log in to OpenShift cluster and execute the shell script `ieam-deploy.sh`. This will deploy the Common Services and IEAM and create IEAM hub.
   
```markdown
oc login --token=<openshift_cluster_token> --server=<openshift_server_url>
./script/ieam-deploy.sh
```
   
4) After the above script is executed successfully, run below command and make sure that all the pods are either in **Running** 
or **Completed** status.

```markdown
oc get pods -n ibm-common-services
```

5) Download the IBM Edge Application Manager 4.2 Agent package 
from [IBM Passport Advantage](https://www.ibm.com/support/knowledgecenter/SSFKVV_4.2/hub/part_numbers.html?view=kc) and save it in the directory 
`<your_home_dir/workspace`. Set the environment variable `IEAM_PACKAGE_FILE_NAME` with the downloaded file name 
and execute the shell script `install_hzn_cli.sh`. This will install the horizon CLI.
> **Note: Update `install_hzn_cli.sh` file as per your operating system. It supports Linux and macOS. By default, it is configured for macOS.

```markdown
export IEAM_PACKAGE_FILE_NAME=<downloaded_file_name>
export FIRST_ORG_ID=sandbox-edge-workshop-ieam-cluster   # Feel free to choose any organization id.
./script/install_hzn_cli.sh
```

6) The environment variables in below will set the IEAM hub cluster URL, User Name and Password. You can log in to IEAM hub using these credentials.

```markdown
export CLUSTER_URL=https://$(oc get cm management-ingress-ibmcloud-cluster-info -o jsonpath='{.data.cluster_ca_domain}')
export CLUSTER_USER=$(oc -n ibm-common-services get secret platform-auth-idp-credentials -o jsonpath='{.data.admin_username}' | base64 --decode)
export CLUSTER_PW=$(oc -n ibm-common-services get secret platform-auth-idp-credentials -o jsonpath='{.data.admin_password}' | base64 --decode)
```

7) Extract the IEAM edge agent files to install it on each node.

```markdown
./script/extract_edge_node_files.sh
```

8) Log in to IEAM management hub via `cloudctl` and create an apikey. Note down the apikey for future use.

```markdown
cloudctl login -a $CLUSTER_URL -u $CLUSTER_USER -p $CLUSTER_PW --skip-ssl-validation
cloudctl iam api-key-create edge-app-apikey -d "API key to connect to IEAM hub" # You are free to choose any name for apikey
```

9) Locate the files **agent-install.sh** and **agent-uninstall.sh** as per your operating system. You will need these files to deploy IEAM agent in
the edge node.

- Linux:

```markdown
ls /usr/horizon/bin/agent-install.sh
ls /usr/horizon/bin/agent-uninstall.sh
```

- macOS:

```markdown
ls /usr/local/bin/agent-install.sh
ls /usr/local/bin/agent-uninstall.sh
```