#!/usr/bin/env bash

printf "##### Building project database image..."
docker build -t bonita-iocom ./java

printf "###Build Done!"

cd ..

printf "\n\n##### Cloning platform..."
git clone git@gitlab.com:bonita-platform/server.git


printf "\n\n##### Copying composer..."
cp bonita/java/docker-compose-hom.yml.sample docker-compose.yml


rm proxy.conf

echo "### Creating proxy.conf"
cat > proxy.conf <<EOL
server_tokens off;
client_max_body_size 200m;
EOL
echo " "

echo "
As last step you need to manually edit /etc/hosts 
in your PC (Mac and linux)

 127.0.0.1  prod.postgres.iocom.com
 127.0.0.1  prod.pgadminer.iocom.com
 127.0.0.1  prod.bonita.iocom.com/bonita

"

printf "\n\nAll done! Have a nice day!\n"

docker-compose up