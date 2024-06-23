helm uninstall ue2
sleep 10
#pod_name=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "ue2" | head -n 1)
#kubectl wait --for=delete pod $pod_name --timeout=300s


helm install ue2 5g-ran/oai-nr-ue2
#helm install ue3 5g-ran/oai-nr-ue3
#helm install ue4 5g-ran/oai-nr-ue4


pod_name=$(kubectl get pods | grep "ue2" | awk '{print $1}')
kubectl wait --for=condition=Ready pod $pod_name --timeout=300s
kubectl exec -ti $pod_name ping 12.1.1.1

