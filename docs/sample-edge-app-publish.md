# Develop & Publish Sample Edge Application

This page covers the step by step guidance to develop and publish the Sample Edge Application. After completing the below steps, you will be able to:
- Publish the simulated manufacturing application **esf-ieam** that generates the events such as buzzer, fan, light and temperature.
- Publish the sample edge application **edge-app** that reads the generated events, aggregate it to produce new events and send it over to Event
Streams that will be read by IBM Watson Stream Flows to save it into IBM CloudantDB.

## Content

- [Prerequisites](#prerequisites)
- [Develop the Sample Edge Application](#develop--publish-sample-edge-application)
- [Publish the Sample Edge Application](#publish-the-sample-edge-application)

## Prerequisites

- Install the following tools:
    - [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
    - [make](https://www.gnu.org/software/make/)
    - [docker](https://www.ibm.com/links?url=https%3A%2F%2Fdocs.docker.com%2Fget-docker%2F)
- Create a public repo in [docker hub](https://hub.docker.com/).

## Develop the Sample Edge Application

1) Log in to your edge node with the user id **ibm-workshop** created during IEAM agent deployment. Pull the sample Github code.

> Note: For edge node only Linux operating system is supported.

```markdown
cd /home/ibm-workshop/workspace
git clone https://github.com/gargpriyank/edge-app-skeleton.git
mv edge-app-skeleton sample-edge-app
cd sample-edge-app
```

2) Look at the below sample code. **HZN_ORG_ID** is the IEAM organization id where the edge service will be published. **DOCKER_IMAGE_BASE** is your
docker repo name. **SERVICE_NAME** is the edge service name with which the service will be published. **SERVICE_VERSION** is the version of edge
service and the docker image. Copy and paste this code in `edge-app/horizon/hzn.json` file and update the values as per your requirement.

```markdown
{
  "HZN_ORG_ID": "$HZN_ORG_ID",
  "MetadataVars": {
    "DOCKER_IMAGE_BASE": "sandboxedgeworkshop/edge-app",
    "SERVICE_NAME": "edge-app",
    "SERVICE_VERSION": "0.0.1"
  }
}
```

3) Look at the below sample code. **ARCH** is the hardware architecture of the edge node where the edge service will be deployed.
**requiredServices** section shows the required services that should start first to run this service. **userInput** section lists all the input
variables required by this service. **deployment** section lists all the services that will be published and deployed.
Copy and paste this code in `edge-app/horizon/service.definition.json` file and update the values as per your requirement.

```markdown
{
  "org": "$HZN_ORG_ID",
  "label": "$SERVICE_NAME for $ARCH",
  "description": "Edge Application service",
  "public": true,
  "documentation": "",
  "url": "$SERVICE_NAME",
  "version": "$SERVICE_VERSION",
  "arch": "$ARCH",
  "sharable": "singleton",
  "requiredServices": [
    {
      "url": "esf-ieam",
      "org": "$HZN_ORG_ID",
      "versionRange": "[0.0.0,INFINITY)",
      "arch": "$ARCH"
    }
  ],
  "userInput": [
    {
      "name": "EVENTSTREAMS_TOPIC_NAME",
      "label": "The Topic name of the instance of IBM Event Streams",
      "type": "string",
      "defaultValue": ""
    },
    {
      "name": "EVENTSTREAMS_BROKER_URL",
      "label": "The Broker URL of the instance of IBM Event Streams",
      "type": "string",
      "defaultValue": ""
    },
    {
      "name": "EVENTSTREAMS_API_KEY",
      "label": "The API Key of the instance of IBM Event Streams",
      "type": "string",
      "defaultValue": ""
    }
  ],
  "deployment": {
    "services": {
      "$SERVICE_NAME": {
        "image": "${DOCKER_IMAGE_BASE}:$SERVICE_VERSION",
        "network": "edge_workshop",
        "privileged": true
      }
    }
  }
}
```

4) Look at the below sample code. **constraints** section lists all the deployment constraints that should match with the **node policy** properties
while registering. Copy and paste this code in `edge-app/horizon/deployment.policy.json` file and update the values as per your requirement.

```markdown
{
  "label": "$SERVICE_NAME Deployment Policy",
  "description": "A Horizon Deployment Policy example to run edge-app",
  "service": {
    "name": "$SERVICE_NAME",
    "org": "$HZN_ORG_ID",
    "arch": "$ARCH",
    "serviceVersions": [
      {
        "version": "$SERVICE_VERSION",
        "priority":{}
      }
    ]
  },
  "properties": [
  ],
  "constraints": [
    "deploy-edge-app == true"
  ],
  "userInput": [
    {
      "serviceOrgid": "$HZN_ORG_ID",
      "serviceUrl": "$SERVICE_NAME",
      "serviceVersionRange": "[0.0.0,INFINITY)",
      "inputs": [
        {
          "name": "EVENTSTREAMS_TOPIC_NAME",
          "value": "$EVENTSTREAMS_TOPIC_NAME"
        },
        {
          "name": "EVENTSTREAMS_BROKER_URL",
          "value": "$EVENTSTREAMS_BROKER_URL"
        },
        {
          "name": "EVENTSTREAMS_API_KEY",
          "value": "$EVENTSTREAMS_API_KEY"
        }
      ]
    }
  ]
}
```

5) Look at the below sample code. **constraints** section lists all the service policy constraints that uses the Open Horizon inbuild variable 
**openhorizon.memory** that should match with the **node policy** properties while registering. Copy and paste this code in
`edge-app/horizon/service.policy.json` file and update the values as per your requirement.

```markdown
{
  "properties": [],
  "constraints": [
    "openhorizon.memory >= 100"
  ]
}
```

6) Look at the content in below. Copy and paste it into `edge-app/Makefile` to build and publish the edge-app service.

```markdown
-include horizon/.hzn.json.tmp.mk
export ARCH ?= $(shell hzn architecture)

build:
	docker build -t $(DOCKER_IMAGE_BASE):$(SERVICE_VERSION) .

publish-service:
	hzn exchange service publish -O -f horizon/service.definition.json

publish-service-policy:
	hzn exchange service addpolicy -f horizon/service.policy.json $(HZN_ORG_ID)/$(SERVICE_NAME)_$(SERVICE_VERSION)_$(ARCH)

publish-deployment-policy:
	hzn exchange deployment addpolicy -f horizon/deployment.policy.json $(HZN_ORG_ID)/policy-$(SERVICE_NAME)_$(SERVICE_VERSION)_$(ARCH)

build-publish:
	$(MAKE) build
	$(MAKE) publish-service
	$(MAKE) publish-service-policy
	$(MAKE) publish-deployment-policy

horizon/.hzn.json.tmp.mk: horizon/hzn.json
	@ hzn util configconv -f $< | sed 's/=/?=/' > $@
```

7) Look at the content in below. Copy and paste it into `Makefile` to build and publish the edge-app and esf services.

```markdown
export ARCH ?= $(shell hzn architecture)

publish-esf-ieam:
	cd esf-ieam && $(MAKE) publish-service

publish-edge-app:
	cd edge-app && $(MAKE) build-publish

publish:
	$(MAKE) publish-esf-ieam
	$(MAKE) publish-edge-app
```

## Publish the Sample Edge Application

Run the below command and that will build and publish the edge-app and esf services.

```markdown
make publish
```

## Next Step
- [Register Sample Edge Application With Node Policy](sample-edge-app-register.md)