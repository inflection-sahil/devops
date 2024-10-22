Set-Location '~/desktop/rean-foundation/services/careplan/compose'
printf '\nremoving containers if present\n\n'
docker-compose -f docker-compose.yml down -v
printf '\ncreating containers\n\n'
docker-compose -f docker-compose.yml up -d
printf '\nrestarting app container\n'
Start-Sleep 30
docker restart careplan-app-service
docker-compose ps