#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'
DIR=$(pwd)
DIR_PLAYBOOK="${DIR}/playbook"
bool=0

#Checking if the installation of ansible is necessary
if ! command -v ansible &> /dev/null
then
  echo -e "${YELLOW}Ansible is not installed, installation is in progress${NC}"
  sudo apt-get install -y ansible
  if ! command -v ansible &> /dev/null
  then
    echo -e "${RED}x Error during installation, EXIT${NC}"
    exit 1
  fi
  echo -e "${GREEN}✓ Ansible installation is successful${NC}"
else
  echo -e "Ansible is already ${GREEN}INSTALLED${NC}"
fi


#Check if you want to install the website
while [ $bool -eq 0 ]; do
  read -p "Would you like to run the ansible playbook to setup your website [yes/no] ?" ANSWER
  if [[ "$ANSWER" != "no" ]] && [[ "$ANSWER" != "yes" ]]
  then
    echo -e "Please enter ${GREEN}yes or no${NC}"
  else
    bool=1
  fi
done

#Installation of website or not
if [[ "$ANSWER" == "no" ]]
  then
    echo "Okay good bye !"
    exit 0
  else
    ansible-playbook "${DIR_PLAYBOOK}/install_website.yaml" --connection=local
fi
