#! /bin/bash

mkdir -p /root/Workspace/ibm-ieam

# Extract the IBM Edge Manager package content.
#tar -zxvf /root/Workspace/$IEAM_PACKAGE_FILE_NAME -C /root/Workspace/ibm-ieam

cd /root/Workspace/ibm-ieam/* || { echo "Directory /root/Workspace/ibm-ieam does not exist."; exit; }

mkdir -p /opt/common-services/ibm-eam-licenses /data && cp *-licenses.zip /opt/common-services/ibm-eam-licenses \
&& chmod -R 777 /opt/common-services /opt/common-services/ibm-eam-licenses /data

# Install docker and start docker service.
#apt install docker.io -y
#systemctl enable docker
#systemctl start docker

# Load common services docker images.
#tar -zvxf common-services-*.tar.gz -O | sudo docker load
cd /opt/common-services || { echo "Directory /opt/common-services doesn't exist."; exit; }

sudo docker run -it -v $(pwd):/data:z -e LICENSE=accept -v $(pwd)/ibm-eam-licenses:/installer/cfc-files/license:z --security-opt \
label:disable ibmcom/icp-inception-amd64:3.2.7 /bin/sh

: '

sudo docker run --rm -v $(pwd):/data:z -e LICENSE=accept -v $(pwd)/ibm-eam-4.1.0-licenses:/installer/cfc-files/license:z \
--security-opt label:disable ibmcom/icp-inception-amd64:3.2.7 cp -r cluster /data

sudo docker run -t --net=host -e LICENSE=accept -v $(pwd)/../ibm-eam-4.1.0-licenses:/installer/cfc-files/license:z \
-v $(pwd):/installer/cluster:z -v /var/run:/var/run:z -v /etc/docker:/etc/docker:z \
--security-opt label:disable ibmcom/icp-inception-amd64:3.2.7 install-with-openshift


docker start e7563bcca207
docker cp clever_brahmagupta:/installer/cluster /data
Update config.yaml with node details, storageclass, cluster name and password
oc login --token=HW-nfahMfLfoq2n2HjM9lUOsaYlhko7l9Kp6BxfB6ss --server=https://c114-e.us-south.containers.cloud.ibm.com:32493
oc patch configs.imageregistry.operator.openshift.io/cluster --type merge -p '{"spec":{"defaultRoute":true}}'
cp ~/.kube/config /opt/common-services-3.2.7/cluster/kubeconfig
sudo docker run -t --net=host -e LICENSE=accept -v $(pwd)/../ibm-eam-4.1.0-licenses:/installer/cfc-files/license:z -v $(pwd):/installer/cluster:z -v /var/run:/var/run:z -v /etc/docker:/etc/docker:z --security-opt label:disable ibmcom/icp-inception-amd64:3.2.7 install-with-openshift
'