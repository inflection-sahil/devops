kubectl delete -f ../app/service.yml
kubectl delete -f ../app/deployment.yml

kubectl delete -f ../mysql/service.yml
kubectl delete -f ../mysql/deployment.yml
kubectl delete -f ../mysql/pvc.yml
kubectl delete -f ../mysql/pv.yml

kubectl delete -f ../accessories/configmap.yml
kubectl delete -f ../accessories/secrets.yml

printf '\n'
kubectl get pv -n careplan
printf '\n'
kubectl get pvc -n careplan
printf '\n'
kubectl get secrets -n careplan
printf '\n'
kubectl get configmaps -n careplan
printf '\n'
kubectl get all -n careplan