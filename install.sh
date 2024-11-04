#!/bin/bash

# Check if the first argument is "install"
if [ "$1" = "install" ]; then
    # Execute the series of helm install commands
    #helm install basic /home/user8/multiple_up/charts/oai-5g-core/oai-5g-basic/
    #/home/user8/multiple_up/oai-cn5g-fed_v01/charts/oai-5g-core/oai-5g-basic
    helm spray ./5g-core/oai-5g-basic
    #sudo helm spray /home/user8/multiple_up/oai-cn5g-fed_v01/charts/oai-5g-core/oai-5g-basic


    #sleep 30
    helm install cp ./5g-ran/oai-cu-cp
    #sleep 10
    pod_name=$(kubectl get pods | grep "oai-cu-cp" | awk '{print $1}')
    kubectl wait --for=condition=Ready pod $pod_name --timeout=300s

    helm install up ./5g-ran/oai-cu-up
    #helm install up2 ./5g-ran/oai-cu-up2
    pod_name=$(kubectl get pods | grep "oai-cu-up" | awk '{print $1}')
    kubectl wait --for=condition=Ready pod $pod_name --timeout=300s
    sleep 20
    #while ! kubectl logs -f $pod_name >&1 | grep -q "\[GTPU\]   SA mode"; do
    #	sleep 1
    #done
    #kubectl logs -f $pod_name
    

    #sleep 20
    #helm install du ./5g-ran/oai-du
    helm install du2 ./5g-ran/oai-du2
    helm install du3 ./5g-ran/oai-du3
    helm install du4 ./5g-ran/oai-du4
    #helm install du5 /home/user8/multiple_up/charts/oai-5g-ran/oai-du5

    #sleep 20
    #pod_name=$(kubectl get pods | grep "oai-du4" | awk '{print $1}')
    #kubectl wait --for=condition=Ready pod $pod_name --timeout=300s
    
    pod_name=$(kubectl get pods | grep "tiny-" | awk '{print $1}')
    kubectl exec -ti $pod_name -- apt-get update 
    kubectl exec -ti $pod_name -- apt-get install -y iperf3
    pod_name=$(kubectl get pods | grep "tiny2-" | awk '{print $1}')
    kubectl exec -ti $pod_name -- apt-get update 
    kubectl exec -ti $pod_name -- apt-get install -y iperf3
    pod_name=$(kubectl get pods | grep "tiny3-" | awk '{print $1}')
    kubectl exec -ti $pod_name -- apt-get update 
    kubectl exec -ti $pod_name -- apt-get install -y iperf3


    #sleep 40

    #helm install ue1 ./5g-ran/oai-nr-ue
    #pod_name=$(kubectl get pods | grep "ue1-" | awk '{print $1}')
    #kubectl wait --for=condition=Ready pod $pod_name --timeout=300s
    #kubectl exec -ti $pod_name ping 12.1.1.1
   
    helm install ue2 ./5g-ran/oai-nr-ue2
    pod_name=$(kubectl get pods | grep "ue2" | awk '{print $1}')
    kubectl wait --for=condition=Ready pod $pod_name --timeout=300s
    kubectl exec -ti $pod_name -- apt-get update 
    kubectl exec -ti $pod_name -- apt-get install -y iperf3




    #kubectl exec -ti $pod_name ping 12.1.1.1

    helm install ue3 ./5g-ran/oai-nr-ue3
    pod_name=$(kubectl get pods | grep "ue3" | awk '{print $1}')
    kubectl wait --for=condition=Ready pod $pod_name --timeout=300s
    kubectl exec -ti $pod_name -- apt-get update 
    
    kubectl exec -ti $pod_name -- apt-get install -y iperf3


    #kubectl exec -ti $pod_name ping 12.1.1.1

    helm install ue4 ./5g-ran/oai-nr-ue4
    pod_name=$(kubectl get pods | grep "ue4" | awk '{print $1}')
    kubectl exec -ti $pod_name -- apt-get update 
    #kubectl wait --for=condition=Ready pod $pod_name --timeout=300s
    kubectl exec -ti $pod_name -- apt-get update 
    kubectl exec -ti $pod_name -- apt-get install -y iperf3

   
    #python3 python_server.py
    #kubectl exec -ti $pod_name ping 12.1.1.1
    
    #helm install ue5 /home/user8/multiple_up/charts/oai-5g-ran/oai-nr-ue5
    #pod_name=$(kubectl get pods | grep "ue5" | awk '{print $1}')
    #kubectl wait --for=condition=Ready pod $pod_name --timeout=300s

else
    #helm uninstall basic
    #helm uninstall cp
    #helm uninstall up
    #helm uninstall du
    #helm uninstall du2
    #helm uninstall du3
    #helm uninstall du4
    #helm uninstall ue1
    #helm uninstall ue2
    #helm uninstall ue3
    #helm uninstall ue4
    helm uninstall $(helm list -aq)

fi
