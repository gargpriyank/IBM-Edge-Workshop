# Register Sample Edge Application With Node Policy

This page covers the step by step guidance to register and deploy the Sample Edge Application. After completing the below steps, you will be able to:
- Register the edge node with node policy.
- Deploy the simulated manufacturing application **esf-ieam** that generates the events such as buzzer, fan, light and temperature.
- Deploy the sample edge application **edge-app** that reads the generated events, aggregate it to produce new events and publish it to Event
Streams that will be read by IBM Watson Stream Flows to save it into IBM CloudantDB.

## Content

- [Prerequisites](#prerequisites)
- [Register & Deploy](#register--deploy)

## Prerequisites

- Completed the steps covered in [Develop & Publish Sample Edge Application](sample-edge-app-publish.md).

## Register & Deploy the Sample Edge Application

1) Copy and paste the below content in `edge-app/userinput.json` file.

```markdown
{
  "services": [
    {
      "org": "$HZN_ORG_ID",
      "url": "edge-app",
      "variables": {
        "EVENTSTREAMS_TOPIC_NAME": "$EVENTSTREAMS_TOPIC_NAME",
        "EVENTSTREAMS_BROKER_URL": "$EVENTSTREAMS_BROKER_URL",
        "EVENTSTREAMS_API_KEY": "$EVENTSTREAMS_API_KEY"
      }
    }
  ]
}
```

2) Look at the content in below. Copy and paste it into `Makefile` to register and deploy the sample edge and esf services by paasing `userinput.json`
file to set the IBM Event Streams variables used in sample edge service.

```markdown
register-node-policy:
	cd edge-app && hzn register --policy=horizon/node_policy.json -s edge-app --serviceorg $HZN_ORG_ID -f userinput.json
```

3) Run the below command and that will deploy the sample edge and esf services.
   
```markdown
make register-node-policy
```

## Next Step
- [IBM Edge Admin Workshop](edge-workshop-admin.md)