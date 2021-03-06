#!/bin/bash

# colorsh, tuiutils, alternatives and osutils is already sourced, so we can use that functions.

CWD="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

#########
# Build #
#########

build:install() {
    case "${1}" in
        [mM][oO][dD]|--[mM][oO][dD]|-[mM])
            cp -r "${3}" "$(osutil:getfname "${3}" "${4}")"
            chmod "${2}" "$(osutil:getfname "${3}" "${4}")"
            tuiutil:notices --succsess "$(osutil:getfname "${3}" "${4}")"
        ;;
        *)
            cp -r "${1}" "$(osutil:getfname "${1}" "${2}")"
            tuiutil:notices --succsess "$(osutil:getfname "${3}" "${4}")"
        ;;
    esac
}

build:mkdir() {
    mkdir -p ${@}
    tuiutil:notices --succsess "created directories: ${@}"
}

build:rename() {
    if [[ "${#}" -ge 2 ]] && [[ -e "${2}" ]] ; then
        local basename="$(realpath $(dirname "${2}"))"
        mv "${2}" "${basename}/${1}"
        tuiutil:notices --succsess "${2} -> "${basename}/${1}""
    else
        tuiutil:notices --info "nothing to do."
    fi
}

########### 
# Reverse #
###########

reverse:install() {
    case "${1}" in
        [mM][oO][dD]|--[mM][oO][dD]|-[mM])
            rm -rf "$(osutil:getfname "${3}" "${4}")"
            tuiutil:notices --succsess "removed ${red}$(osutil:getfname "${3}" "${4}")${reset}"
        ;;
        *)
            rm -rf "$(osutil:getfname "${1}" "${2}")"
            tuiutil:notices --succsess "removed ${red}$(osutil:getfname "${1}" "${2}")${reset}"
        ;;
    esac
}

reverse:mkdir() {
    rm -rf ${@}
    tuiutil:succsess --info "removed directories: ${@}"
}

reverse:rename() {
    true
}