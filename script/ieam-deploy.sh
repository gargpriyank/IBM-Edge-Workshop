#! /bin/bash

oc apply -f ieam-deploy/ibm-operator-catalog.yaml

oc apply -f ieam-deploy/ibm-operator-common-services-catalog.yaml

oc new-project ibm-edge

oc create secret docker-registry ibm-entitlement-key --docker-server=cp.icr.io --docker-username=cp --docker-password=$IBM_CP_ENTITLEMENT_KEY

oc get packagemanifests -n openshift-marketplace | grep ibm-eam

oc describe packagemanifests ibm-eamhub-operator-catalog -n openshift-marketplace

oc apply -f ieam-deploy/ibm-operator-ieam-group.yaml

oc apply -f ieam-deploy/ibm-operator-ieam-subscribe.yaml

sleep 5m

oc apply -f ieam-deploy/ibm-common-services.yaml

oc apply -f ieam-deploy/ibm-ieam-hub.yaml

oc get pods -n ibm-common-services
