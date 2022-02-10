#!/bin/bash

yutils:parse:fname() {
    if [[ -d "${2}" ]] ; then
        echo "${2}/${1}"
    else
        echo "${2}"
    fi
}