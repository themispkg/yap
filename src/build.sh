#!/bin/bash

yap:build:main() {
    tmpd="$(mktemp -d)"
    yap:core:chkyapfile
    yap:core:fsplit "${yapfile}"
    yap:core:chkimport
    case "${1}" in
        [gG][eE][nN][eE][rR][aA][tT][eE]-[fF][uU][lL][lL]|--[gG][eE][nN][eE][rR][aA][tT][eE]-[fF][uU][lL][lL]|-[gG][fF])
            cat - > install.sh <<INSTALLFILE
#!/bin/bash

# install.sh Created Automatically by yap ${yap_version}

INSTALLFILE
            cat "${yap_lib}/colorsh.sh" | grep -v '^#' >> install.sh
            echo "" >> install.sh
            cat "${yap_lib}/tuiutils.sh" | grep -v '^#' >> install.sh
            echo "" >> install.sh
            cat "${yap_lib}/alternatives.sh" | grep -v '^#' >> install.sh
            echo "" >> install.sh
            cat "${yap_lib}/osutils.sh" | grep -v '^#' >> install.sh
            echo "" >> install.sh
            cat "${yap_lib}/yap/base-utils.sh" | grep -v '^#' >> install.sh
            if [[ -f "${tmpd}/source" ]] ; then
                local i=""
                local IFS=$" "
                for i in $(cat ${tmpd}/source) ; do
                    cat "${yap_lib}/yap/${i}.sh" | grep -v '^#' >> install.sh
                    echo "" >> install.sh
                done
            fi
            echo "" >> install.sh
            cat "${tmpd}/build" | sed 's/yap:/build:/' >> install.sh
        ;;
        *)
            cat - > yap-build.sh <<BUILDYAP
#!/bin/bash

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
                    echo ". \"${yap_lib}/yap/${i}.sh\"" >> yap-build.sh
                done
            fi
            echo "" >> yap-build.sh
            cat "${tmpd}/build" | sed 's/yap:/build:/' >> yap-build.sh
            bash ./yap-build.sh || yap:core:die "1"
        ;;
    esac
    yap:core:die "0"
}