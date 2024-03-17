#!/usr/bin/bash
select option in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Back To Menu"
do
case $option in
"Create Table" )
    source tableCreate.sh;;
"List Tables" )
    source tableList.sh;; 
"Drop Table" )
    source tableDrob.sh;;
"Insert into Table" )
    source tableInsert.sh ;;
"Select From Table" )
    source tableSelect.sh ;;
"Delete From Table" )
    source tableDelete.sh;;
 "Update Table" )
    source tableUpdate.sh;;
 "Back To Menu" )
    source connectDB.sh;;
* ) 
echo "Invaled option you must insert number between(1-8)" 
source DBmenu.sh
esac
done