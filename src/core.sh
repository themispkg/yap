#!/bin/bash

yap_version="1.0.0"

yap_rootuser="${SUDO_USER:-$USER}"
yap_lib="/usr/local/lib/bash/5.17"
yap_cwd="${PWD}"

yap:core:die() {
    rm -rf "${tmpd}" 2> /dev/null
    exit "${1}"
}

yap:core:getlib() {
    local i
    if [[ "${#}" -gt 0 ]] ; then
        for i in $(seq 1 "${#}") ; do
            if [[ -f "${yap_lib}/${@:i:1}.sh" ]] ; then
                source "${yap_lib}/${@:i:1}.sh"
            elif [[ -f "${yap_lib}/${@:i:1}" ]] ; then
                source "${yap_lib}/${@:i:1}"
            else
                echo -e "\033[0;31mFatal:\033[0m couldn not sourcing '${@:i:1}'!"
                yap:core:die "1"
            fi
        done
    fi
}

yap:core:chkyapfile() {
    export yapfile="$(ls ./[yY][aA][pP][fF][iI][lL][eE] 2> /dev/null | awk 'NR==1')"
    if [[ ! -f ./"${yapfile}" ]] ; then
        tuiutil:notices --error "'Yapfile' not found!"
        exit 1
    fi
}

yap:core:fsplit() {
    cat "${1}" | awk '{if ($1 == "import") print $0}' | awk '{$1=""}1' | xargs > "${tmpd}/source"
    cat "${1}" | awk '{if ($1 == "import") $0=""}1' | grep 'yap:*' | sed '/^[[:space:]]*$/d' > "${tmpd}/build"
}

yap:core:chkimport() {
    if [[ -f "${tmpd}/source" ]] ; then
        local i
        local IFS=$" "
        for i in $(cat "${tmpd}/source") ; do
            if [[ ! -f "${yap_lib}/yap/${i}.sh" ]] ; then
                echo -e "\033[0;31mFatal:\033[0m couldn not sourcing '${i}'!"
                yap:core:die "1"
            fi
        done
    else
        tuiutil:notices --info "the 'source' dir does not exist."
    fi
}