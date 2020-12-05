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

<img src="images/ieam42.png" />

## Next Step

- [IBM Edge Developer Workshop](edge-workshop-developer.md)
<br> Or,
- [IBM Edge Admin Workshop](edge-workshop-admin.md)