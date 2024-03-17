#!/usr/bin/bash
  arr=(`ls -F /home/mahmoud/Videos/bashtest/.db | grep / | tr '/' ' ' `)

select choice in ${arr[@]}

        do
                if [ $REPLY -gt ${#arr[@]} ];then

                    echo " $REPLY not on the menu "
                    else
                    rm -r ~/Videos/bashtest/.db/${arr[${REPLY}-1]}
                     echo "Your Data_base deleted Succssfuly"
                    fi
        done