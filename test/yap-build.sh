#!/bin/bash

set -e

# yap-build.sh Created Automatically by yap 1.0.0

. "/usr/local/lib/bash/5.17/colorsh.sh"
. "/usr/local/lib/bash/5.17/tuiutils.sh"
. "/usr/local/lib/bash/5.17/alternatives.sh"
. "/usr/local/lib/bash/5.17/osutils.sh"
. "/usr/local/lib/bash/5.17/yap/base-utils.sh"

build:install -m 755 ./yap-test.sh /home/${SUDOUSER}/bin/yap-test
