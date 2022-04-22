# pluginnode-install

# This is a autoinstall of the goplugin $PLI decentralised oracle node.

#Must be installed in /root directory.

#This install covers:
  - golang
  - Docker
  - Postgresql db
  - Node
  - External initiator
  - Functions:
    - autoreboot
    - password prompt
    - logrotate

#Credit mentions:
 - nmzn - Creator of orginal docker install.

# Please take note:
- "./install_node.sh" does not include the docker installation. If you have no Docker installed on your VPS you need to first run:
-  "./install_docker.sh"

Guide on how to deploy Contracts: https://github.com/nmzn/deployment-guide

Contents:

  ##install_docker.sh

  - This is a small Script that installs docker for you.
  
  ##install_node.sh
  
  - This is the main Install Script that will install the plugin Node including the external initiator.
      
    
  Step 1:
      
          
    sudo git clone https://github.com/HanzgitH/pluginnode-install.git && cd pluginnode-install && sudo chmod +x install_docker.sh && sudo chmod +x install_node.sh
      
  
  Step 2 (optional if needed):
      
    ./install_docker.sh
  
  Step 3:
  
    ./install_node.sh
          
    
   #This does not include any changings to your Firewall you may need to apply in order for the node to run correctly. 
    
   #Important
   
   Keep in mind that you still have to do the Oracle Contract deployment part wich you find here: https://docs.goplugin.co
   
