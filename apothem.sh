#!/bin/bash
echo -e "This will replace the files withing the docker container to allow the node set up to be used in testnet on the apothem network"
sudo sed -i -e "s/plirpc.blocksscan.io/rpc.apothem.network/g" /opt/docker/goplugin/plugin-deployment/startEI.sh
sudo sed -i -e "s/ETH_CHAIN_ID=50/ETH_CHAIN_ID=51/g" /opt/docker/goplugin/plugin-deployment/plugin.env
sudo sed -i -e "s/pluginws.blocksscan.io/ws.apothem.network/g" /opt/docker/goplugin/plugin-deployment/plugin.env
sudo sed -i -e "s/0xff7412ea7c8445c46a8254dfb557ac1e48094391/0x33f4212b027e22af7e6ba21fc572843c0d701cd1/g" /opt/docker/goplugin/plugin-deployment/plugin.env

echo -e "For test XDC use the following link - https://apothem.network/#getTestXDC"
echo -e "For test PLI use the following link - https://faucet.goplugin.co/" 
