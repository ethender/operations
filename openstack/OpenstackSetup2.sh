#!/bin/bash
LOG_FILE='/var/log/openstack_automate.log'
#
# After reboot setup2
#
echo '#####################################' >> LOG_FILE
echo 'Openstack setup 2 has started' >> LOG_FILE
getenforce >> LOG_FILE

#installing openstack package
echo  '#######################################'
yum install -y centos-release-openstack-ocata >> LOG_FILE
echo 'opentstack octa has installed' >> LOG_FILE
echo 'updating opentack system' >> LOG_FILE
yum update -y >> LOG_FILE

#installing packstack
echo  '#######################################' >> LOG_FILE
echo 'It Will take n1-2 hours.' >> LOG_FILE
echo 'Have some patience.' >> LOG_FILE
echo 'After installation. Read the CLI_installation_guide.pdf file.' >> LOG_FILE
echo 'After installing check internet connectivity is there.' >> LOG_FILE
echo 'After modifiying the connectivity. Is any problem check /tempconfig for network configuration has backup' >> LOG_FILE

yum install -y openstack-packstack >> LOG_FILE

echo '###########################################' >> LOG_FILE
echo 'Ip Address Review' >> LOG_FILE
ip address show >> LOG_FILE


echo '#############################################' >> LOG_FILE
echo 'Installing Openstack setup' >> LOG_FILE
packstack --allinone --provision-demo=n --os-neutron-ovs-bridge-mappings=extnet:br-ex --os-neutron-ml2-type-drivers=vxlan,flat >> LOG_FILE


echo '############################################' >> LOG_FILE
echo 'Network Setup started' >> LOG_FILE
echo 'Enter Your Bridge Name ex - enp0s3' >> LOG_FILE
read -p "Enter network bridge name: " bridge
echo 'your network ip address ex- 192.168.1.200' >> LOG_FILE
read -p "Enter network IP Address : " ip
echo 'your network netmask ex- 255.255.255.0' >> LOG_FILE
read -p "Enter Netmask:" netmask
echo 'your network gateway ex- 192.168.1.1' >> LOG_FILE
read -p "GATEWAY: "gateway
sudo touch /etc/sysconfig/network-scripts/ifcfg-br-ex
br-ex=/etc/sysconfig/network-scripts/ifcfg-br-ex
sudo $br-ex >> 'DEVICE=br-ex'
sudo $br-ex >> 'DEVICETYPE=ovs'
sudo $br-ex >> 'TYPE=OVSBridge'
sudo $br-ex >> 'IPADDR=$ip'
sudo $br-ex >> 'NETMASK=$netmask'
sudo $br-ex >> 'GATEWAY=$gateway'
sudo $br-ex >> 'IPV4_FAILURE_FATAL=no'
sudo $br-ex >> 'IPV6INIT=no'
sudo $br-ex >> 'DNS1=8.8.8.8'
sudo $br-ex >> 'ONBOOT=yes'

echo "###############################################" >> LOG_FILE
echo 'Changed br-ex file'
cat $br-ex >> LOG_FILE

echo '###############################################' >> LOG_FILE
echo 'Changing bridge file' >> LOG_FILE
network-bridge=/etc/sysconfig/network-scripts/ifcfg-$bridge
sudo $network-bridge > 'TYPE=OVSPort'
sudo $network-bridge >> 'NAME=$bridge'
sudo $network-bridge >> 'DEVICE=$bridge'
sudo $network-bridge >> 'DEVICETYPE=ovs'
sudo $network-bridge >> 'OVS_BRIDGE=br-ex'
sudo $network-bridge >> 'ONBOOT=yes'
cat $network-bridge >> LOG_FILE
service network restart >> LOG_FILE

echo "INSTALLATION HAS BEEN COMPLETED. Please check keystonerc_admin file in userdirectory " >> LOG_FILE
