#!/bin/bash

mkdir -p /var/wired/data 
chmod 777 /var/wired/data 

echo "Shared Directory Created"

useradd -d /var/wired/data -s /usr/sbin/nologin alice
echo "alice:alice123" | chpasswd
useradd -d /var/wired/data -s /usr/sbin/nologin mika 
echo "mika:mika123" | chpasswd
useradd -d /var/wired/data -s /usr/sbin/nologin eiri
echo "eiri:eiri123" | chpasswd

echo "Users Created"

cat << 'EOF' > /etc/vsftpd.conf     
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
allow_writeable_chroot=YES
user_config_dir=/etc/vsftpd_user_conf
userlist_enable=YES
userlist_file=/etc/vsftpd.user_list
userlist_deny=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO
EOF

echo "vsftpd config Updated"

mkdir -p /etc/vsftpd_user_conf

echo "User Configure Directory Created"

cat << 'EOF' > /etc/vsftpd_user_conf/alice     
write_enable=YES
download_enable=YES
EOF

cat << 'EOF' > /etc/vsftpd_user_conf/mika     
write_enable=NO
download_enable=YES
EOF

echo "Configured users"

echo "eiri" > /etc/vsftpd.user_list

echo "Banned Eiri"

chmod 555 /var/run/vsftpd/empty

grep -qxF '/usr/sbin/nologin' /etc/shells || echo '/usr/sbin/nologin' >> /etc/shells

service vsftpd restart || /etc/init.d/vsftpd restart 
