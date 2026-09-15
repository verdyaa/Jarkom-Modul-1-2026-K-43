#!/bin/bash
 apt update && apt install -y telnetd openbsd-inetd
 echo "telnet stream tcp nowait root /usr/sbin/tcpd /usr/sbin/telnetd" >> /etc/inetd.conf
 useradd -m -s /bin/bash phantom_user
  echo "phantom_user:wired_ghost" | chpasswd

/etc/init.d/openbsd-inetd start

# /etc/init.d/openbsd-inetd stop
