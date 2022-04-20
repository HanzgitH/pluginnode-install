# pluginnode-install

#This is a work around until the new docker install is released by the team.

#Must be installed in /root directory.

#autoreboot and logrotate added, also sleep time added, this was to allow the job creation to take place, so the echo has time to capture the information.

#New startEI.sh added, this fixes the RPC syntax error located in startEI.sh, which caused the external initiator to error.

#Credit goes to nmzn who created the majority of this install.

# Please take note that the "./install_node.sh" does not include the docker installation. If you have no Docker installed on your VPS you need to run the "./install_docker.sh" first

Guide on how to deploy Contracts: https://github.com/nmzn/deployment-guide

Contents:

  ##install_docker.sh

    This is a small Script that installs docker for you.
  
  ##install_node.sh
  
    This is the main Install Script that will install the plugin Node including the external initiator.
      
    
  Step 1:
      
          
    sudo git clone https://github.com/HanzgitH/pluginnode-install.git && cd pluginnode-install && sudo chmod +x install_docker.sh && sudo chmod +x install_node.sh
      
  
  Step 2 (optional if needed):
      
    ./install_docker.sh
  
  Step 3:
  
    ./install_node.sh
          
    
   #This does not include any changings to your Firewall you may need to apply in order for the node to run correctly. 
    
   #Important
   
   Keep in mind that you still have to do the Oracle Contract deployment part wich you find here: https://docs.goplugin.co
   
