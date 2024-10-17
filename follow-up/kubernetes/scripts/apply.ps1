kubectl apply -f ../accessories/secrets.yml
kubectl apply -f ../accessories/configmap.yml

kubectl apply -f ../mongo/pv.yml
kubectl apply -f ../mongo/pvc.yml
kubectl apply -f ../mongo/deployment.yml
kubectl apply -f ../mongo/service.yml

kubectl apply -f ../mongo-express/deployment.yml
kubectl apply -f ../mongo-express/service.yml

Start-Sleep 60

kubectl apply -f ../app/deployment.yml
kubectl apply -f ../app/service.yml

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