#!/bin/bash

#########
# Build #
#########

export CONFDIR="$(mkdir -p /tmp/yapconf)"

build:config() {
    case "${1}" in
        [vV][aA][rR][iI][aA][bB][lL][eE]|--[vV][aA][rR][iI][aA][bB][lL][eE]|-[vV])
            if [[ "${1}" -eq "3" ]] ; then
                echo "${3}" > "${CONFDIR}/${2}"
            else
                return 1
            fi
        ;;
        [cC][aA][lL][lL]-[vV][aA][rR][iI][aA][bB][lL][eE]|--[cC][aA][lL][lL]-[vV][aA][rR][iI][aA][bB][lL][eE]|-[cC][vV])
            if [[ -f "${CONFDIR}/${2}" ]] ; then
                cat "${CONFDIR}/${2}"
            else
                return 1
            fi
        ;;
    esac
}

########### 
# Reverse #
###########

reverse:config() {
    case "${1}" in
        [vV][aA][rR][iI][aA][bB][lL][eE]|--[vV][aA][rR][iI][aA][bB][lL][eE]|-[vV])
            if [[ "${1}" -eq "3" ]] ; then
                echo "${3}" > "${CONFDIR}/${2}"
            else
                return 1
            fi
        ;;
        [cC][aA][lL][lL]-[vV][aA][rR][iI][aA][bB][lL][eE]|--[cC][aA][lL][lL]-[vV][aA][rR][iI][aA][bB][lL][eE]|-[cC][vV])
            if [[ -f "${CONFDIR}/${2}" ]] ; then
                cat "${CONFDIR}/${2}"
            else
                return 1
            fi
        ;;
    esac
}