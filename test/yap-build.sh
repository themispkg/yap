#!/bin/bash

# yap-build.sh Created Automatically by yap 1.0.0

. "/usr/local/lib/bash/5.17/colorsh.sh"
. "/usr/local/lib/bash/5.17/tuiutils.sh"
. "/usr/local/lib/bash/5.17/alternatives.sh"
. "/usr/local/lib/bash/5.17/osutils.sh"
. "/usr/local/lib/bash/5.17/yap/base-utils.sh"
. "/usr/local/lib/bash/5.17/yap/check.sh"

build:distro --fatal debian
build:trigger --fatal zenity ls tr test 
build:install -m 755 ./yap-test.sh /home/${SUDOUSER}/bin/yap-test
