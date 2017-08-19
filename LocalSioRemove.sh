#!/bin/bash

               ##############################################################
               ##
               ##  Jones Uzan
               ##
               ##
               ###################################################################


##############################################################
#Are you sure Message
#############################################################
clear
 

echo "                  *******************************************************************"
echo "                                    "
echo "                              ARE YOU SURE YOU WANT TO REMOVE SIO "
echo "                            ****************************************"  
echo " " 
echo " " 
echo " " 
echo " " 
sleep 1



echo "yes or no:"
read yesno


#if [[ "$yesno" == yes ]]; then 

# echo "SIO rpm's delete will continue "
# echo "------------------------------"
#else 
  
# echo " exiting"
#fi 

#sleep 1

############################################################
#Collect RPMS to remove
###########################################################
echo "List of SIO rpm's to remove:"
echo "---------------------------"
rpm -qa |grep EMC|grep -v gateway > removerpms.tmp
cat removerpms.tmp

sleep 1
echo " " 
echo " " 
echo " "
echo " " 

###########################################################
#Delete RPM in process
###########################################################

for i in `cat removerpms.tmp` ; do 

     rpm -e "$i"      
sleep 2

done

#END





