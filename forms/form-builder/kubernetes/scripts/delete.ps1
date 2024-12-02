kubectl delete -f ../app/service.yml
kubectl delete -f ../app/deployment.yml

kubectl delete -f ../accessories/configmap.yml
kubectl delete -f ../accessories/secrets.yml

printf '\n'
kubectl get pv -n forms
printf '\n'
kubectl get pvc -n forms
printf '\n'
kubectl get secrets -n forms
printf '\n'
kubectl get configmaps -n forms
printf '\n'
kubectl get all -n forms