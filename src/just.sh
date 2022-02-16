#!/bin/bash

#########
# Build #
#########

build:jinstall() {
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

build:jmkdir() {
    mkdir -p ${@}
    tuiutil:notices --succsess "created directories: ${@}"
}

# Nil

build:juninstall() {
    true
}

########### 
# Reverse #
###########

reverse:juninstall() {
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

# Nil

reverse:jmkdir() {
    true
}

reverse:jinstall() {
    true
}