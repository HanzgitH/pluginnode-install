###Install Script for plugin nodes via Docker.

echo -e "\n\n## Plugin Docker Install -- https://goplugin.co -- created by nmzn (Twitter @itsnmzn) 01/2022\n and contributed by Hanz - (Twitter - @DeFi_Jon)"
echo -e "\n\n## Please make sure to read the readme.md after installing"
echo -e "## Version 0.3 \n\n"

sleep 3

echo
echo -e "\n\n################# Updating System #################\n\n"

sudo apt update && sudo apt upgrade -y 

wait

echo
echo -e "\n\n################# Installing golang #################\n\n"

sudo apt-get install golang -y && sudo apt update && sleep 5

echo -e "\n\n################# Changing Directory #################\n\n"

sudo mkdir -p /opt/docker/goplugin
cd /opt/docker/goplugin

echo -e "\n\n################# Getting git repositories #################\n\n" && sleep 1

sudo git clone -b docker_branch_v1 https://github.com/GoPlugin/plugin-deployment.git && cd plugin-deployment/ && sleep 10

cp /root/pluginnode-install/docker-compose.yaml /opt/docker/goplugin/plugin-deployment && sleep 5

echo -e "\n\n################# Installing latest docker compose #################\n\n"

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo -e "\n\n################# Changing Credentials #################\n\n"
echo
#### Node Login Credentials ###

     echo -e "Please type an Email adress to login to your node. Doesnt need to be related to the plugin login."
     echo
     until [[ "$mail" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$ ]]
     do
     echo
     read -p "Enter a valid Mail adress: " mail
     done
     echo
     echo "Mail adress is valid."
     echo
echo
while true; do
    echo "Please type a Password for your node login. (At least 7 characters with 2 upper case characters, 2 lower case characters, 2 digits and 1 special character."
    echo
    read -s -p "Enter Password: "  nodepw
    echo
    echo

    FAIL=no

    # 7 characters
    [[ ${#nodepw} -ge 7 ]] || FAIL=yes

    # 2 upper case letters
    echo $nodepw | grep -q "[A-Z].*[A-Z]" || FAIL=yes

    # 2 lower case letters
    echo $nodepw | grep -q "[a-z].*[a-z]" || FAIL=yes

    # 2 digits
    echo $nodepw | grep -q "[0-9].*[0-9]" || FAIL=yes

    # 1 non-alphanumeric character (no spaces)
    echo $nodepw | grep -q "[^a-zA-Z0-9]" || FAIL=yes

    [[ ${FAIL} == "no" ]] && break

    echo "Password invalid"
    echo
done

echo "Node Password is valid"
echo

### Postgres Password ###
echo
while true; do
    echo "Please type a Password for your Postgres Database. At least 4 characters with 1 Upper case, 1 lower case character and 1 digit. No Special Characters!"
    echo
    read -s -p "Enter Password: " pgrspw
    echo
    echo

    FAIL=no

    # 4 characters
    [[ ${#pgrspw} -ge 4 ]] || FAIL=yes

    # 1 upper case letters
    echo $pgrspw | grep -q "[A-Z]" || FAIL=yes

    # 1 lower case letters
    echo $pgrspw | grep -q "[a-z]" || FAIL=yes

    # 1 digits
    echo $pgrspw | grep -q "[0-9]" || FAIL=yes

    [[ ${FAIL} == "no" ]] && break

    echo "Postgres Password invalid"
    echo
done

echo "Postgres Password is valid"
echo

### Keystore Password ###
echo
while true; do
    echo "Please type your Keystore Password."
    echo "Password must be LONGER than 12 characters contain at least 3 upper case characters, 3 lower case characters, 3 numbers and 3 special characters (no spaces)"
    echo
    read -s -p "Enter Password: " kstpw
    echo
    echo

    FAIL=no

    # 12 characters
    [[ ${#kstpw} -ge 13 ]] || FAIL=yes

    # 3 upper case letters
    echo $kstpw | grep -q "[A-Z].*[A-Z].*[A-Z]" || FAIL=yes

    # 3 lower case letters
    echo $kstpw | grep -q "[a-z].*[a-z].*[a-z]" || FAIL=yes

    # 3 digits
    echo $kstpw | grep -q "[0-9].*[0-9].*[0-9]" || FAIL=yes

    # 3 non-alphanumeric character (no spaces)
    echo $kstpw | grep -q "[^a-zA-Z0-9].*[^a-zA-Z0-9].*[^a-zA-Z0-9]" || FAIL=yes

    [[ ${FAIL} == "no" ]] && break

    echo "Password invalid"
    echo
done

echo "Keystore Password is valid"
echo

echo -e "\nSetting Postgres Password"

sudo sed -i "s/plugin1234/$pgrspw/g"  plugin.env ei.env
sudo sed -i "s/plugin1234/$pgrspw/g"  docker-compose.yaml
sudo sed -i "s/\postgres\b/dbuser/g" plugin.env
sudo sed -i "s/\postgres\b/dbuser/g" ei.env
sudo sed -i "s|"172.17.0.1"|psql_node|g" plugin.env
sudo sed -i "s|"172.17.0.1"|psql_ei|g" ei.env

echo
echo -e "Done..."

echo -e "\nSetting api Credentials"

sudo sed -i d .env.apicred
sudo sh -c 'echo "mail@mail.com" > .env.apicred'
sudo sh -c 'echo "mailpw" >> .env.apicred'
sudo sed -i "s/mail\@mail.com/$mail/g" .env.apicred
sudo sed -i "s/mailpw/$nodepw/g" .env.apicred
echo
echo -e "Done..."

echo -e "\nSetting Keystore Password"

sudo sed -i d .env.password
sudo sh -c 'echo "keystore" > .env.password'
sudo sed -i "s/keystore/$kstpw/g" .env.password
echo
echo -e "Done..."

echo -e "\n\n############ Updating RPC and WS information  ##########\n\n" && sleep 5
sudo sed -i -e "s/plirpc.blocksscan.io/pliws.xdcrpc.com/g" /opt/docker/goplugin/plugin-deployment/startEI.sh
sudo sed -i -e "s/pluginws.blocksscan.io/pliws1.xdcrpc.com/g" /opt/docker/goplugin/plugin-deployment/plugin.env
sudo sed -i -e "/PLUGIN_TLS_PORT=0/d" /opt/docker/goplugin/plugin-deployment/plugin.env
sudo sed -i -e "/SECURE_COOKIES=false/d" /opt/docker/goplugin/plugin-deployment/plugin.env

#echo -e "\n\n################# Making directory for tls and creating .crt files #################\n\n"

#sudo mkdir -p /opt/docker/goplugin/plugin-deployment/tls && cd /opt/docker/goplugin/plugin-deployment/tls && sleep 5

#openssl req -x509 -out  server.crt  -keyout server.key \
  #-newkey rsa:2048 -nodes -sha256 -days 365 \
  #-subj '/CN=localhost' -extensions EXT -config <( \
  # printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth") && wait

sleep 10

#echo -e "\n\n################# Adding external-adapter folder #################\n\n"

#cd /opt/docker/goplugin/plugin-deployment && sudo mkdir -p external-adapters && sleep 1

#echo "TLS_CERT_PATH=/Plugin/server.crt
#TLS_KEY_PATH=/Plugin/server.key" >> plugin.env

echo -e "\n\n################# Bringing up node  #################\n\n"

sudo docker-compose up -d && sleep 10

echo -e "\n\n################# Awaiting connection for pgsql db #################\n\n"

until docker container exec -it psql_ei pg_isready; do
    >&2 echo "Postgres is starting, awating connection please wait"
sleep 5
done

echo -e "\n\n################# Starting Node #################\n\n"

sudo docker exec -it plinode /bin/bash -c ". ~/.profile && pm2 start /pluginAdm/startNode.sh"
echo
echo -e "Waiting for Node to come up... (15 Seconds)"

sleep 15

echo
echo -e "\n\n################# Installing External Initiators (10 seconds) #################\n\n"

sleep 10

sudo docker exec -it plinode /bin/bash -c ". ~/.profile && plugin admin login -f /pluginAdm/.env.apicred" &&
JOBKEYS=$(sudo docker exec -it plinode /bin/bash -c ". ~/.profile && plugin initiators create pluginei http://localhost:8080/jobs" | grep pluginei) &&
sudo sh -c "echo $JOBKEYS > eivar.env"

ICACCESSKEY=$(echo $JOBKEYS | sed 's/\ //g' | awk -F"║" '{print $4};')
ICSECRET=$(echo $JOBKEYS | sed 's/\ //g' | awk -F"║" '{print $5};')
CIACCESSKEY=$(echo $JOBKEYS | sed 's/\ //g' | awk -F"║" '{print $6};')
CISECRET=$(echo $JOBKEYS | sed 's/\ //g' | awk -F"║" '{print $7};')

sudo sed -i "s|"cc763c8ca9fe48508883f6d39f818ccf"|$ICACCESSKEY|g" ei.env
sudo sed -i "s|"jEG8wzejfexfjAeZWBy8SzS7XV+SfV22j0eq7CEnyc6SSsd35PtQlESP2RhYs1am"|$ICSECRET|g" ei.env
sudo sed -i "s|"pKgKE+XNYbU2FRX207LObetsCx56bGPXenU3XpUelAdRb73bXBE22tSLjPviRUav"|$CIACCESSKEY|g" ei.env
sudo sed -i "s|"FXllNVlkD8ADVjFr46teIGRaeWEZXsYVQRMdfmu+UmRV4aysZ30E/OkNadysLZsA"|$CISECRET|g" ei.env

sudo docker exec --env-file ei.env -it plinode /bin/bash -c ". ~/.profile && pm2 start /pluginAdm/startEI.sh"

echo -e "\n\n################# Adding logrotate to docker, this will compress and delete logs every 7 days #################\n\n"

sleep 5

sudo docker exec -it plinode /bin/bash -c "apt-get install logrotate -y" &&
sudo docker cp /root/pluginnode-install/pm2logs plinode:/etc/logrotate.d/pm2logs &&
sudo docker cp /root/pluginnode-install/log.jsonl plinode:/etc/er.d/log.jsonl &&
echo -e "\n\n################# Creating service for automatic startup after reboot #################\n\n"

cp /root/pluginnode-install/nodeboot.sh /usr/local/sbin/
chmod +x /usr/local/sbin/nodeboot.sh
cp /root/pluginnode-install/nodeboot.service /etc/systemd/system/nodeboot.service
chmod +x /etc/systemd/system/nodeboot.service
systemctl enable nodeboot.service
systemctl daemon-reload


echo -e "\n\n################# Node Setup completed. Oracle Deployment Part has to be done manually. Please see: https://docs.goplugin.co for further information #################\n\n"

echo -e "\n\n################# All docker files are saved in /opt/docker/goplugin/plugin-deployment #################\n\n"

echo -e "\n\n################# Use https://IP:6689 to login node dashboard #################\n\n"
