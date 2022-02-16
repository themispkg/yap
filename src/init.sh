#!/bin/bash

. /usr/local/lib/bash/5.17/yap/core.sh || { echo -e "\033[0;31mFatal:\033[0m could not sourcing core in this time." ; exit 1 ; }

yap:core:getlib "tuiutils" "osutils" "alternatives" "colorsh"

osutil:check -t "git" tar gcc install awk mktemp xargs chmod chown cp ln ls mkdir mv rm rmdir touch basename cat comm cut dirname echo expand false true head seq sort tail tee tr uniq wc env date || exit "$?"

# All Good Go Ahead.
