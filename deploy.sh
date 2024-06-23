helm uninstall du2
helm uninstall du3
helm uninstall du4

#helm uninstall  oai-spgwu-tiny
helm uninstall cp

pod_name=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "cu-cp" | head -n 1)
kubectl wait --for=delete pod $pod_name --timeout=300s


helm uninstall ue2
helm uninstall up
helm install  oai-spgwu-tiny 5g-core/oai-5g-spawn/
helm install cp 5g-ran/oai-cu-cp
helm install up 5g-ran/oai-cu-up
helm install du2 5g-ran/oai-du2
#helm install du3 5g-ran/oai-du3
#helm install du4 5g-ran/oai-du4




# Find a pod whose name contains 'du2'
pod_name=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "du2" | head -n 1)
kubectl wait --for=condition=Ready pod $pod_name --timeout=300s

# Check if the pod was found
#if [ -z "$pod_name" ]; then
#    echo "No pod found with name containing 'du2'"
#    exit 1
#fi
pod_name=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "cu-cp" | head -n 1)
kubectl wait --for=condition=Ready pod $pod_name --timeout=300s

echo "Wait to print"
# Follow the logs and search for the specific line
kubectl logs $pod_name --follow | grep -m 1 "oai-du-rfsim2" 
#| while read line
#do
#    echo "Log line found: $line"
    # Perform any action when the log line is found
    # For instance, you can break out of the loop if only one occurrence is needed
    # break
#done
#sleep 3
helm install ue2 5g-ran/oai-nr-ue2
#helm install ue3 5g-ran/oai-nr-ue3
#helm install ue4 5g-ran/oai-nr-ue4
sleep 10
pod_name=$(kubectl get pods | grep "ue2" | awk '{print $1}')
#kubectl wait --for=condition=Ready pod $pod_name --timeout=300s
#kubectl exec -ti $pod_name ping 12.1.1.1

