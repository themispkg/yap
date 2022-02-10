#!/bin/bash

. /usr/local/lib/bash/5.17/yap/core.sh || { echo -e "\033[0;31mFatal:\033[0m could not sourcing core in this time." ; exit 1 ; }

yap:core:getlib "tuiutils" "osutils" "alternatives" "colorsh"

osutil:check -t "install" "mktemp" "chmod" "chown" "cp" "mkdir" "ln" "mv" "rm" "rmdir" "touch" "basename" "cat" "comm" "dirname" "echo" "expand" "dirname" "false" "true" "head" "tail" "seq" "tr" "uniq" "wc" "date" "env"

# All Good Go Ahead.