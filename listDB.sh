#!/usr/bin/bash
  if [[ -d /home/mahmoud/Videos/bashtest/.db ]];then
              ls -F /home/mahmoud/Videos/bashtest/.db | grep / | tr '/' ' '
     fi