#!/bin/bash

               ##############################################################
               ##
               ##  Jones Uzan
               ##    run the LocalrEMOVEsIO SCRIPT 
               ##
               ###################################################################


for i in `seq 12 20` ; 
 do

 echo "ssh root@10.1.1.$i "bash -s" < LocalSioRemove.sh"
 ssh root@10.1.1.$i "bash -s" < LocalSioRemove.sh

 done



#END





