#!/bin/bash

export SUDOUSER="${SUDO_USER:-$USER}"

# colorsh, tuiutils, alternatives and osutils is already sourced, so we can use that functions.

build:install() {
    case "${1}" in
        [mM][oO][dD]|--[mM][oO][dD]|-[mM])
            cp "${3}" "$(osutil:getfname "${3}" "${4}")"
            chmod "${2}" "$(osutil:getfname "${3}" "${4}")"
            tuiutil:notices --info "$(osutil:getfname "${3}" "${4}")"
        ;;
        *)
            cp "${1}" "$(osutil:getfname "${1}" "${2}")"
            tuiutil:notices --info "$(osutil:getfname "${3}" "${4}")"
        ;;
    esac
}

reverse:install() {
    case "${1}" in
        [mM][oO][dD]|--[mM][oO][dD]|-[mM])
            rm -rf "$(osutil:getfname "${3}" "${4}")"
        ;;
        *)
            rm -rf "$(osutil:getfname "${1}" "${2}")"
        ;;
    esac
}