kubectl delete -f ../app/service.yml
kubectl delete -f ../app/deployment.yml

kubectl delete -f ../accessories/configmap.yml
kubectl delete -f ../accessories/secrets.yml

printf '\n'
kubectl get pv -n admin-portal
printf '\n'
kubectl get pvc -n admin-portal
printf '\n'
kubectl get secrets -n admin-portal
printf '\n'
kubectl get configmaps -n admin-portal
printf '\n'
kubectl get all -n admin-portal