#!bin/sh
cd /home/ec2-user/awards/compose
printf '\nremoving containers if present\n\n'
docker-compose -f docker-compose.yml down -v
printf '\ncreating containers\n\n'
docker-compose -f docker-compose.yml up -d
printf '\nrestarting app container\n'
sleep 30
docker restart awards-app-service
docker-compose ps