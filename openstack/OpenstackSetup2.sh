#!/bin/bash
LOG_FILE='/var/log/openstack_automate.log'
#
# After reboot setup2
#
echo '#####################################' >> $LOG_FILE
echo 'Openstack setup 2 has started' >> $LOG_FILE
getenforce >> $LOG_FILE

#installing openstack package
echo  '#######################################'
yum install -y centos-release-openstack-ocata >> $LOG_FILE
echo 'opentstack octa has installed' >> $LOG_FILE
echo 'updating opentack system' >> $LOG_FILE
yum update -y >> $LOG_FILE

#installing packstack
echo  '#######################################' >> $LOG_FILE
echo 'It Will take n1-2 hours.' >> $LOG_FILE
echo 'Have some patience.' >> $LOG_FILE
echo 'After installation. Read the CLI_installation_guide.pdf file.' >> $LOG_FILE
echo 'After installing check internet connectivity is there.' >> $LOG_FILE
echo 'After modifiying the connectivity. Is any problem check /tempconfig for network configuration has backup' >> $LOG_FILE

yum install -y openstack-packstack >> $LOG_FILE

echo '###########################################' >> $LOG_FILE
echo 'Ip Address Review' >> $LOG_FILE
ip address show >> $LOG_FILE


echo '#############################################' >> $LOG_FILE
echo 'Installing Openstack setup' >> $LOG_FILE
packstack --allinone --provision-demo=n --os-neutron-ovs-bridge-mappings=extnet:br-ex --os-neutron-ml2-type-drivers=vxlan,flat >> $LOG_FILE


echo '############################################' >> $LOG_FILE
echo 'Network Setup started' >> $LOG_FILE
echo 'Enter Your Bridge Name ex - enp0s3' >> $LOG_FILE
read -p "Enter network bridge name: " bridge
echo 'your network ip address ex- 192.168.1.200' >> $LOG_FILE
read -p "Enter network IP Address : " ip
echo 'your network netmask ex- 255.255.255.0' >> $LOG_FILE
read -p "Enter Netmask:" netmask
echo 'your network gateway ex- 192.168.1.1' >> $LOG_FILE
read -p "GATEWAY: "gateway
touch /etc/sysconfig/network-scripts/ifcfg-br-ex
br-ex=/etc/sysconfig/network-scripts/ifcfg-br-ex
$br-ex >> 'DEVICE=br-ex'
$br-ex >> 'DEVICETYPE=ovs'
$br-ex >> 'TYPE=OVSBridge'
$br-ex >> 'IPADDR=$ip'
$br-ex >> 'NETMASK=$netmask'
$br-ex >> 'GATEWAY=$gateway'
$br-ex >> 'IPV4_FAILURE_FATAL=no'
$br-ex >> 'IPV6INIT=no'
$br-ex >> 'DNS1=8.8.8.8'
$br-ex >> 'ONBOOT=yes'

echo "###############################################" >> $LOG_FILE
echo 'Changed br-ex file'
cat $br-ex >> $LOG_FILE

echo '###############################################' >> $LOG_FILE
echo 'Changing bridge file' >> $LOG_FILE
network-bridge=/etc/sysconfig/network-scripts/ifcfg-$bridge
 $network-bridge > 'TYPE=OVSPort'
 $network-bridge >> 'NAME=$bridge'
 $network-bridge >> 'DEVICE=$bridge'
 $network-bridge >> 'DEVICETYPE=ovs'
 $network-bridge >> 'OVS_BRIDGE=br-ex'
 $network-bridge >> 'ONBOOT=yes'
cat $network-bridge >> $LOG_FILE
service network restart >> $LOG_FILE

echo "Note:  Log File:  /var/log/openstack_automate.log"
echo "INSTALLATION HAS BEEN COMPLETED. Please check keystonerc_admin file in userdirectory " >> $LOG_FILE
