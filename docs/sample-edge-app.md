# Sample Manufacturing Edge App

- Mimics an edge manufacturing application running locally on-prem, receiving sensor data from the floor, 
  processing it and taking a local action.
- Running on IBM cloud bare metal and virtual edges in the workshop sandbox.
- Packaged as a docker container. Deployed and managed by IBM Edge Application Manager on both edges.
- The workshop uses Eurotech ESF framework to simulate and publish Industry 4.0 events (Temperature, Luminosity etc.). 
  on an MQTT queue. The demo app reads events off MQTT and process data.
- After processing sensor data on the edge, the sample app posts it on a KAFKA event stream.
- In the Cloud Core instance of the workshop, the KAFKA topic is read via Watson Studio (CP4D) and data stored 
  in a Cloudant DB.
- There is little change required to connect actual sensor devices to this demo rig via an IoT Gateway.
- The entire sandbox can be provisioned in IBM Cloud.

## Next Step
- [Deploy IEAM 4.2 agent on edge node](ieam42-agent-deploy.md)