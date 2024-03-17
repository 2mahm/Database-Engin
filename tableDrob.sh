#!/usr/bin/bash
ls  /home/mahmoud/Videos/bashtest/.db/${dataName}

read -p  "Enter Table Name To Drop : "  tablename
if [ -f /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename ] ; then
echo -e "Are you sure to delete ${tablename} [y/n] :  " 
read ans
    if [ $ans == "y" -o $ans == "Y" ] ; then 
    rm /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename
    echo -e " Table ${tablename} deleted succssfully. "
    fi
source DBmenu.sh
elif [[ -z $tablename || ! -f /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename  ]] ; then
    echo -e " Table Not Found "
    source DBmenu.sh
fi


#/home/mahmoud/Videos/bashtest/.db/${dataName}