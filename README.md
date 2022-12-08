# pluginnode-install

# This is a autoinstall of the goplugin $PLI decentralised oracle node.

#Must be installed in `/root` directory.

#This install and update covers:
  - golang
  - Docker
  - Postgresql db
  - Node
  - External initiator
  - Functions:
    - autoreboot
    - password prompt
    - logrotate
    - https

#Credit mentions:
 - nmzn - Creator of orginal auto docker install.

# Please take note:
- "./install_node.sh" does not include the docker installation. If you have no Docker installed on your VPS you need to first run:
-  "./install_docker.sh"

Guide on how to deploy Contracts: https://github.com/nmzn/deployment-guide

Contents:

  - "./install_docker.sh"

    - This is a small Script that installs docker for you.
  
  - "./install_node.sh"
  
    - This is the main Install Script that will install the plugin Node including the external initiator and all functions mentioned in the README.

  - "./install_node_apothem.sh"

    - This is the apothem testnet setup for a node, use for development and general testing that is on the apothem network.
      
Before installation please install git:

    sudo apt-get install git
    
  Step 1:
      
          
    sudo git clone https://github.com/HanzgitH/pluginnode-install.git && cd pluginnode-install && sudo chmod +x install_docker.sh && sudo chmod +x install_node.sh && sudo chmod +x install_node_apothem.sh
      
  
  Step 2 (optional if needed):
      
    ./install_docker.sh
  
  Step 3a, this will install the node, the update will need to be run once the node installation is complete.
  
    ./install_node.sh
    
  Step 3b (only use if you wish to install a test node on apothem test network)
          
    ./install_node_apothem.sh   
    
    
## Important
   
   Keep in mind that you still have to do the Oracle Contract deployment part wich you find here: https://docs.goplugin.co
   
   This install does not include any changings to your Firewall you may need to apply in order for the node to run correctly.

Once completd this will include updated RPC:

## After installation move to the update section for TLS:

  To enable TLS go to the update section, `https://github.com/HanzgitH/plugin_update` and after the gitpull run the `./update` file ONLY from your `/home` directory, the RPC is already up to date in the current install.
  
#### If you already have a running node and need to update RPC complete the entire update process.

### Disclaimer:

This install is to assist and autosetup of the $PLI node, it is essential that each user is aware of maintenance of each node as well as securing a VPS.

Securing VPS is not included in this guide.

I use this as my personal install of $PLI nodes and is free to share and use at each individual's discression, I take no personal responsibility for the use, distribution and implementation of this install.

It is highly recommeneded to run a test on a none-approved node, if any issues arise from an update or edit, this can be easily fixed before commiting to a working, approved node.

#NodeLife 

Hanz @DeFi_Jon
