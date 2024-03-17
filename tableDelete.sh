#!/usr/bin/bash
#/home/mahmoud/Videos/bashtest/.db/${dataName}
echo  -e " Database ${dataName} Tables ==>"
         ls  /home/mahmoud/Videos/bashtest/.db/${dataName}
        

read -p  "Enter Table Name To Delete data : "  tablename
# check table exists 
if [ -f /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename ] ; then
    # check if contains record
    count=`cat /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename | wc -l ` 
    if [[ $count> 2 ]] ; then
echo -e " Delete : "
select type in "All" "By Id" "Exit"
do
case $type in 
"All" ) 
echo -e "Are you sure to delete  all records ${tablename} [y/n] :  " 
read ans
if [ $ans == "y" -o $ans == "Y" ] ; then 
    sed -i '3,$d' /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename 
    echo -e " ${tablename} Records deleted succssfully. "
    source DBmenu.sh;
fi
;;
"By Id" )
    read -p "Enter Record id : " id
if [[  ! $id =~ ^[1-9][0-9]*$  ]] ; then
    echo -e " ID must be integer :) "
    source DBmenu.sh;
else
# delete now
row=`awk -F":" -v id=$id '{if($1==id) print $0}' /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename`
        if [[ -z $row ]] ; then
            echo -e "${invaild} Record Not Found "
            source DBmenu.sh;
        else
        echo -e "Are you sure to delete Record ${row} [y/n] :  " 
        read ans
        if [ $ans == "y" -o $ans == "Y" ] ; then 
            sed -i '/'${row}'/d' /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename
            echo -e "Record deleted from ${tablename}  succssfully. "
        fi
          source DBmenu.sh;
        fi

fi
;;
"Exit" ) break 
    source DBmenu.sh ;;
* ) 
echo -e " Invalid Option  "
source DBmenu.sh;
;;
esac
done
    # table is empty
    else
    echo -e "Table ${tablename} dose not contain any records "
    source db_menu.sh
fi
# table not exit
else
    echo -e "$ Table  ${tablename} Not Found "
    source DBmenu.sh 
fi