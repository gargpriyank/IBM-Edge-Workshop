# IBM Edge Sandbox Automation

## Edge computing

Edge computing is a distributed computing model and open information technology (IT) architecture. 
This paradigm drives computer data storage towards a location where it’s needed and enables mobile computing and Internet of Things (IoT) 
technologies.

Edge computing drives applications, data and computing power services away from centralized points and towards places that are closer to the user. 
This data is processed by a device or by a local computer or server instead of being transmitted to a data center.

The computation in edge computing is either largely or entirely performed on distributed device nodes. Edge computing focuses on any application 
that needs to be closer to the source of the action where distributed systems technology interacts with the physical world. 
Although it may interact with a centralized cloud, edge computing doesn’t need contact with a centralized cloud.

## Content

This repository contains the terraform code to provision Red Hat OpenShift Classic cluster, IBM Cloudant database, 
IBM Event Streams (Kafka), Bare Metal Server, Virtual Server, IBM Cloudant database, 
and IBM Event Streams (enable_event_streams_service). 
This repository will deploy the IBM Edge Application Manager and provide the guidance to deploy edge application.

Below is the typical network architecture of the IBM Edge components produced by this repository code.

![Network Architecture](https://github.com/gargpriyank/iac-ibm-openshift-ieam/blob/main/images/NetworkArchitecture.png)

## Provision OpenShift Classic cluster

- [General Requirements](#general-requirements)
- [How to use with Terraform](#how-to-use-with-terraform)
- [How to use with Schematics](#how-to-use-with-schematics)
- [How to use IBM Cloud Registry](#how-to-use-ibm-cloud-registry)
- [Project Validation](#project-validation)

### General Requirements

Same for every pattern, the requirements are documented in the 
[Environment Setup](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment). It includes:

- Have an IBM Cloud account with required privileges
- [Install IBM Cloud CLI](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#install-ibm-cloud-cli)
- [Install the IBM Cloud CLI Plugins](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#ibm-cloud-cli-plugins) 
  `infrastructure-service`, `schematics` and `container-registry`.
- [Login to IBM Cloud with the CLI](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#login-to-ibm-cloud)
- [Install Terraform](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#install-terraform)
- [Configure access to IBM Cloud](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#configure-access-to-ibm-cloud) for
  Terraform and the IBM Cloud CLI
- [Install IBM Cloud Terraform Provider](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#configure-access-to-ibm-cloud)
- Install some utility tools such as:
  - [jq](https://stedolan.github.io/jq/download/)
  - [IBM Cloud Pak CLI (cloudctl) and OpenShift client CLI (oc)](https://www.ibm.com/support/knowledgecenter/SSFKVV_4.2/cli/cloudctl_oc_cli.html)
  - [docker](https://www.ibm.com/links?url=https%3A%2F%2Fdocs.docker.com%2Fget-docker%2F)

> The IBM Cloud Terraform provider must be version 1.8.0 or later. This example is using Terraform version 0.12.0.

Executing these commands you are validating part of these requirements:

```bash
ibmcloud --version
ibmcloud plugin show infrastructure-service | head -3
ibmcloud plugin show schematics | head -3
ibmcloud target
terraform version
ls ~/.terraform.d/plugins/terraform-provider-ibm_*
echo $IC_API_KEY
```

If you have an API Key but is not set, neither have the JSON file when it was created, you must recreate the key. Delete the old one if won't be in
use anymore.

```bash
# Delete the old one, if won't be in use anymore
ibmcloud iam api-keys       # Identify your old API Key Name
ibmcloud iam api-key-delete NAME

# Create a new one and set it as environment variable
ibmcloud iam api-key-create TerraformKey -d "API Key for Terraform" --file ~/ibm_api_key.json
export IC_API_KEY=$(grep '"apikey":' ~/ibm_api_key.json | sed 's/.*: "\(.*\)".*/\1/')
```

### How to use with Terraform

A sample `terraform.tfvars` file is provided with this example. This file creates resources in Dallas region in single zone. A multi-zone
sample file is available in **multizone** directory.

> **Note: Please replace the values of the variables as per your project requirement. It is advisable to not to commit `terraform.tfvars` file in any
> repository since it may contain sensitive information like password.**

```hcl-terraform
project_name                             = "iac-example"
environment                              = "dev"
resource_group                           = "iac-example-rg"
region                                   = "us-south"
additional_zone_names                    = []
public_vlan_id                           = "123456"
private_vlan_id                          = "234566"
enable_public_service_endpoint           = "true"
enable_private_service_endpoint          = "true"
additional_zone_public_service_endpoint  = []
additional_zone_private_service_endpoint = []
...
```

Set the api key variables **iaas_classic_username** and **iaas_classic_api_key**. Use below command to get the value of VLAN variables
**public_vlan_id**, **private_vlan_id**, **additional_zone_public_service_endpoint** and **additional_zone_private_service_endpoint**.

```bash
ibmcloud sl vlan list -d <zone_name>
```

Execute below Terraform commands to provision the infrastructure:

```bash
terraform init
terraform plan
terraform apply
```

Optional: In case you want to clean up the infrastructure, execute below Terraform command: 

```bash
terraform destroy
```

### How to use with Schematics

Schematics delivers Terraform as a Service. 

A sample `workspace-workshop.json` file is provided with this example. This file creates resources in Dallas region in single zone. A multi-zone
sample file is available in **multizone** directory.

> **Note: Please replace the values of the variables as per your project requirement. It is advisable to not to commit `workspace-workshop.json` file in
> any repository since it may contain sensitive information like password.**

```json
...
"template_repo": {
    "url": "https://github.com/gargpriyank/iac-ibm-openshift-ieam"
  },
  "template_data": [
    {
      "folder": ".",
      "type": "terraform_v0.12",
      "variablestore": [
        {
          "name": "project_name",
          "value": "sandbox-edge",
          "type": "string"
        },
        {
          "name": "environment",
          "value": "workshop",
          "type": "string"
        },
        {
          "name": "resource_group",
          "value": "sandbox-edge-workshop-rg",
          "type": "string"
        },
        {
          "name": "region",
          "value": "us-south",
          "type": "string"
        },
        {
          "name": "datacenter",
          "value": "dal12",
          "type": "string"
        },
        {
          "name": "machine_type",
          "value": "b3c.8x32",
          "type": "string"
        },
        {
          "name": "additional_zone_names",
          "value": "[]",
          "type": "list(string)"
        },
        {
          "name": "public_vlan_id",
          "value": "2852297",
          "type": "string"
        },
        {
          "name": "private_vlan_id",
          "value": "2852299",
          "type": "string"
        },
        {
          "name": "additional_zone_public_service_endpoint",
          "value": "[]",
          "type": "list(string)"
        },
...
```      

Set the api key variables **iaas_classic_username** and **iaas_classic_api_key**. Use below command to get the value of VLAN variables
**public_vlan_id**, **private_vlan_id**, **additional_zone_public_service_endpoint** and **additional_zone_private_service_endpoint**.

```bash
ibmcloud sl vlan list -d <zone_name>
```

Execute the below Schematics commands:

```bash
# Create workspace:
ibmcloud schematics workspace list
ibmcloud schematics workspace new --file workspace-workshop.json #Create dev environment workspace.
ibmcloud schematics workspace list          # Identify the workspace_ID

# Create plan: 
ibmcloud schematics plan --id $WORKSPACE_ID  # Identify the Activity_ID
ibmcloud schematics logs --id $WORKSPACE_ID --act-id Activity_ID

# Apply plan:
ibmcloud schematics apply --id $WORKSPACE_ID # Identify the Activity_ID
ibmcloud schematics logs  --id $WORKSPACE_ID --act-id Activity_ID
```

Optional: In case you want to clean up the infrastructure, execute below Schematics command:

```bash

ibmcloud schematics destroy --id $WORKSPACE_ID # Identify the Activity_ID
ibmcloud schematics logs  --id $WORKSPACE_ID --act-id Activity_ID

ibmcloud schematics workspace delete --id $WORKSPACE_ID
ibmcloud schematics workspace list
```

### Project Validation

To have access to the IKS cluster execute this **IBM Cloud CLI** command (`NAME` is the cluster name):

```bash
ibmcloud ks cluster config --cluster $NAME
```

If the project was executed with **Terraform**, get the outputs and kubectl configured executing these commands:

```bash
terraform output
ibmcloud ks cluster config --cluster $(terraform output cluster_id)
```

If the project was executed with **IBM Cloud Schematics**, get the outputs and kubectl configured executing these commands:

```bash
ibmcloud schematics workspace list          # Identify the WORKSPACE_ID
ibmcloud schematics workspace output --id $WORKSPACE_ID --json

ibmcloud ks cluster config --cluster $(ibmcloud schematics output --id $WORKSPACE_ID --json | jq -r '.[].output_values[].cluster_id.value')
```

Some `oc` commands to verify you have access are:

```bash
oc cluster-info
oc get nodes
oc get pods -A
```

## Deploy IBM Edge Application Manager

1) Login to your local linux/mac box with admin privileges. 
Retrieve and copy the [entitlement key](https://myibm.ibm.com/products-services/containerlibrary) and set the environment 
variable `IBM_CP_ENTITLEMENT_KEY`.

    ```bash
    export IBM_CP_ENTITLEMENT_KEY=<Your_IBM_Cloud_Pak_Entitlement_Key>
    ```

2) Create `workspace` directory in your local linux/mac box. Download **iac-ibm-openshift-ieam** repository code.

    ```bash
    mkdir <your_home_dir>/workspace
    cd <your_home_dir>/workspace
    git clone https://github.com/gargpriyank/iac-ibm-openshift-ieam.git
    cd iac-ibm-openshift-ieam
    chmod +x script/*.sh
    ```
3) Login to OpenShift cluster and execute the shell script `ieam-deploy.sh`. This will deploy the Common Services and IEAM and create IEAM hub.
   
    ```bash
    oc login --token=<openshift_cluster_token> --server=<openshift_server_url>
    ./script/ieam-deploy.sh
    ```
   
3) After the above script is executed successfully, run below command and make sure that all the pods are either in **Running** 
or **Completed** status.

    ```bash
    oc get pods -n ibm-common-services
    ```

4) Download the IBM Edge Application Manager Agent package 
from [IBM Passport Advantage](https://www.ibm.com/support/knowledgecenter/SSFKVV_4.2/hub/part_numbers.html?view=kc) 
or [IBM Internal DSW](https://w3-03.ibm.com/software/xl/download/ticket.wss) (for IBMers only) and save it in the directory 
`<your_home_dir/workspace`. Set the environment variable `IEAM_PACKAGE_FILE_NAME` with the downloaded file name 
and execute the shell script `extract-ieam-agent-files.sh`.
> **Note: Update `extract-ieam-agent-files.sh` file as per your operating system. It supports Linux and macOS.

    ```bash
    export IEAM_PACKAGE_FILE_NAME=<downloaded_file_name>
    export FIRST_ORG_ID=<your_first_org_id>
   ./script/extract-ieam-agent-files.sh
    ```
5) The environment variables in below will set the IEAM hub cluster URL, User Name and Password. You can log into IEAM hub using these credentials.

    ```bash
    export CLUSTER_URL=https://$(oc get cm management-ingress-ibmcloud-cluster-info -o jsonpath='{.data.cluster_ca_domain}')
    export CLUSTER_USER=$(oc -n ibm-common-services get secret platform-auth-idp-credentials -o jsonpath='{.data.admin_username}' | base64 --decode)
    export CLUSTER_PW=$(oc -n ibm-common-services get secret platform-auth-idp-credentials -o jsonpath='{.data.admin_password}' | base64 --decode)
    ```