#!/bin/sh

set -e


if [ "$NAMESPACE" != "null" ];
then
echo "restart in process ..."
echo $NAMESPACE

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$KUBE_CONFIG_DATA" | base64 --decode > /tmp/config
export KUBECONFIG=/tmp/config
RN=$(kubectl describe deployment $POD -n  $NAMESPACE|grep NewReplicaSet:|awk '{print $2}')
PODS=$(for i in $(kubectl get pod -n $NAMESPACE| grep ${RN}|awk '{print $1}'); do echo $i; done)

echo ${PODS}

kubectl delete pod ${PODS} -n $NAMESPACE
#kubectl get pods -n $NAMESPACE | grep $POD | cut -d " " -f1 | head -1 | xargs kubectl delete pod -n $NAMESPACE
else
echo "Restart is DISABLED, namespase is null"
fi
