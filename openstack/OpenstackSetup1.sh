#!/bin/sh
echo 'Openstack pre operations has started'
echo '#######################################'
# Red hat release
echo 'Red hat release'
cat /etc/redhat-release

# setting environment
echo '##################################'
mv /etc/environment /etc/environment.orig
cp environment /etc/environment
cat /etc/environment

# check and disabling firewall
echo '##################################'
systemctl status firewalld
systemctl stop firewalld
systemctl disable firewalld
echo 'Firewalld has stopped'

# check and disabling network manager
echo '##################################'
systemctl status NetworkManager
systemctl stop NetworkManager
systemctl disable NetworkManager
echo 'Network Manager has changed'

#enabling Network
echo '####################################'
systemctl enable network
systemctl start network
echo 'Network has started'

#copying network settings
echo '####################################'
read -p "Enter network bridge name: " bridge
cat /etc/sysconfig/network-scripts/ifcfg-$bridge
mkdir /tempconfig
cp /etc/sysconfig/network-scripts/ifcfg-$bridge /tempconfig
echo 'network backup settings has done. /tempconfig'

#se linux should be disabled
echo '####################################'
mv /etc/selinux/config  /etc/selinux/config.orig
cp seconfig /etc/selinux/
echo 'se linux has been modified'
echo 'Please reboot the system.'
echo 'After rebooting. Execute Openstack setup 2'
