#!/bin/bash

echo -e "\n\n################# Installing External Initiators #################\n\n"

echo
echo -e "\n\n################# Creating name:pluginei and mainnet:pluginei to http://localhost:8080/jobs #################\n\n

cd /opt/docker/goplugin/plugin-deployment

sudo docker exec -it plinode /bin/bash -c ". ~/.profile && plugin admin login -f /pluginAdm/.env.apicred" &&

JOBKEYS=$(sudo docker exec -it plinode /bin/bash -c ". ~/.profile && plugin initiators create pluginei http://localhost:8080/jobs" | grep pluginei) &&
sudo sh -c "echo $JOBKEYS > eivar.env" &&

ICACCESSKEY=$(echo $JOBKEYS | sed 's/\ //g' | awk -F"║" '{print $4};') 
ICSECRET=$(echo $JOBKEYS | sed 's/\ //g' | awk -F"║" '{print $5};') 
CIACCESSKEY=$(echo $JOBKEYS | sed 's/\ //g' | awk -F"║" '{print $6};') 
CISECRET=$(echo $JOBKEYS | sed 's/\ //g' | awk -F"║" '{print $7};') 

sudo sed -i "s|"cc763c8ca9fe48508883f6d39f818ccf"|$ICACCESSKEY|g" ei.env
sudo sed -i "s|"jEG8wzejfexfjAeZWBy8SzS7XV+SfV22j0eq7CEnyc6SSsd35PtQlESP2RhYs1am"|$ICSECRET|g" ei.env
sudo sed -i "s|"pKgKE+XNYbU2FRX207LObetsCx56bGPXenU3XpUelAdRb73bXBE22tSLjPviRUav"|$CIACCESSKEY|g" ei.env
sudo sed -i "s|"FXllNVlkD8ADVjFr46teIGRaeWEZXsYVQRMdfmu+UmRV4aysZ30E/OkNadysLZsA"|$CISECRET|g" ei.env &&

sleep 5

sudo docker exec --env-file ei.env -it plinode /bin/bash -c ". ~/.profile && pm2 restart 1 /pluginAdm/startEI.sh" &&

sleep 5

echo -e "\n\n################# Adding logrotate to docker, this will compress and delete logs every 7 days #################\n\n"

sudo docker exec -i plinode /bin/bash -c "apt-get install logrotate -y" &&
sudo docker cp /root/pluginnode-install/pm2logs plinode:/etc/logrotate.d/pm2logs &&
sudo docker cp /root/pluginnode-install/log.jsonl plinode:/etc/logrotate.d/log.jsonl &&

echo -e "\n\n################# Creating service for automatic startup after reboot #################\n\n"

cp /root/pluginnode-install/nodeboot.sh /usr/local/sbin/
chmod +x /usr/local/sbin/nodeboot.sh
cp /root/pluginnode-install/nodeboot.service /etc/systemd/system/nodeboot.service
chmod +x /etc/systemd/system/nodeboot.service
systemctl enable nodeboot.service
systemctl daemon-reload


echo -e "\n\n################# Done #################\n\n"

echo -e "\n\n################# Node Setup completed. Oracle Deployment Part has to be done manually. Please see: https://docs.goplugin.co for further information #################\n\n"

echo -e "\n\n################# All docker files are saved in /opt/docker/goplugin/plugin-deployment #################\n\n"
