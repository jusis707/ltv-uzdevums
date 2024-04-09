#!/bin/sh
sudo groupadd docker && sudo usermod -aG docker $USER
sg docker 'bash install.sh'
