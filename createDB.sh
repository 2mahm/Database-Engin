#!/usr/bin/bash
shopt -s extglob #enable sub pattren
PS3="Enter the Name of DB:"
if [[ -d /home/mahmoud/Videos/bashtest/.db ]];then
    echo "The folder .db Already Exit:"
else
    echo "Create Folder .db"
    mkdir ~/Videos/bashtest/.db
 fi
read -p "Enter the Name of DB : " db

# db=`echo $db | tr ' ' '_'` #Replace Space _
            case $db in 
            +([0-9]*) )
            echo "The database cannot start with number"
                       source mainS.sh;

            ;;
           *[[:space:]] | *[[:space:]]* | [[:space:]]* ) 
           echo "invalide space Your name cannot contain space "
           source mainS.sh;
            ;;
            +(*[0-9]$) )
            echo "the database can not end with num"
                       source mainS.sh;

            ;;
            '')
            echo "you must insert the name"
                       source mainS.sh;

            ;;
            [^a-zA-Z0-9] )
                echo "your name contain speachial char"
                           source mainS.sh;
            ;;
            

          +(*['!''@#/$\"*{^})(+|,;:~`.%&/=-]>[<?']*) )
               echo "your name can not contain spechial char" 

            ;;
            *)
            if [[ -d /home/mahmoud/Videos/bashtest/.db/$db ]];then
            echo "sorry this name is alrede exit"
              else
              mkdir ~/Videos/bashtest/.db/$db
                fi
            echo "Valide Database Name"
             source mainS.sh;

           esac

             
           