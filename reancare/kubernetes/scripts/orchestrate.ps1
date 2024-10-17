Set-Location '~/desktop/inflection-zone/rean-foundation/services/devops/reancare/kubernetes/scripts'
# kubectl create namespace reancare
# kubens reancare
printf '\ndeleting manifest byproducts if present\n\n'
powershell -ExecutionPolicy Bypass './delete.ps1'
printf '\napplying manifest files\n\n'
powershell -ExecutionPolicy Bypass './apply.ps1'
# printf '\ninitiating browser service for application access\n\n'
# minikube service reancare-app-service -n reancare