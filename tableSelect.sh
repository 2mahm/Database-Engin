#!/usr/bin/bash
#/home/mahmoud/Videos/bashtest/.db/${dataName}
echo  -e " Database ${dataName} Tables ==>"
         ls  /home/mahmoud/Videos/bashtest/.db/${dataName}
      
read -p  "Enter Table Name To Select data : "  tablename
# check table exists
if [ -f /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename ] ; then
    # check if contains record
    count=`cat /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename | wc -l `
    if [[ $count > 2 ]] ; then
    # Ask to select all or by specific id
echo -e " Select Record[s] :"
select type in "All" "By Id" "Exit"
do
case $type in 
"All" ) 
awk -F: '{ if(NR==1) print $0  } {if(NR>2) print $0  }  ' /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename 
;;
"By Id" )
read -p "Enter Record id : " id
if [[  ! $id =~ ^[1-9][0-9]*$  ]] ; then
    echo -e "  ID must be integer :) "
    source DBmenu.sh;

else
# # search if first field is = id return entire record
row=`awk -F":" -v id=$id '{if($1==id) print $0}' /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename`
    if [[ -z $row ]] ; then
            echo -e " Record Not Found "
            source DBmenu.sh;
    else
        awk -v id=$id -F":" '{if(NR>2 && $1==id) print $0}' /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename 
    fi    
fi
;;
"Exit" ) 


source DBmenu.sh ;;
* ) echo -e " Invalid Option ";;
esac
done
# if table hasnot data
    else
    echo -e " Table ${tablename} dose not contain any records "
    fi
source db_menu.sh
else
    echo -e " Table  ${tablename} Not Found "
    source DBmenu.sh 
fi