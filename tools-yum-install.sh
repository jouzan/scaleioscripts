#!/bin/bash





      #########################################
      # Jones Uzan 
      #    quick install all tools software and show network configuration 
      #    also check local DRIVE performance 
      #
      #
      ########################################################3





########################################################################
#Install updates and software 
#
########################################################################
yum update -y
yum install -y epel-release;yum install -y nload nmap fio git 



########################################################################
#Check IP Address 
#
########################################################################
echo "IP ADDRESS:"
echo "------------------------------"
ifconfig |grep netmask|grep -v 127.0.0.1|awk '{print $2}'
echo " " 
echo " "



########################################################################
#check DRIVES  
#
########################################################################
echo "LCOAL DRIVES:"
echo "-----------------------------"
fdisk -l |grep dev























