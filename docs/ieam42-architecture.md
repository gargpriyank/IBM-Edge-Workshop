# IBM Edge Application Manager (IEAM) 4.2 – Architecture

The goal of edge computing is to harness the disciplines that have been created for hybrid cloud computing to support remote operations of edge
computing facilities. IEAM is designed for that purpose. 
The deployment of IEAM includes the management hub that runs in an instance of OpenShift
Container Platform installed in your data center. The management hub is where the management of all of your remote edge nodes 
(edge devices and edge clusters) occurs. These edge nodes can be installed in remote on-premises locations to make your application workloads local
to where your critical business operations physically occur, such as at your factories, warehouses, retail outlets, distribution centers, and more.
The following diagram depicts the high-level topology for a typical edge computing setup:

<img src="images/ieam42-architecture.png" />

The IEAM management hub is designed specifically for edge node management to minimize deployment risks and to manage the service software lifecycle 
on edge nodes fully autonomously. A Cloud installer installs and manages the IEAM management hub components. Software developers develop and publish 
edge services to the management hub. Administrators define the deployment policies that control where edge services are deployed. 
IEAM handles everything else.

## Edge Components:

- Agbot: Agreement bot (agbot) instances are created centrally and are responsible for deploying workloads and machine learning models to IEAM edge
nodes.

- Exchange: The Exchange provides a REST API to all of the IEAM resources (patterns, policies, services, nodes, and so on) used by all the other
components in IEAM.

- UI Management console: The web UI used by IEAM administrators to view and manage the other components of IEAM.

- MMS: The Model Management System (MMS) facilitates the storage, delivery, and security of models and files needed by edge services. This enables
edge nodes to easily send and receive models and files to and from the management hub.

- SDO: The Secure Device Onboarding (SDO) service enables SDO-enabled edge devices to be configured with zero touch.

- Edge node: Any edge device, edge cluster, or edge gateway where edge computing takes place.

- Edge cluster agent: The agent that is installed on edge clusters to enable node workload management by IEAM.

- Edge device agent: The agent that is installed on edge devices to enable node workload management by IEAM.

- ESS: The edge node part of MMS that makes AI models and files available to the edge services.

- Example edge services: Edge service examples that are useful when exploring IEAM and learning how to write your own services.

## Next Step

- (Optional) [OpenShift Classic Cluster - Automated Provisioning](openshift-automation.md)
- [IBM Edge Application Manager (IEAM) 4.2 - Automated Installation](ieam42-automation.md)
<br> or,
- [IBM Edge Application Manager (IEAM) 4.2 - Manual Installation](ieam42-installation.md)