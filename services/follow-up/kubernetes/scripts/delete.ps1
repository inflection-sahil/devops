kubectl delete -f ../app/deployment.yml
kubectl delete -f ../app/service.yml

kubectl delete -f ../mongo-express/deployment.yml
kubectl delete -f ../mongo-express/service.yml

kubectl delete -f ../mongo/deployment.yml
kubectl delete -f ../mongo/service.yml
kubectl delete -f ../mongo/pvc.yml
kubectl delete -f ../mongo/pv.yml

kubectl delete -f ../accessories/configmap.yml
kubectl delete -f ../accessories/secrets.yml

printf '\n'
kubectl get pv -n follow-up
printf '\n'
kubectl get pvc -n follow-up
printf '\n'
kubectl get secrets -n follow-up
printf '\n'
kubectl get configmaps -n follow-up
printf '\n'
kubectl get all -n follow-up