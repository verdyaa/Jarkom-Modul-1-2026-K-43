#!/bin/bash
ssh-keygen -C "mika_admin"
echo "ssh key generated"
cat .ssh/id_ed25519.pub
echo "copy that ssh key and paste it on pub @ knights"
