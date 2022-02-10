#!/bin/bash

yap:reverse:main() {
    tmpd="$(mktemp -d)"
    yap:core:chkyapfile
    yap:core:fsplit "${yapfile}"
    yap:core:chkimport
    case "${1}" in
        [gG][eE][nN][eE][rR][aA][tT][eE]-[fF][uU][lL][lL]|--[gG][eE][nN][eE][rR][aA][tT][eE]-[fF][uU][lL][lL]|-[gG][fF])
            cat - > uninstall.sh <<INSTALLFILE
#!/bin/bash

set -e

# uninstall.sh Created Automatically by yap ${yap_version}

INSTALLFILE
            cat "${yap_lib}/colorsh.sh" | grep -v '^#' >> uninstall.sh
            echo "" >> uninstall.sh
            cat "${yap_lib}/tuiutils.sh" | grep -v '^#' >> uninstall.sh
            echo "" >> uninstall.sh
            cat "${yap_lib}/alternatives.sh" | grep -v '^#' >> uninstall.sh
            echo "" >> uninstall.sh
            cat "${yap_lib}/osutils.sh" | grep -v '^#' >> uninstall.sh
            echo "" >> uninstall.sh
            cat "${yap_lib}/yap/base-utils.sh" | grep -v '^#' >> uninstall.sh
            if [[ -f "${tmpd}/source" ]] ; then
                local i=""
                local IFS=$" "
                for i in $(cat ${tmpd}/source) ; do
                    cat "${yap_lib}/yap/${i}.sh" | grep -v '^#' >> uninstall.sh
                    echo "" >> uninstall.sh
                done
            fi
            echo "" >> uninstall.sh
            cat "${tmpd}/build" | sed 's/yap:/reverse:/' >> uninstall.sh
        ;;
        *)
            cat - > yap-reverse.sh <<BUILDYAP
#!/bin/bash

set -e

# yap-build.sh Created Automatically by yap ${yap_version}

. "${yap_lib}/colorsh.sh"
. "${yap_lib}/tuiutils.sh"
. "${yap_lib}/alternatives.sh"
. "${yap_lib}/osutils.sh"
. "${yap_lib}/yap/base-utils.sh"
BUILDYAP
            if [[ -f "${tmpd}/source" ]] ; then
                local i=""
                local IFS=$" "
                for i in $(cat ${tmpd}/source) ; do
                    echo ". \"${yap_lib}/yap/${i}.sh\"" >> yap-reverse.sh
                done
            fi
            echo "" >> yap-reverse.sh
            cat "${tmpd}/build" | sed 's/yap:/reverse:/' >> yap-reverse.sh
            bash ./yap-reverse.sh || yap:core:die "1"
        ;;
    esac
    yap:core:die "0"
}