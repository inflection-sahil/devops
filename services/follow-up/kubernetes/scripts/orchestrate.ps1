Set-Location '~/desktop/inflection-zone/rean-foundation/services/follow-up/kubernetes/scripts'
kubectl create namespace follow-up
kubens follow-up
printf '\ndeleting manifest byproducts if present\n\n'
powershell -ExecutionPolicy Bypass './delete.ps1'
printf '\napplying manifest files\n\n'
powershell -ExecutionPolicy Bypass './apply.ps1'
# printf '\ninitiating browser service for application access\n\n'
# minikube service follow-up-app-service -n follow-up