#!/bin/bash 

              ###############################################################
              #
              # Jones Uzan 
              #
              #   Capacity related information 
              #
              # 
              ###############################################################

################################################################################
#clear / login 
################################################################################
scli --login --username admin --password P@ssw0rd
clear


sioversion=`scli --query_all|grep "EMC ScaleIO Version"|awk '{print $3,$4,$5}'`
echo "                 |---------------------------------------|"
echo "                 |                                       |"
echo "                 | $sioversion       |"
echo "                  ---------------------------------------|"  
echo " "
################################################################################
# total capacity
#############################################################################
echo "  ----------------------------------"
echo " | Total Capacity                   |"
echo " |----------------------------------"
total=`scli --query_all|grep "total capacity" |awk '{print $1,$2}'`
echo " | $total                           "
echo " |                                  "
echo "  ----------------------------------"
echo " "
echo " " 


################################################################################
# unused capacity
#############################################################################
echo "  ----------------------------------"
echo " | Unused Capacity                   |"
echo " |----------------------------------"
unused=`scli --query_all|grep -v unreachable|grep "unused capacity"|awk '{print $1,$2}'`
echo " | $unused                           "
echo " |                                  "
echo "  ----------------------------------"
echo " "
echo " " 






################################################################################
#list thick volumes 
#############################################################################
scli --query_all_volumes|grep ID|grep Thick|awk '{print $7,$5}' > volumes.tmp
cat volumes.tmp|tr " " "|" > volume.tmp
echo "  -----------------------------------"
echo " | Thick VOLUMES                     |"
echo " |-----------------------------------"
echo " |  GB | Vol Name                    |"
echo "  -----|-----------------------------"
   for n in `cat volume.tmp`
    do 
       echo " | $n                                                "
    done
echo " |-----------------------------------"
thick=`scli --query_all|grep "thick-provisioned"|awk '{print $6,$7}'`
echo " | $thick                            "
echo " |-----------------------------------"
echo " " 
echo " " 



############################################################################
#list thn volumes 
#############################################################################
scli --query_all_volumes|grep ID|grep Thin|awk '{print $7,$5}' > volumes.tmp
cat volumes.tmp|tr " " "|" > volume.tmp
echo "  ----------------------------------"
echo " | Thin VOLUMES                     |"
echo " |----------------------------------"
echo " |  GB | Vol Name                   |"
echo "  -----|----------------------------"
   for n in `cat volume.tmp`
    do 
       echo " | $n                        "
    done
echo " |                                  "
echo "  ----------------------------------"
thin=`scli --query_all|grep "thin-provisioned"|awk '{print $6,$7}'`
echo " | $thin                           "
echo " |-----------------------------------"
echo " " 
echo " " 
















