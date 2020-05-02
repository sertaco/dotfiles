#!/usr/bin/env bash

if [[ "$OS" =~ OSX ]]; then
  export OpSys=macos
else
  export OpSys=sed -n '/^ID=/{s/^ID=//;p}' /etc/os-release
fi
