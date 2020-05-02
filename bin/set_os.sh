#!/usr/bin/env bash

function F1(){
if ! [ -z "$OS" ] && [[ "$OS" =~ OSX ]]; then
  return 1
else
  OpSys=`sed -n '/^ID=/{s/^ID=//;p}' /etc/os-release`
  if OpSys='centos';then
    return 2
  elif OpSys='ubuntu';then
    return 3
  else
    return 4
  fi
fi
}
F1
export val=$?
if [ $val -eq 1 ]; then
  echo "macos"
elif [ $val -eq 2 ]; then
  echo "ubuntu"
else
  echo $val
fi
