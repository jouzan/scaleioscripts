#!/bin/bash












            ######################################################
            #
            #   Jones Uzan 
            #     
            #     Create volumes on SIO system 
            #
            #
            ######################################################


#####################################################################
#Log In 
#####################################################################
scli --login --username admin --password P@ssw0rd


clear

echo "              ++++++++++++++++   Volume create   ++++++++++++++++++"
echo "              +++++++++++++++++++++++++++++++++++++++++++++++++++++"

echo " " 
echo " "
echo " " 



############################################################################
#Get volume information 
############################################################################

echo "VOL Name:"
read volname
echo " "
 
echo "VOL Size [In GB]:"
read volsize
echo " " 


echo "Storage Pool:"
read pool
echo " " 

echo "Protection Domain:"
read pd
echo " " 

echo "SDC to map to:"
read sdcmap
echo " " 


echo "$volname"
echo "$volsize"
echo "$pool"
echo "$pd"
echo "$sdcmap"




###########################################################################
#Create the volumes 
###########################################################################

scli --add_volume --protection_domain_name $pd --storage_pool_name $pool --volume_name $volname --size_gb $volsize --thin_provisioned --dont_use_rmcache



###############################################################################
#Map the volume to SDC 
###############################################################################

scli --map_volume_to_sdc --sdc_ip $sdcmap --volume_name $volname --allow_multi_map



############################################################################
#List all volumes 
##########################################################################

scli --query_all_volumes




#END






















