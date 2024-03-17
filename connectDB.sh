#!/usr/bin/bash
  arr=(`ls -F /home/mahmoud/Videos/bashtest/.db | grep / | tr '/' ' ' `)
              #   echo ${arr[@]}
              #  echo ${#arr[@]}
              #  echo ${arr[0]}
select choice in ${arr[@]}
 do
       
                if [ $REPLY -gt ${#arr[@]} ];then

                    echo " $REPLY not on the menu "
                    else
                    cd ~/Videos/bashtest/.db/${arr[${REPLY}-1]}
                      PS3="Your Current Data_base is:"${arr[${REPLY}-1]}":"
                      dataName=${arr[${REPLY}-1]}
                
                      export $dataName
                  
                    source DBmenu.sh

                    fi
        done