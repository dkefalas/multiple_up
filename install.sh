#!/bin/bash

# Check if the first argument is "install"
if [ "$1" = "install" ]; then
    # Execute the series of helm install commands
    #helm install basic /home/user8/multiple_up/charts/oai-5g-core/oai-5g-basic/
    #/home/user8/multiple_up/oai-cn5g-fed_v01/charts/oai-5g-core/oai-5g-basic
    sudo helm spray /home/user8/multiple_up_core/oai-cn5g-fed_v01/charts/oai-5g-core/oai-5g-basic
    #sudo helm spray /home/user8/multiple_up/oai-cn5g-fed_v01/charts/oai-5g-core/oai-5g-basic


    #sleep 30
    helm install cp /home/user8/multiple_up/charts/oai-5g-ran/oai-cu-cp
    sleep 10
    pod_name=$(kubectl get pods | grep "oai-cu-cp" | awk '{print $1}')
    kubectl wait --for=condition=Ready pod $pod_name --timeout=300s

    helm install up /home/user8/multiple_up/charts/oai-5g-ran/oai-cu-up
    #helm install up2 /home/user8/multiple_up/charts/oai-5g-ran/oai-cu-up2

    sleep 60
    helm install du /home/user8/multiple_up_core/charts/oai-5g-ran/oai-du
    helm install du2 /home/user8/multiple_up/charts/oai-5g-ran/oai-du2
    helm install du3 /home/user8/multiple_up/charts/oai-5g-ran/oai-du3
    helm install du4 /home/user8/multiple_up/charts/oai-5g-ran/oai-du4
    #helm install du5 /home/user8/multiple_up/charts/oai-5g-ran/oai-du5

    sleep 20
    #pod_name=$(kubectl get pods | grep "oai-du4" | awk '{print $1}')
    #kubectl wait --for=condition=Ready pod $pod_name --timeout=300s
    
    #pod_name=$(kubectl get pods | grep "upf" | awk '{print $1}')
    #kubectl exec -ti $pod_name apt-get update 
    #kubectl exec -ti $pod_name apt-get install iperf
    sleep 10

    helm install ue1 /home/user8/multiple_up_core/charts/oai-5g-ran/oai-nr-ue
    pod_name=$(kubectl get pods | grep "ue-" | awk '{print $1}')
    kubectl wait --for=condition=Ready pod $pod_name --timeout=300s
    kubectl exec -ti $pod_name ping 12.1.1.1
    helm install ue2 /home/user8/multiple_up/charts/oai-5g-ran/oai-nr-ue2
    pod_name=$(kubectl get pods | grep "ue2" | awk '{print $1}')
    kubectl wait --for=condition=Ready pod $pod_name --timeout=300s
    kubectl exec -ti $pod_name ping 12.1.1.1

    helm install ue3 /home/user8/multiple_up/charts/oai-5g-ran/oai-nr-ue3
    pod_name=$(kubectl get pods | grep "ue3" | awk '{print $1}')
    kubectl wait --for=condition=Ready pod $pod_name --timeout=300s
    kubectl exec -ti $pod_name ping 12.1.1.1

    helm install ue4 /home/user8/multiple_up/charts/oai-5g-ran/oai-nr-ue4
    pod_name=$(kubectl get pods | grep "ue4" | awk '{print $1}')
    kubectl wait --for=condition=Ready pod $pod_name --timeout=300s
    kubectl exec -ti $pod_name ping 12.1.1.1
    
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
    sudo helm uninstall $(helm list -aq )

fi

