#!/bin/bash

# for mika
ssh-keygen -C "mika_admin" # cat the .pub key 

# for knights
nano /etc/ssh/sshd_config # change the passwordauthentication to no 
echo "PUBLIC-KEY" > .ssh/authorized_keys 
