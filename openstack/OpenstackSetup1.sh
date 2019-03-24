#!/bin/sh
touch /var/log/openstack_automate.log
LOG_FILE='/var/log/openstack_automate.log'
echo 'Openstack pre operations has started' >> $LOG_FILE
echo '#######################################' >> $LOG_FILE
# Red hat release
echo 'Red hat release' >> $LOG_FILE
cat /etc/redhat-release >> $LOG_FILE

# setting environment
echo '##################################'
mv /etc/environment /etc/environment.orig >> $LOG_FILE
cp environment /etc/environment >> $LOG_FILE
cat /etc/environment >> $LOG_FILE

# check and disabling firewall
echo '##################################'
systemctl status firewalld >> $LOG_FILE
systemctl stop firewalld >> $LOG_FILE
systemctl disable firewalld >> $LOG_FILE
echo 'Firewalld has stopped' >> $LOG_FILE

# check and disabling network manager
echo '##################################' >> $LOG_FILE
systemctl status NetworkManager >> $LOG_FILE
systemctl stop NetworkManager >> $LOG_FILE
systemctl disable NetworkManager >> $LOG_FILE
echo 'Network Manager has changed' >> $LOG_FILE

#enabling Network
echo '####################################' >>  $LOG_FILE
systemctl enable network >>  $LOG_FILE
systemctl start network >>  $LOG_FILE
echo 'Network has started' >> $LOG_FILE

#copying network settings
echo '####################################' >> $LOG_FILE
echo 'Enter Your Bridge Name ex - enp0s3' >> $LOG_FILE
read -p "Enter network bridge name: " bridge
cat /etc/sysconfig/network-scripts/ifcfg-$bridge >> $LOG_FILE
mkdir /tempconfig >> $LOG_FILE
cp /etc/sysconfig/network-scripts/ifcfg-$bridge /tempconfig >> $LOG_FILE
echo 'network backup settings has done. /tempconfig' >> $LOG_FILE

#se linux should be disabled
echo '####################################' >> $LOG_FILE
mv /etc/selinux/config  /etc/selinux/config.orig >> $LOG_FILE
cp seconfig /etc/selinux/ >> $LOG_FILE
echo 'se linux has been modified' >> $LOG_FILE
echo 'Please reboot the system.' >> $LOG_FILE
echo 'After rebooting. Execute Openstack setup 2' >> $LOG_FILE
