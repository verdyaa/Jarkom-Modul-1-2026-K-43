## Configure Nodes 
### Lain
```
auto eth0
iface eth0 inet dhcp
up sysctl -w net.ipv4.ip_forward=1
up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE <-- lihat kebawah kenapa butuh 
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth2 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth3 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT

auto eth1
iface eth1 inet static
address 10.10.1.1
netmask 255.255.255.0

auto eth2
iface eth2 inet static
address 10.10.2.1
netmask 255.255.255.0

auto eth3
iface eth3 inet static
address 10.10.3.1
netmask 255.255.255.0
```
### Alice 
```
auto eth0
iface eth0 inet static
address 10.10.1.2
netmask 255.255.255.0
gateway 10.10.1.1
```
### Mika
```
auto eth0
iface eth0 inet static
address 10.10.1.3 # Perhatikan angkanya.
netmask 255.255.255.0
gateway 10.10.1.1
```
### Chisa
```
auto eth0
iface eth0 inet static
address 10.10.2.2
netmask 255.255.255.0
gateway 10.10.2.1
```
### Knights
```
auto eth0
iface eth0 inet static
address 10.10.2.2
netmask 255.255.255.0
gateway 10.10.2.1
```

### Eiri 
```
auto eth0
iface eth0 inet static
address 10.10.3.2
netmask 255.255.255.0
gateway 10.10.3.1
```
## NAT and Port Forwading
Put this DNS resolver in every node
```bash 
echo << "EOF" >> /root/.bashrc
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "done bang"
```

## Knights FTP 
filter
```plaintext
ftp.request.command contains "STOR" or ftp.response.code == 226 or ftp-data.command
```
## ICMP Analysis
pake filter ```icmp.type contains "reply" and icmp.code``` dan ```icmp.type contains "request" and icmp.code``` 

### Analisis Packet Loss & RTT 
setelah menjalankan 
```bash
ping -c 77 -s 128 -i 0.3 <IP_Chisa>
```
kita mendapatkan
```plaintext
--- 10.10.2.2 ping statistics ---
77 packets transmitted, 77 received, 0% packet loss, time 23099ms
rtt min/avg/max/mdev = 0.366/0.681/1.036/0.125 ms
```
