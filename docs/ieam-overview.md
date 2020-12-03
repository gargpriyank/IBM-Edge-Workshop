# IBM Edge Application Manager (IEAM) Overview

## Introduction

- IEAM Installed on OpenShift cluster provides the edge computing features to manage and deploy workloads 
  from a management hub cluster to edge devices, cluster and remote instances of OpenShift Container Platform 
  or other Kubernetes-based clusters.
- The IEAM management hub is Installed into an OpenShift Container platform; thus, it inherits the all of the inherent security mechanism benefits. 
  All of the IEAM management hub network traffic traverses a TLS-secured entry point. Management hub network communication between 
  the IEAM management hub components is performed without TLS.
- The IEAM management hub and distributed agents communicate over the control plane to deploy workloads and models to edge nodes. 
  In contrast to typical centralized Internet of Things (IoT) platforms and cloud-based control systems, the IEAM control plane 
  is mostly decentralized. Each actor within the system has a limited scope of authority so that each actor has only the minimum level 
  of authority that is needed to complete its tasks. No single actor can assert control over the entire system. Furthermore, 
  a single actor cannot gain access to all of the edge nodes in the system by compromising any single edge node, host, or software component.
- IEAM supports the general concept of multitenancy through organizations, where each tenant has their own organization. Organizations separate 
  resources; therefore, users within each organization cannot create or modify resources in a different organization. 
  Furthermore, resources in an organization can be viewed only by users in that organization (unless the resources are marked as public). 
  Resources that are marked as public are the only resources that can be viewed across organizations.
- IEAM supports the Roles Based Access Control (RBAC) through IAM. Following are the typical roles in an organization:
    - Cluster Administrator
    - Administrator
    - Operator
    - Editor
    - Viewer

## Best practices for developing edge services for use with IEAM

The following best practices that help you design and develop edge services for use with IBM Edge Application Manager (IEAM).

- Cloud-native programming model: The edge-native programming model inherits many principles from cloud-native programming, including:
    - Containerize your workload to construct your application around a set of microservices, each packaged into logically related 
      groups, but balance that grouping to recognize where different containers might operate best at different tiers or edge nodes. 
    - Expose APIs to your microservices that enable other parts of your application to find the services they depend on. 
    - Design loose-coupling between microservices to enable them to operate independently of each other, and to avoid stateful assumptions that 
      impose affinities between services that would otherwise undermine elastic scaling, failover, and recovery.
    - Exercise continuous integration and continuous deployment, coupled with Agile Development practices within a DevOps framework.
- Service availability: If your service container requires and uses other service containers, your service must be tolerant when those services are 
  absent in some situations. For example, when containers initially start, even though they are started from the end of the dependency graph, 
  moving upward, some services can start more quickly than others. In this situation, your service containers need to retry while they wait for 
  the dependencies to be fully functional. Similarly, if a dependent service container is automatically updated, then it is restarted. 
  It is a best practice for your services to always be tolerant of interruptions in the services they depend on.
- Portability: The world of edge computing spans multiple tiers of the system including edge devices, edge clusters, and network or metro edge 
  locations. Where your containerized edge workload will eventually be placed depend on a combination of factors including its dependence on 
  certain resources, such as sensor data and actuators, end latency requirements, and available compute capacity. 
  You should design your workload to tolerate being placed in different tiers of the system depending on the needs 
  of the context in which your application will be used.
- Container orchestration: Further to the previous point about multi-tier portability; typically edge devices will be operated with native Docker 
  runtime with no local container orchestration. Edge clusters and network edges will be configured with Kubernetes to orchestrate the 
  workload against shared competing resource demands. You should implement your container to avoid any explicit dependence on either 
  Docker or Kubernetes to enable its portability to different tiers of the distributed edge computing world.
- Externalize configuration parameters: Use the built-in support provided by IEAM to externalize any configuration variables and resource 
  dependencies so that these can be supplied and updated to values that are specific to the node to which your container is deployed.
- Size considerations: Your service containers must be as small as possible so that the services can be deployed over potentially slow networks or 
  to small edge devices.


## Next Step

- [IBM Edge Developer Workshop](edge-workshop-developer.md)
<br> Or,
- [IBM Edge Admin Workshop](edge-workshop-admin.md)