kubectl apply -f ../accessories/secrets.yml
kubectl apply -f ../accessories/configmap.yml

kubectl apply -f ../app/deployment.yml
kubectl apply -f ../app/service.yml

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