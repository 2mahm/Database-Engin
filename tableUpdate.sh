#!/usr/bin/bash
echo  -e " Database ${dataName} Tables ==>"
         ls  /home/mahmoud/Videos/bashtest/.db/${dataName}

         
read -p  "Enter Table Name To Update data : "  tablename
# check table exists
 if [ -f /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename ] ; then
    # check if contains record
    count=`cat /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename | wc -l `
    if [[ $count  > 2 ]] ; then   
#   ------------------------------------------  #
# get Columns name from table
colNames=`cut -d ':' -f 2- /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename`
IFS=':' read -ra colArray <<< $colNames
typeArray=`head -2 /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename | tail -1 | cut -d ':' -f 2- `
IFS=':' read -ra dataType <<< $typeArray

#   ------------------------------------------  #

read -p "Enter Record Id : " id

if [[  ! $id =~ ^[1-9][0-9]*$  ]] ; then
    echo -e "${invalid}  ID must be integer :) ${base}"
    source DBmenu.sh;
else
# # search if first field is = id return entire record
current=`awk -v id=$id -F":" '{if(NR>2 && $1==id) print $0}' /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename `

        if [[ ! -z $current ]] ; then
        record=()
# loop for fileds&datatype
for (( i=0;i<${#colArray[@]};i++))
do
echo "Enter New Value Of " ${colArray[$i]}  "["${dataType[$i]}"]" 
read value
        # check data type
        if [[ ${dataType[$i]} = "string" ]] ;  then
            if [[ ! $value == *[a-zA-z0-9]* ]] ; then      
                echo -e "${invalid}" ${colArray[$i]} " must be string :) ${base}"
                source db_menu.sh;
            else
            # convert every space to _
            while [[ $value == *" "* ]] ; do
            value="${value/ /_}"    
            done
            # end convert
                    record[$i]=$value
            fi
        # Integer
        elif [[ ${dataType[$i]} = "integer" ]] ;  then
            if [[ ! $value =~ ^[0-9]*$ ]] ; then
                echo -e "" ${colArray[$i]} " must be integer :) ${base}"
                source DBmenu.sh;
            else
                    record[$i]=$value
            fi  
        # Float
        elif [[ ${dataType[$i]} = "float" ]] ;  then
            if [[ ! $value =~ ^[+-]?[0-9]+\.?[0-9]*$  ]] ; then
                echo -e "${invalid}" ${colArray[$i]} " must be Float :) ${base}"
                source db_menu.sh;
            else
                    record[$i]=$value
            fi        
        fi
done
# end loop
    data=""
    for item in ${record[@]} 
    do
    data+=$item":"
    done
    data=$id":"$data
    updateRecord="${data%?}"
 
    sed -i "/^$id/s/$current/$updateRecord/" /home/mahmoud/Videos/bashtest/.db/${dataName}/$tablename
    else
     echo -e " Record Not Found "
        source DBmenu.sh
    fi
fi
    echo -e " Record Update Succssfully.  "
    source DBmenu.sh  
# table is empty
    else
    echo -e " Table ${tablename} dose not contain any records "
    source DBmenu.sh  
    fi
# table not exit
else
    echo -e "$ Table  ${tablename} Not Found "
    source DBmenu.sh  
fi