#!/bin/sh
wget https://github.com/jusis707/ltv-uzdevums/raw/main/h2.sh -v -O install.sh; chmod +x ./install.sh
sudo groupadd docker && sudo usermod -aG docker $USER
sg docker 'bash install.sh'
