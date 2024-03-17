#!/usr/bin/bash
read -p "Enter table name : " tablename
while [[ -z $tablename || $tablename =~ ^[0-9] || $tablename =~ [0-9]$ || $tablename == *['!''@#/$\"*{^})(+|,;:~`.%&/=-]>[<?']* ]]  
do
echo "Invaild Table  Name "
read -p "Enter table name : " tablename
done

while [[ $tablename == *" "* ]] ; do
tablename=`$tablename | tr ' ' '_'` 
# `echo $db | tr ' ' '_'`
echo $tablename 
done

if [ -f /home/mahmoud/Videos/bashtest/.db/$dataName/$tablename ] ; then
echo -e "Table ${tablename} already exists " 
else
touch /home/mahmoud/Videos/bashtest/.db/$dataName/$tablename

echo Table ${tablename} created succssfully 
 fi
 #create metadata of table
read -p "Enter Num.Of Columns For Table ${tablename} : " numCols

while ! [[ $numCols =~ ^[1-9][0-9]*$  ]]
do
echo  " Invaild Number "
read -p "Enter Num.Of Columns For Table ${tablename} : " numCols
done
export $tablename
# convert numCols to intger [enable us to operate]
let numCols=$numCols #==>become integer number

while [[ $numCols < 2 ]]
do
    echo -e " Minimum Number Of Columns Is 2 "
    read -p "Enter Num.Of Columns For Table ${tablename} : " numCols
done

echo -e "Note that first column name is id and it is PK "
record_name=''
record_type=''
for ((i=2;i<=$numCols;i++))
 do
    read -p "Enter Column ${i} Name : " colName
# start check col name
    while [[ -z $colName || $colName =~ ^[0-9] || $colName == *['!''@#/$\"*{^})(+|,;:~`.%&/=-]>[<?']* ]]  
    do
            echo -e " Invaild colName "
            read -p "Enter Column ${i} Name : " colName
    done
# end check col name
# convert every space to _
    while [[ $colName == *" "* ]] ; do
    colName="${colName/ /_}"    
    done
# end convert
# check if colName found or not 
    while [[ $record_name  == *"${colName}"* ]] ; do
    echo -e " Filed ${colName} FOUND "
    read -p "Enter Column ${i} Name : " colName
    done
    if [ $i -eq 2 ] ; then   #check
            record_name+="id:"$colName
    else
            record_name+=":"$colName
    fi
    # end append col name to record
done
    echo $record_name >> /home/mahmoud/Videos/bashtest/.db/$dataName/$tablename
    #  Get Columns Name Data Types
echo -e "Enter Data Types [string|integer] "

#reade columns and put it in arr
colNames=`cut -d ':' -f 2-$numCols /home/mahmoud/Videos/bashtest/.db/$dataName/$tablename`
IFS=':' read -ra colArray <<< $colNames
let c=0

for ((i=2;i<=$numCols;i++))
do
echo "*** Enter data type for [" ${colArray[$c]} "] filed : "
c+=1
# only support string and integer
select choice in "string" "integer" "float"
do
case $choice in
"string" ) 
			if [ $i -eq 2 ]
			then 
			record_type=integer:string
            else
			record_type+=:string
	    	fi
		break;;
"integer" )
if [ $i -eq 2 ] ; then
	record_type=integer:integer
	else 
	record_type+=:integer
fi
break ;;		

"float" )
if [ $i -eq 2 ] ; then
	record_type=integer:float
	else 
	record_type+=:float
fi
break;;

* )
		echo -e "  Invaild data type "
		continue;;
esac
# end select
done
# end for
done
echo $record_type >> /home/mahmoud/Videos/bashtest/.db/$dataName/$tablename
echo -e " Your table [${tablename}] meta data is : \n $record_name \n $record_type "

source DBmenu.sh







