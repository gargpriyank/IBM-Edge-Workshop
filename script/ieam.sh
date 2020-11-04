Download helm, ibm cloud pak cli from https://icp-console.sandbox-edge-workshop-c-2bef1f4b4097001da9502000c44fc2b2-0000.us-south.containers.appdomain.cloud/common-nav/cli
   cloudctl: curl -kLo cloudctl-linux-amd64-v3.2.4-1675 https://icp-console.sandbox-edge-workshop-c-2bef1f4b4097001da9502000c44fc2b2-0000.us-south.containers.appdomain.cloud:443/api/cli/cloudctl-linux-amd64
   helm: curl -kLo helm-linux-amd64-v2.12.3.tar.gz https://icp-console.sandbox-edge-workshop-c-2bef1f4b4097001da9502000c44fc2b2-0000.us-south.containers.appdomain.cloud:443/api/cli/helm-linux-amd64.tar.gz
   kubectl config set-cluster sandbox-edge-workshop-ieam-cluster --server=https://icp-console.sandbox-edge-workshop-c-2bef1f4b4097001da9502000c44fc2b2-0000.us-south.containers.appdomain.cloud:32493 --insecure-skip-tls-verify=true
   kubectl config set-context sandbox-edge-workshop-ieam-cluster-context --cluster=sandbox-edge-workshop-ieam-cluster
   kubectl config set-credentials admin --token=OC6gk3G8hhkXXVeQuFbklU0HnKlUnBY8QpzWGXjqsa36
   kubectl config set-context sandbox-edge-workshop-ieam-cluster-context --user=admin --namespace=tigera-operator
   kubectl config use-context sandbox-edge-workshop-ieam-cluster-context
export CLUSTER_URL=https://$(oc get routes icp-console -o jsonpath='{.spec.host}' -n kube-system)
cloudctl login -a $CLUSTER_URL -u admin -p VWCugI4eTOi69vMYDKXXgLxB3rQcXEY2 -n kube-system --skip-ssl-validation
export REGISTRY_HOST=$(oc get routes -n openshift-image-registry default-route -o jsonpath='{.spec.host}')
mkdir -p /etc/docker/certs.d/$REGISTRY_HOST && \
   echo | openssl s_client -showcerts -connect $REGISTRY_HOST:443 2>/dev/null | openssl x509 -outform PEM > /etc/docker/certs.d/$REGISTRY_HOST/ca.crt && \
   service docker restart
docker login $REGISTRY_HOST -u $(oc whoami) -p $(oc whoami -t)
cd /root/ibm-eam-4.1.0-x86_64
cloudctl catalog load-archive --archive ibm-eam-prod-catalog-archive-4.1.0.tgz --registry $REGISTRY_HOST/ibmcom
tar -O -zxvf ibm-eam-prod-catalog-archive-4.1.0.tgz charts/ibm-eam-prod-4.1.0.tgz | tar -zxvf - && cd /root/ibm-eam-4.1.0-x86_64/ibm-eam-prod
oc patch storageclass ibmc-block-gold -p '{"metadata": {"annotations": {"storageclass.kubernetes.io/is-default-class": "true"}}}'
Update storageClass and storageClassName values with ibmc-block-gold in /root/ibm-eam-4.1.0-x86_64/ibm-eam-prod/charts/ibm-postgresql/values.yaml and /root/ibm-eam-4.1.0-x86_64/ibm-eam-prod/charts/ibm-mongodb/values.yaml
/root/ibm-eam-4.1.0-x86_64/ibm-eam-prod/ibm_cloud_pak/pak_extensions/support/ieam-install.sh
Edge URL: https://icp-console.sandbox-edge-workshop-c-2bef1f4b4097001da9502000c44fc2b2-0000.us-south.containers.appdomain.cloud/edge
cd /root/ibm-eam-4.1.0-x86_64
tar -zxvf horizon-edge-packages-4.1.0.tar.gz
sudo dpkg -i horizon-edge-packages-4.1.0/linux/ubuntu/bionic/amd64/horizon-cli*.deb
export EXCHANGE_ROOT_PASS=$(oc -n kube-system get secret ibm-edge-auth -o jsonpath="{.data.exchange-root-pass}" | base64 --decode)
    export HZN_EXCHANGE_URL=https://$(oc get routes icp-console -o jsonpath='{.spec.host}' -n kube-system)/edge-exchange/v1
    export HZN_EXCHANGE_USER_AUTH="root/root:$EXCHANGE_ROOT_PASS"
    export HZN_ORG_ID=IBM
oc --namespace kube-system get secret cluster-ca-cert -o jsonpath="{.data['tls\.crt']}" | base64 --decode > /tmp/icp-ca.crt
sudo cp /tmp/icp-ca.crt /usr/local/share/ca-certificates && sudo update-ca-certificates
hzn key create IBM priyank.garg@ibm.com
hzn exchange status
curl https://raw.githubusercontent.com/open-horizon/examples/v4.1/tools/exchangePublishScript.sh | bash -s -- -c $(oc get -n kube-public configmap -o jsonpath="{.items[].data.cluster_name}")
hzn exchange service list IBM/
    hzn exchange pattern list IBM/
    hzn exchange deployment listpolicy -o $(oc get -n kube-public configmap -o jsonpath="{.items[].data.cluster_name}")
oc --namespace kube-system rollout restart deployment ibm-edge-agbot
    oc --namespace kube-system rollout status deployment ibm-edge-agbot
oc --namespace kube-system patch role ibm-edge-application-manager --type='json' -p='[{"op": "add", "path": "/rules/2", "value": {"apiGroups":["foundation.ibm.com"], "resources": ["navconfigurations"], "verbs": ["get","update","create"]} }]'
    oc --namespace kube-system rollout restart deployment ibm-edge-ui
    oc --namespace kube-system rollout status deployment ibm-edge-ui