Set-Location '~/desktop/inflection-zone/rean-foundation/services/awards/kubernetes/scripts'
kubectl create namespace awards
kubens awards
printf '\ndeleting manifest byproducts if present\n\n'
powershell -ExecutionPolicy Bypass './delete.ps1'
printf '\napplying manifest files\n\n'
powershell -ExecutionPolicy Bypass './apply.ps1'
# printf '\ninitiating browser service for application access\n\n'
# minikube service awards-app-service -n awards