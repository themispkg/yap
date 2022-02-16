#!/bin/bash

# colorsh, tuiutils, alternatives and osutils is already sourced, so we can use that functions.

#########
# Build #
#########

build:trigger() {
    case "${1}" in
        [fF][aA][tT][aA][lL]|--[fF][aA][tT][aA][lL]|-[fF])
            osutil:check --trigger ${@:2} || exit "$?"
        ;;
        *)
            osutil:check --trigger ${@:1} || return "$?"
        ;;
    esac
}

build:distro() {
    case "${1}" in
        [fF][aA][tT][aA][lL]|--[fF][aA][tT][aA][lL]|-[fF])
            if [[ "$(osutil:define --base)" = "${@:2:1}" ]] ; then
                tuiutil:notices --succsess "this distro is ${@:2:1} based"
            else
                tuiutil:notices --error "this distro isn't ${@:2:1} based" || exit "$?"
            fi
        ;;
        *)
            if [[ "$(osutil:define --base)" = "${@:1:1}" ]] ; then
                tuiutil:notices --succsess "this distro is ${@:1:1} based"
            else
                tuiutil:notices --error "this distro isn't ${@:1:1} based" || exit "$?"
            fi
        ;;
    esac
}

########### 
# Reverse #
###########

reverse:trigger() {
    true
}

reverse:distro() {
    case "${1}" in
        [fF][aA][tT][aA][lL]|--[fF][aA][tT][aA][lL]|-[fF])
            if [[ "$(osutil:define --base)" = "${@:2:1}" ]] ; then
                tuiutil:notices --succsess "this distro is ${@:2:1} based"
            else
                tuiutil:notices --error "this distro isn't ${@:2:1} based" || exit "$?"
            fi
        ;;
        *)
            if [[ "$(osutil:define --base)" = "${@:1:1}" ]] ; then
                tuiutil:notices --succsess "this distro is ${@:1:1} based"
            else
                tuiutil:notices --error "this distro isn't ${@:1:1} based" || exit "$?"
            fi
        ;;
    esac
}