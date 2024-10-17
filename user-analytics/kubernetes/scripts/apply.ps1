kubectl apply -f ../accessories/secrets.yml
kubectl apply -f ../accessories/configmap.yml

kubectl apply -f ../mysql/pv.yml
kubectl apply -f ../mysql/pvc.yml
kubectl apply -f ../mysql/deployment.yml
kubectl apply -f ../mysql/service.yml

kubectl apply -f ../zipkin/deployment.yml
kubectl apply -f ../zipkin/service.yml

Start-Sleep 60

kubectl apply -f ../app/deployment.yml
kubectl apply -f ../app/service.yml

printf '\n'
kubectl get pv -n user-analytics
printf '\n'
kubectl get pvc -n user-analytics
printf '\n'
kubectl get secrets -n user-analytics
printf '\n'
kubectl get configmaps -n user-analytics
printf '\n'
kubectl get all -n user-analytics