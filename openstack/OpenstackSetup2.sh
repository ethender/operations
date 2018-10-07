#!/bin/bash

#
# After reboot setup2
#
echo '#####################################'
echo 'Openstack setup 2 has started'
getenforce

#installing openstack package
echo  '#######################################'
yum install -y centos-release-openstack-ocata
echo 'opentstack octa has installed'
echo 'updating opentack system'
yum update -y

#installing packstack
echo  '#######################################'
echo 'It Will take n1-2 hours.'
echo 'Have some patience.'
echo 'After installation. Read the CLI_installation_guide.pdf file.'
echo 'After installing check internet connectivity is there.'
echo 'After modifiying the connectivity. Is any problem check /tempconfig for network configuration has backup'

yum install -y openstack-packstack
