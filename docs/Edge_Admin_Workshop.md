# IBM Edge Developer Workshop

<span style="color:#2B67D4">Building and Deploying Edge Applications at Scale\, Securely</span>

<span style="color:#2B67D4">IBM Client Developer Advocacy</span>

<span style="color:#2B67D4">IBM Edge Computing</span>

<img src="images/Edge%20Workshop%2011-090.png" width=355px />

Workshop Audience

Application Developers\, Solution Designers & Architects – IBM partners & Customers

Workshop Pre\-requisite Skills

[Distributed](https://www.ibm.com/cloud/blog/understanding-distributed-cloud-architecture-the-basics)[Architecture 101](https://www.ibm.com/cloud/blog/understanding-distributed-cloud-architecture-the-basics)and[generic edge awareness](https://developer.ibm.com/depmodels/edge-computing/)for Applications

Basic Cloud Native Skills – docker\, containers\,[Red Hat OpenShift](https://www.openshift.com/learn/developer)\, Kubernetes

[IBM Cloud Account](https://cloud.ibm.com/registration)with Admin role privilege to create and manage workshop sandbox resources

Workshop Sandbox Roles

Sandbox Administrator – manages deployment \(Edge \+ Cloud Core\)

Developer – develops and publishes edge app/service

Cloud Admin – Installs Edge Services like IEAM

Node Owner – edge owner registering the node to IEAM

<span style="color:#0847E1"> _All these roles can be fulfilled by a single person\, if needed_ </span>

<img src="images/Edge Workshop 11-091.png/" width=352px />

IBM Corporation \(C\) 2020 | IBM Confidential

# Edge Developer Workshop Agenda Day 1

<img src="images/Edge Workshop 11-092.png/" width=352px />

IBM Corporation \(C\) 2020 | IBM Confidential

<img src="images/Edge Workshop 11-093.png/" width=352px />

IBM Corporation \(C\) 2020 | IBM Confidential

# Edge Overview60 Minutes

<img src="images/Edge Workshop 11-094.png/" width=355px />



<img src="images/Edge Workshop 11-095.png/" width=352px />

IBM Corporation \(C\) 2020 | IBM Confidential

Edge Computing Regions

<img src="images/Edge Workshop 11-096.png" width=500px />

Enterprise hybrid multicloud\. This region offers the classic enterprise\-level model storage and management\, device management\, and especially enterprise\-level analytics and dashboards\. This region can be hosted in the cloud or in an on\-premises data center\.

Edge network or micro data center\. New networking technologies have resulted in the edge network or micro data center\, which can be viewed as a local cloud for devices to communicate with\. The edge network reduces the distance that data from the devices must travel and thus decreases latency and bandwidth issues especially with the advent of 5G\. This region also offers more analytical capabilities and more storage for models\.

Edge servers are used to deploy apps to the devices\. They are in constant communication with the devices by using agents that are installed on each of the devices\. Thousands of edge servers maintain a pulse on the millions of devices\. If something more than inferencing is needed\, data from the devices is sent to the edge server for further analysis

Devices \- The edge and IoT devices are equipped to run analytics\, apply AI rules\, and even store some data locally to support operations at the edge\. The devices could handle analysis and real\-time inferencing without involvement of the edge server or the enterprise region\.

<img src="images/Edge Workshop 11-097.png/" width=352px />

IBM Corporation \(C\) 2020 | IBM Confidential

Edge Computing Scale

<img src="images/Edge Workshop 11-098.png" width=500px />

<img src="images/Edge Workshop 11-099.png/" width=352px />

IBM Corporation \(C\) 2020 | IBM Confidential

<span style="color:#323232">Reference Architecture \- IBM Edge Application Manager for Devices</span>

<span style="color:#4378BA">EDGE SERVER/GATEWAY</span>

<span style="color:#4378BA">EDGE NETWORK/ MICRO DATA CENTER</span>

<span style="color:#4378BA">ENTERPRISE HYBRID MULTICLOUD</span>

<span style="color:#0847E1">Focus is on the outermost edge\, the edge devices region</span>

<span style="color:#4377B9">CONTAINERIZED WORKLOADS</span>

<span style="color:#4377B9">CONTAINERIZED WORKLOADS</span>

<span style="color:#4377B9">CONTAINERIZED WORKLOADS</span>

<span style="color:#0847E1">This Reference Architecture is most optimal for use cases involving a large</span>  <span style="color:#0847E1"> _Smart_ </span>  <span style="color:#0847E1">Device farm with agents installed on them\. These devices communicate with other components to securely orchestrate software lifecycle management\. Near real\-time inference analysis performed locally</span>

<span style="color:#4377B9">Application component</span>

<span style="color:#4377B9">Infrastructure services</span>

<span style="color:#4377B9">Service management</span>

<span style="color:#323232">Reference Architecture \- IBM Edge Application Manager for Devices</span>

<span style="color:#4378BA">EDGE SERVER/GATEWAY</span>

<span style="color:#4378BA">NETWORK EDGE/ MICRO DATA CENTER</span>

<span style="color:#4378BA">ENTERPRISE HYBRID MULTI\-CLOUD</span>

<span style="color:#0847E1">Focus is on the outermost edge\, the edge devices region</span>

<span style="color:#4377B9">CONTAINERIZED WORKLOADS</span>

<span style="color:#4377B9">CONTAINERIZED WORKLOADS</span>

<span style="color:#0847E1">This Reference Architecture is most optimal for use cases involving a passive device farm\, like IoT Sensors & Actuators\. Local inferencing capability not available with dumb devices</span>

<span style="color:#4377B9">Application component</span>

<span style="color:#4377B9">Infrastructure services</span>

<span style="color:#323232">Reference Architecture \- IBM Edge Application Manager for Clusters</span>

<span style="color:#4378BA">EDGE SERVER/GATEWAY</span>

<span style="color:#4378BA">EDGE NETWORK/ MICRO DATA CENTER</span>

<span style="color:#4378BA">ENTERPRISE HYBRID MULTICLOUD</span>

<span style="color:#0847E1">Focus is on edge server tier with higher compute need for edge data processing needed for advanced visualization and AI analytics</span>

<span style="color:#4377B9">CONTAINERIZED WORKLOADS</span>

<span style="color:#4377B9">CONTAINERIZED WORKLOADS</span>

<span style="color:#4377B9">CONTAINERIZED WORKLOADS</span>

<span style="color:#0847E1">This Reference Architecture is most optimal for use cases involving processing of large data sets on the edge with results sent back to devices</span>

<span style="color:#4377B9">Application component</span>

<span style="color:#4377B9">Infrastructure services</span>

<span style="color:#4377B9">Service management</span>

<span style="color:#323232">Reference Architecture \- IBM Edge Application Manager for Clusters</span>

<span style="color:#4378BA">EDGE SERVER/GATEWAY</span>

<span style="color:#4378BA">NETWORK EDGE/ MICRO DATA CENTER</span>

<span style="color:#4378BA">ENTERPRISE HYBRID MULTI\-CLOUD</span>

<span style="color:#0847E1">Focus is on edge server tier with higher compute need for edge data processing needed for advanced visualization and AI analytics</span>

<span style="color:#4377B9">CONTAINERIZED WORKLOADS</span>

<span style="color:#4377B9">CONTAINERIZED WORKLOADS</span>

<span style="color:#0847E1">This Reference Architecture is most optimal for use cases involving processing of large data sets on the edge with results sent back to devices</span>

<span style="color:#4377B9">Application component</span>

<span style="color:#4377B9">Infrastructure services</span>

# Edge Platform – OCP, RHEL and CP4D

<img src="images/Edge Workshop 11-0910.png/" width=225px />

<img src="images/Edge Workshop 11-0911.png" width=500px />

<img src="images/Edge Workshop 11-0912.png/" width=267px />

Run Kube on the Edge

Multi\-Cloud deployments

Flexible\, modular building blocks for edge applications

<img src="images/Edge Workshop 11-0913.png/" width=500px />

<img src="images/Edge Workshop 11-0914.png/" width=500px />

<span style="color:#308AFF">Unified Dev Environment for integrated data management\, data governance\, data science and AI capabilities</span>

<img src="images/Edge Workshop 11-0915.png/" width=352px />

IBM Corporation \(C\) 2020 | IBM Confidential

# Edge Infra Services – IEAM and Management Hub

<img src="images/Edge Workshop 11-0916.png" width=500px />

Deploy and manage critical workloads on edge nodes securely and reliably to hundreds of remote locations from a central location

Bring your app to the edge – variety of edge environments supported across market verticals

Seamless Integration with OpenShift to deploy containerized apps anywhere

Enables large data files such as machine learning model files to have an __independent lifecycle__ from the code that uses it\, like an inferencing application

<img src="images/Edge Workshop 11-0917.png/" width=225px />

<img src="images/Edge Workshop 11-0918.png/" width=217px />

