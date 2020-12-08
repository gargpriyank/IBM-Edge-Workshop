# IBM Edge Application Manager (IEAM) Overview

## Introduction

IEAM Installed on OpenShift cluster provides the edge computing features to manage and deploy workloads 
from a management hub cluster to edge devices, cluster and remote instances of OpenShift Container Platform 
or other Kubernetes-based clusters.

## Why IBM Edge?

- Manage the distribution of software at massive scale.
- Leverage open source technology
- Address security concerns
- Move to autonomous management that's built for scale and variability and runs anywhere.
- Administrators express an intent and autonomous management software Policy executes in line with the intent.

## IEAM Features

- The IEAM management hub is Installed into an OpenShift Container platform and thus it inherits the all the inherent security mechanism 
  benefits.
- All the IEAM management hub network traffic traverses a TLS-secured entry point. Management hub network communication between 
  the IEAM management hub components is performed without TLS.
- The IEAM management hub and distributed agents communicate over the control plane to deploy workloads and models to edge nodes. 
  In contrast to typical centralized Internet of Things (IoT) platforms and cloud-based control systems, the IEAM control plane 
  is mostly decentralized.
- IEAM supports the general concept of multitenancy through organizations, where each tenant has their own organization.
- IEAM supports the Roles Based Access Control (RBAC) through IAM. Following are the typical roles in an organization:
    - Cluster Administrator
    - Administrator
    - Operator
    - Editor
    - Viewer

![Network Architecture](images/ieam42.png)

Following are the steps performed in above figure:

- Edge service is published into IEAM.
- IEAM agent on the edge node registers and makes an agreement with Agbot on the IEAM management hub.
- IEAM agent deploys and runs the edge service container.
- Edge service pulls the container image from the container registry such as docker registry.

## Next Step

- [IBM Edge Application Manager (IEAM) - Reference Architecture for Devices](reference-architecture-devices.md)