#!/usr/bin/bash
let count=`ls  /home/mahmoud/Videos/bashtest/.db/${dataName} | wc -l`
if [[ $count  >   0 ]] ; then
echo  -e "**** Your Tables [${count}] ****"
ls -F /home/mahmoud/Videos/bashtest/.db/${dataName}
else
echo -e " No Tables Found "
fi
source DBmenu.sh