#!/usr/bin/bash

#/home/mahmoud/Videos/bashtest/.db/${dataName}

echo  -e " Database ${dataName} Tables ==>"
         ls  /home/mahmoud/Videos/bashtest/.db/${dataName}
        
 read -p  "Enter Table Name To Insert data : "  tablename
# check table exists
if [ -f /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename ] ; then

 colNames=`cut -d ':' -f 1- /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename`
 IFS=':' read -ra colArray <<< $colNames

types=`awk -F":" '{if(NR==2) print $0}'  /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename `
IFS=':' read -ra typeArray <<< $types
echo "Types" ${typeArray[@]}

pks=(`awk -F":" '{if(NR>2) print $1}' /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename `)

record=() 
for (( i=0;i<${#colArray[@]};i++))
do
# check PK
if [[ ${colArray[$i]} == "id" ]] ; then
    echo "Enter " ${colArray[$i]} "["${typeArray[$i]}"&Unique] Value "  
    read value
        if [[  ${pks[@]} =~  $value  ]] ; then
        echo -e " ID must be unique :) "
        source db_menu.sh;
        elif [[  $value -le 0 || ! $value =~ ^[1-9][0-9]*$  ]] ; then
        echo -e " ID must be integer :) "
        source db_menu.sh;
        else
        record[$i]=$value
        fi
else
    echo "Enter " ${colArray[$i]} "["${typeArray[$i]}"] Value "  
    read value
# check datatype
# string datatype
if [[ ${typeArray[$i]} = "string" ]] ;  then
    if [[ ! $value == *[a-zA-z0-9]* ]] ; then      
        echo -e  ${colArray[$i]} " must be string :)"
        source DBmenu.sh;
    else
    # convert every space to _
    while [[ $value == *" "* ]] ; do
    value="${value/ /_}"    
    done
    # end convert
            record[$i]=$value
    fi

elif [[ ${typeArray[$i]} = "integer" ]] ;  then
    if [[ ! $value =~ ^[0-9]*$ ]] ; then
        echo -e ${colArray[$i]} " must be integer :) "
        source db_menu.sh;
    else
            record[$i]=$value
    fi    

# Float
elif [[ ${typeArray[$i]} = "float" ]] ;  then
    if [[ ! $value =~ ^[+-]?[0-9]+\.?[0-9]*$ ]] ; then
        echo -e  ${colArray[$i]} " must be Float :) "
        source DBmenu.sh;
    else
            record[$i]=$value
    fi    

fi
# end if => loop remaining names
fi
done
# echo "Your record => " ${record[@]}
echo "---------------------"
data=""
for item in ${record[@]} 
do
data+=$item":"
done
# remove last :
    data="${data%?}"
    echo $data >>  /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename
    echo -e " Inserted Succsfully" $data  
        source DBmenu.sh;
# Table not found
else
echo -e " Table  ${tablename} Not Found "
        source DBmenu.sh;
fi








#/home/mahmoud/Videos/bashtest/.db/${dataName}





