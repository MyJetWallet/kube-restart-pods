#!/bin/sh

set -e


if [ "$NAMESPACE" != "null" ];
then
echo "restart in process ..."
echo $NAMESPACE

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$KUBE_CONFIG_DATA" | base64 --decode > /tmp/config
export KUBECONFIG=/tmp/config

for i in $(kubectl get deploy -o wide | grep $IMAGE | awk {'print $1'}); do kubectl delete po -l app=$i; done

else
echo "Restart is DISABLED, namespase is null"
fi
