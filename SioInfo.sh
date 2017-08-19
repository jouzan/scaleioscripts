#!/bin/bash





                 #####################################################
                 # General info , Capacity, volumes , sds's etc...
                 # 
                 #   Jones Uzan
                 #
                 #####################################################


#########################################################################
#Login To SIO 
#########################################################################

scli --login --username admin --password P@ssw0rd


##########################################################################
#Welcome screen 
##########################################################################
clear
echo " " 
echo " " 
echo "            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "            +                 General Cluster information                  +"
echo "            +                                                              +"
echo "            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " " 
echo " "

#########################################################################
#Cluster health
#########################################################################

status=`scli --query_cluster|grep Mode:`
echo "STATUS:$status"
echo " "
 
version=`scli --query_cluster|grep Version:|grep -v Normal|awk '{print $2}'`
echo "VERSION:  $version"
echo " " 
echo " " 



#########################################################################
#ScaleIO Backend 
#########################################################################

sparecapacity=`scli --query_all|grep spare|awk '{print $1,$2}'`
echo "SPARE CAPACITY:  $sparecapacity"
echo " " 

totalcapacity=`scli --query_all|grep "total capacity"|awk '{print $1,$2}'`
echo "TOTAL CAPACITY: $totalcapacity"
echo " " 

inuse=`scli --query_all|grep "in-use capacity"|awk '{print $1,$2}'`
echo "IN-USE CAPACITY: $inuse"
echo " " 


scli --query_all_sds|grep "Protection"|awk '{print $5}'
echo "--------"
scli --query_all_sds|grep State
echo " " 
echo " " 

echo "SDC List:"
echo "---------"
scli --query_all_sdc|grep ID|awk '{print $1,$2,$3,$4,$5,$6,$7}'
echo " " 
echo " " 


echo "VOLUME List:"
echo "------------"
scli --query_all_volumes|grep ID:
echo " " 
echo " " 

echo " USER List:"
echo "-----------"
scli --query_users|egrep -v 'ID|System|-'





