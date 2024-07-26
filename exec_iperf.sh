#!/bin/bash

# Store the first argument in a variable
search_term=$1
comm=$2
# Use the variable in the command
pod_name=$(kubectl get pods | grep "$search_term" | awk '{print $1}')

# Optionally, you can echo or use the pod_name variable as needed
echo "Pod name: $pod_name"
kubectl exec -ti $pod_name -- iperf3 -s -i 1 --logfile test.txt

