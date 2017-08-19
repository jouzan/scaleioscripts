#!/bin/bash




       ############################################################
       ##
       ## Jones Uzan
       ##   Install SIO System on 8 nodes 2017, on several servers [two layer] 
       ##   jones.uzan@dell.com
       ##
       ## 
       ############################################################



####################################################################
#1. please copy all SIO RPM'S in the root home folder on the server you running the script
#     the script will copy all files to each server root folder 
#2. make sure you can SSH to all server [run ssh-keygen on all servers and run ssh-copy root@IP from the server you will be doing the remote Install [MDM1]
#   [Basiclly, you should run your Install script from the MDM1]
#
#3. once you run the script you will be easked to provide the IP address of all the NODES 
#
#
##################################################################



######################################################################
#List servers 
######################################################################


clear


tput setaf 6;
echo "                           #################################################"
echo "                           "
echo "                                           SIO INSTALL    "
echo " " 
echo "                           ------------------------------------------------"
echo ""
echo ""
tput setaf 6; echo " ################################################################"
tput setaf 6; echo " #Attache IP to ROLE                                            #"
tput setaf 6; echo " ################################################################"

mdm1=$1
mdm2=$2
tb=$3
sds4=$4
sds5=$5
sds6=$6
sds7=$7
sds8=$8





###############################################################################
#Request for  approval
###############################################################################
echo " " 
echo " " 
echo " " 


#############################################################################
#Copy the RPM'S 
############################################################################
tput setaf 6; echo " #############################################################################"
tput setaf 6; echo " #             Copy SIO RPM'S to $mdm2,$tb,$sds4,$sds5,$sds6,$sds7,$sds8"
tput setaf 6; echo " ############################################################################"

scp EMC-ScaleIO-* $mdm2:/root
scp EMC-ScaleIO-* $tb:/root
scp EMC-ScaleIO-* $sds4:/root
scp EMC-ScaleIO-* $sds5:/root
scp EMC-ScaleIO-* $sds6:/root
scp EMC-ScaleIO-* $sds7:/root
scp EMC-ScaleIO-* $sds8:/root


sleep 2
clear
echo " " 
echo " " 
echo " " 
echo " "
echo " "
echo " "
echo " "
echo " "
echo " "

#############################################################################
#INSTALLING SIO MDM'S  
############################################################################
tput setaf 6; echo " #############################################################################"
tput setaf 6; echo " #                    INSTALLING SIO  MDM'S $mdm1,$mdm2,$tb,"
tput setaf 6; echo " ############################################################################"

MDM_ROLE_IS_MANAGER=1 rpm -ivh EMC-ScaleIO-mdm*
ssh root@172.30.224.203 "MDM_ROLE_IS_MANAGER=1 rpm -ivh EMC-ScaleIO-mdm*"
ssh root@172.30.224.204 "MDM_ROLE_IS_MANAGER=0 rpm -ivh EMC-ScaleIO-mdm*"
echo " " 
echo " " 
echo " " 
echo " "
echo ""
echo " "
echo " " 
echo " "
echo " "
echo " "
echo " "
echo " "
sleep 1 

###################################################################################
###################################################################################
#Installing LIA 
tput setaf 1; echo " ###################################################################################"
tput setaf 1; echo " #               Installing LIA $mdm1,$mdm2,$tb,$sds4,$sds5,$sds6,$sds7,$sds8"
tput setaf 1; echo " ###################################################################################"
TOKEN=P@ssw0rd rpm -ivh EMC-ScaleIO-lia*
ssh root@172.30.224.203 "TOKEN=P@ssw0rd rpm -ivh EMC-ScaleIO-lia*"
ssh root@172.30.224.204 "TOKEN=P@ssw0rd rpm -ivh EMC-ScaleIO-lia*"
ssh root@$sds4 "TOKEN=P@ssw0rd rpm -ivh EMC-ScaleIO-lia*"
ssh root@$sds5 "TOKEN=P@ssw0rd rpm -ivh EMC-ScaleIO-lia*"
ssh root@$sds6 "TOKEN=P@ssw0rd rpm -ivh EMC-ScaleIO-lia*"
ssh root@$sds7 "TOKEN=P@ssw0rd rpm -ivh EMC-ScaleIO-lia*"
ssh root@$sds8 "TOKEN=P@ssw0rd rpm -ivh EMC-ScaleIO-lia*"

echo " " 
echo " " 
echo " "
echo " "
echo " "
echo " "
echo " "
echo " "
echo " "

###################################################################################
#Installing SDS
###################################################################################
tput setaf 9; echo "###################################################################################"
tput setaf 9; echo "#        Installing SDS on $mdm1,$mdm2,$tb,$sds4,$sds5,$sds6,$sds7,$sds8"
tput setaf 9; echo "###################################################################################"

rpm -ivh EMC-ScaleIO-sds*
ssh root@172.30.224.203 "rpm -ivh EMC-ScaleIO-sds*"
ssh root@172.30.224.204 "rpm -ivh EMC-ScaleIO-sds*"
ssh root@$sds4 "rpm -ivh EMC-ScaleIO-sds*"
ssh root@$sds5 "rpm -ivh EMC-ScaleIO-sds*"
ssh root@$sds6 "rpm -ivh EMC-ScaleIO-sds*"
ssh root@$sds7 "rpm -ivh EMC-ScaleIO-sds*"
ssh root@$sds8 "rpm -ivh EMC-ScaleIO-sds*"

echo " " 
echo " " 
echo " " 
echo " "
echo " "
echo " "
echo " "
echo " "
echo " "
###################################################################################
#Confiure SIO Cluster system 
#####################################################################################
tput setaf 9; echo  "##################################################"
tput setaf 9; echo  "#Configure SIO Cluster system "
tput setaf 9; echo  "################################################# "

echo "Configuring the SIO cluster system"
echo " RUNNING THE FOLLOWING COMMAND ON $mdm1 TO CREATE SIO CLUSTER:"
scli --create_mdm_cluster --master_mdm_ip $mdm1 --master_mdm_management_ip $mdm1 --master_mdm_name mdm1 --accept_license

echo " LOG IN USING DEFAULT ADMIN ADMIN:"
scli --login --username admin --password admin


echo " CHANGE DEFAULT ADMIN PASSWORD TO P@ssw0rd:"
scli --set_password --old_password admin --new_password P@ssw0rd

echo " PLEASE LOG IN USING THE PASSWORD BEFORE TYPING yes:"
scli --login --username admin --password P@ssw0rd

echo " " 


echo " "
echo " "
echo " " 
echo " " 
echo " " 
tput setaf 6; echo "#############################################################"
tput setaf 6; echo "#                    Adding SECONDERY MDM $mdm2"
tput setaf 6; echo "##########################################################"
scli --add_standby_mdm --new_mdm_ip $mdm2 --mdm_role manager --new_mdm_management_ip $mdm2 --new_mdm_name mdm2

sleep 1

echo " "
echo " " 
echo " "
echo " "
echo " "
echo " "
echo " "
echo " "
tput setaf 3; echo "############################################################"
echo "#                    Adding TB $tb "
echo "##########################################################"
scli --add_standby_mdm --new_mdm_ip $tb --mdm_role tb --new_mdm_name tb
sleep 1

echo " " 
echo " " 
echo " "
echo " "
echo " "
echo " "
echo " "
tput setaf 9; echo "############################################################"
echo "#                 switch to 3 MDM mode from single mode  "
echo "##########################################################"
scli --switch_cluster_mode --cluster_mode 3_node --add_slave_mdm_name mdm2 --add_tb_name tb

echo " "
echo " "
echo " " 
echo " " 
clear 
echo "" 
echo " " 
echo " "
echo " " 

echo " "
echo " "
echo " "
echo " "
echo " "


tput setaf 1; echo "                     ################   NOW lets add the SDS's servers and their dirves,          #############"
echo "                     #                      you can open the GUI connect to the cluster and watch #############"
echo "                     ##                       how each SDS is added and its drives as well"
echo "                     #                       Also you can see how SDC's are added volumes etc...   ############"
echo "                     ###                                                                    "
echo "                     ############################################################################################"
echo " " 
echo " " 
echo " " 
echo " "
sleep 2


echo "###########################################3########################"
echo "#                     Adding protection domain PD1 and pool POOL1"
echo "###################################################################"
scli --add_protection_domain --protection_domain_name PD1
scli --add_storage_pool --protection_domain_name PD1 --storage_pool_name POOL1

sleep 1

echo " " 
echo " "
echo " "
echo " "
echo " " 
echo " "
echo "##########################################33#########################"
echo "#                     Adding SDS / DEVICES "
echo "######################################################################"
scli --add_sds --sds_ip $mdm1 --device_path "/dev/sdb,/dev/sdc" --protection_domain_name PD1 --storage_pool_name POOL1 --sds_name sds1
scli --add_sds --sds_ip $mdm2 --device_path "/dev/sdb,/dev/sdc" --protection_domain_name PD1 --storage_pool_name POOL1 --sds_name sds2
scli --add_sds --sds_ip $tb --device_path "/dev/sdb,/dev/sdc" --protection_domain_name PD1 --storage_pool_name POOL1  --sds_name sds3
scli --add_sds --sds_ip $sds4 --device_path "/dev/sdb,/dev/sdc" --protection_domain_name PD1 --storage_pool_name POOL1 --sds_name sds4
scli --add_sds --sds_ip $sds5 --device_path "/dev/sdb,/dev/sdc" --protection_domain_name PD1 --storage_pool_name POOL1 --sds_name sds5
scli --add_sds --sds_ip $sds6 --device_path "/dev/sdb,/dev/sdc" --protection_domain_name PD1 --storage_pool_name POOL1 --sds_name sds6
scli --add_sds --sds_ip $sds7 --device_path "/dev/sdb,/dev/sdc" --protection_domain_name PD1 --storage_pool_name POOL1 --sds_name sds7
scli --add_sds --sds_ip $sds8 --device_path "/dev/sdb,/dev/sdc" --protection_domain_name PD1 --storage_pool_name POOL1 --sds_name sds8


echo " "
echo " " 
echo " " 
echo " " 

echo " "
echo " "






########################################################################################################################################################3



tput setaf 9; echo "Let's continue the automatic creation of VOLUMES"
tput setaf 9; echo "**************************************************************************"


echo " ####################################################################"
echo " #                                    Creating volumes "
echo " #####################################################################"
scli --add_volume --protection_domain_name PD1 --storage_pool_name POOL1 --volume_name VOL0000 --size_gb 16 --thin_provisioned
scli --add_volume --protection_domain_name PD1 --storage_pool_name POOL1 --volume_name VOL0001 --size_gb 32 --thin_provisioned
scli --add_volume --protection_domain_name PD1 --storage_pool_name POOL1 --volume_name VOL0002 --size_gb 8 --thin_provisioned
scli --add_volume --protection_domain_name PD1 --storage_pool_name POOL1 --volume_name VOL0003 --size_gb 16 --thin_provisioned
scli --add_volume --protection_domain_name PD1 --storage_pool_name POOL1 --volume_name VOL0004 --size_gb 8 --thin_provisioned

sleep 1

echo " " 
echo " " 
echo " " 

echo " "
echo " " 
echo " " 
echo " " 
tput setaf 3; echo "###################################################################"
echo "#Set HIGH Performance profile across the cluster MDM  SDS SDC'S "
echo "#scli --set_performance_parameters  --all_sds --all_sdc --apply_to_mdm --profile high_performance"
echo "#############################################################################"
scli --set_performance_parameters  --all_sds --all_sdc --apply_to_mdm --profile high_performance


echo " " 
echo " " 
echo " " 
echo "###########################################################################"
echo "#                 Install SDC on Single Server                             #"
echo "############################################################################"
MDM_IP=10.1.1.11,20.1.1.11 rpm -ivh EMC-ScaleIO-sdc-2.0-12000.122.el7.x86_64.rpm

sleep 3


echo " " 
echo " " 
tput setaf 9; echo "###########################################################################"
echo "#                Map few volumes                                          #"
echo "############################################################################"
scli --map_volume_to_sdc --volume_name VOL0000 --sdc_ip 10.1.1.11  
scli --map_volume_to_sdc --volume_name VOL0001 --sdc_ip 10.1.1.11  
scli --map_volume_to_sdc --volume_name VOL0002 --sdc_ip 10.1.1.11  


sleep 4
tput setaf 6; echo "###########################################################################"
echo "#               Start FIO Workload test                                                 #"
echo "############################################################################"


fio --filename=/dev/scinib --name=A --ioengine=libaio --iodepth=16 --rw=randrw --rwmixread=90 --bs=4k --direct=1 --size=4G --numjobs=8 --runtime=2224 --group_reporting


###END
