#!/bin/bash

echo << "EOF" > /etc/ssh/sshd_config
Include /etc/ssh/sshd_config.d/*.conf
PasswordAuthentication no
KbdInteractiveAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_* COLORTERM NO_COLOR
Subsystem	sftp	/usr/lib/openssh/sftp-server
EOF
cat /etc/ssh/sshd_config
echo "Configured"

cat pub > .ssh/authorized_keys
