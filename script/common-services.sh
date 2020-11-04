#! /bin/bash

tar -zxvf ibm-eam-4.1.0-x86_64.tar.gz && cd /root/ibm-eam-4.1.0-x86_64
mkdir -p /opt/common-services-3.2.7/ibm-eam-4.1.0-licenses && cp /root/ibm-eam-4.1.0-x86_64/ibm-eam-4.1.0-licenses.zip /opt/common-services-3.2.7/ibm-eam-4.1.0-licenses && chmod -R 777 /opt/common-services-3.2.7 && chmod -R 777 /opt/common-services-3.2.7/ibm-eam-4.1.0-licenses
: '
systemctl enable docker
systemctl start docker
tar -zvxf common-services-boeblingen-2004-x86_64.tar.gz -O | sudo docker load
mkdir /data && chmod 777 /data
cd /opt/common-services-3.2.7
sudo docker run -it -v $(pwd):/data:z -e LICENSE=accept -v $(pwd)/ibm-eam-4.1.0-licenses:/installer/cfc-files/license:z --security-opt label:disable ibmcom/icp-inception-amd64:3.2.7 /bin/sh
docker start e7563bcca207
docker cp clever_brahmagupta:/installer/cluster /data
Update config.yaml with node details, storageclass, cluster name and password
oc login --token=HW-nfahMfLfoq2n2HjM9lUOsaYlhko7l9Kp6BxfB6ss --server=https://c114-e.us-south.containers.cloud.ibm.com:32493
oc patch configs.imageregistry.operator.openshift.io/cluster --type merge -p '{"spec":{"defaultRoute":true}}'
cp ~/.kube/config /opt/common-services-3.2.7/cluster/kubeconfig
sudo docker run -t --net=host -e LICENSE=accept -v $(pwd)/../ibm-eam-4.1.0-licenses:/installer/cfc-files/license:z -v $(pwd):/installer/cluster:z -v /var/run:/var/run:z -v /etc/docker:/etc/docker:z --security-opt label:disable ibmcom/icp-inception-amd64:3.2.7 install-with-openshift
'