#!/usr/bin/bash
shopt -s extglob
PS3="Enter your choice: "
select nameDB in "Create DB" "List DB" "Connect DB" "Delete DB" 
do
    case $REPLY in 
        1)
        source createDB.sh
         ;;
        2)
        source listDB.sh
          ;;
        4)
        source deleteDB.sh

          ;;
        3)
     source connectDB.sh
    ;;
    *)
    echo "You must Enter then number in menu"
    source mainS.sh
      esac
done