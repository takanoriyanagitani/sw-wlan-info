#!/bin/sh

run_yaml(){
  ./WlanInfo | bat --language=yaml
}

which bat | fgrep -q bat || exec ./WlanInfo

run_yaml
