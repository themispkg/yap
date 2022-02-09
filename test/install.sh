#!/bin/bash

# Yap Install File Created Automatically by yap 1.0.0




reset='\033[0m'           # Text Reset

black='\033[0;30m'        # Black
red='\033[0;31m'          # Red
green='\033[0;32m'        # Green
yellow='\033[0;33m'       # Yellow
blue='\033[0;34m'         # Blue
purple='\033[0;35m'       # Purple
cyan='\033[0;36m'         # Cyan
white='\033[0;37m'        # White

Bblack='\033[1;30m'       # Black
Bred='\033[1;31m'         # Red
Bgreen='\033[1;32m'       # Green
Byellow='\033[1;33m'      # Yellow
Bblue='\033[1;34m'        # Blue
Bpurple='\033[1;35m'      # Purple
Bcyan='\033[1;36m'        # Cyan
Bwhite='\033[1;37m'       # White

Ublack='\033[4;30m'       # Black
Ured='\033[4;31m'         # Red
Ugreen='\033[4;32m'       # Green
Uyellow='\033[4;33m'      # Yellow
Ublue='\033[4;34m'        # Blue
Upurple='\033[4;35m'      # Purple
Ucyan='\033[4;36m'        # Cyan
Uwhite='\033[4;37m'       # White

BGblack='\033[40m'        # Black
BGred='\033[41m'          # Red
BGgreen='\033[42m'        # Green
BGyellow='\033[43m'       # Yellow
BGblue='\033[44m'         # Blue
BGpurple='\033[45m'       # Purple
BGcyan='\033[46m'         # Cyan
BGwhite='\033[47m'        # White

Iblack='\033[0;90m'       # Black
Ired='\033[0;91m'         # Red
Igreen='\033[0;92m'       # Green
Iyellow='\033[0;93m'      # Yellow
Iblue='\033[0;94m'        # Blue
Ipurple='\033[0;95m'      # Purple
Icyan='\033[0;96m'        # Cyan
Iwhite='\033[0;97m'       # White

BIblack='\033[1;90m'      # Black
BIred='\033[1;91m'        # Red
BIgreen='\033[1;92m'      # Green
BIyellow='\033[1;93m'     # Yellow
BIblue='\033[1;94m'       # Blue
BIpurple='\033[1;95m'     # Purple
BIcyan='\033[1;96m'       # Cyan
BIwhite='\033[1;97m'      # White

BGIblack='\033[0;100m'   # Black
BGIred='\033[0;101m'     # Red
BGIgreen='\033[0;102m'   # Green
BGIyellow='\033[0;103m'  # Yellow
BGIblue='\033[0;104m'    # Blue
BGIpurple='\033[0;105m'  # Purple
BGIcyan='\033[0;106m'    # Cyan
BGIwhite='\033[0;107m'   # White

colorsh:random() {
    case "${1}" in
        cool)
            local bold="$(( $RANDOM % 2 ))"
            local code="$(( 30 + $RANDOM % 8 ))"
            printf "%d;%d\n" $bold $code
        ;;
        *)
            echo -ne "\e[3$(( $RANDOM * 6 / 32767 + 1 ))m"
        ;;
    esac
}

colorsh:rainbow() {
	sentence="$*"
	for (( i=0; i<${#sentence}; i++ )); do
	    printf "\e[%sm%c" "$(random_colour)" "${sentence:i:1}"
	done
	echo -e '\e[0m'
}




tuiutil:yesno() {
    # Usage, directly:
    # tuiutil:yesno

    read -r -p "are you sure you want to continue? [Y/n] " tuiutil_response
    case "${response}" in
        [nN]) 
            return 1    
        ;;
        *)
            return 0
        ;;
    esac

}

tuiutil:pressanykey() {
    # Usage:
    # tuiutil:pressanykey --time 5 // this will end after 5 seconds 
    # or
    # tuiutil:pressanykey // but this not will end if user cannot intervene

    case "${1}" in
        [tT][iI][mM][eE]|--[tT][iI][mM][eE]|-[tT])
            [[ -z "${2}" ]] && local second="3" || local second="${2}"
            echo -n "pls wait (${second}sec)..." ; read -t "${second}" -n 1 -r -s -p $'Or Press Any Key To Continue\n'
        ;;
        *)
            read -n 1 -r -s -p $'Press Any Key To Continue...\n'
        ;;
    esac
}

tuiutil:spinner() {
    # Usage:
    # tuiutil:spinner "1" // Classic spinner like "[===      ]" 
    #also you can change the speed with $2 parametre
   
    case "${1}" in
        [oO][nN][eE]|--[oO][nN][eE]|1)
            local count=0
            local total="34"
            local pstr="[=======================================================================]"
            
            [[ -z "${2}" ]] && local sleep="0.5" || local sleep="${2}"

            while [ $count -lt $total ] ; do
                local count=$(( $count + 2 ))
                local pd=$(( $count * 73 / $total ))
                printf "\r%3d.%1d%% %.${pd}s" $(( $count * 100 / $total )) $(( ($count * 1000 / $total) % 100 )) "${pstr}"
                sleep "${sleep}"
            done
        ;;
    esac
}

tuiutil:text() {
    # Usage:
    # tuiutil:text --center-padding "x" "-"
    # tuiutil:text --center "x"

    case "${1}" in
        [cC][eE][nN][tT][eE][rR]-[pP][aA][dD][dD][iI][nN][gG]|--[cC][eE][nN][tT][eE][rR]|-[cC][pP])
            local terminalwidth="$(tput cols)"
            [[ -z ${2} ]] && local text="*" || local text="${2}"
            [[ -z ${3} ]] && local setchar="=" || local setchar="${3}"
            
            local padding="$(printf '%0.1s' "${setchar}"{1..500})"
            printf '%*.*s %s %*.*s\n' 0 "$(((terminalwidth-2-${#text})/2))" "$padding" "$text" 0 "$(((terminalwidth-1-${#text})/2))" "$padding"
        ;;
        [cC][eE][nN][tT][eE][rR]|--[cC][eE][nN][tT][eE][rR]|-[cC])
            local column=$(tput cols)
            [[ -z "${2}" ]] && local title="${FUNCNAME[0]}" || local title="${2}"
            printf "%*s\n" $(((${#title}+$column)/2)) "$title"
        ;;
    esac
}

tuiutil:simulate() {
    # Usage:
    # tuiutil:simulate --text "string"

    case "${1}" in
        [tT][eE][xX][tT]|--[tT][eE][xX][tT]|-[tT])
            [[ -z "${2}" ]] && local text="${FUNCNAME[0]}" || local text="${2}"
            [[ -z "${3}" ]] && local sleep="0.075" || local sleep="${3}"
            
            for ((i=0; i<${#text}; i++)) ; do  
                sleep "${sleep}"
                printf "${text:$i:1}"
            done
        ;;
    esac
}

tuiutil:notices() {
    # Usage:
    # tuiutil:notices --error "string" "1"
    # tuiutil:notices --succsess "string"
    # tuiutil:notices --warn "string"
    # tuiutil:notices --info "string"

    case "${1}" in
        [eE][rR][rR][oO][rR]|--[eE][rR][rR][oO][rR]|-[eE])
            [[ -z "${2}" ]] && local text="${FUNCNAME[0]}" || local text="${2}"
            echo -e "\033[0;31merror\033[0m:   ${text}."
            return 1
        ;;
        [sS][uU][cC][cC][sS][eE][sS][sS]|--[sS][uU][cC][cC][sS][eE][sS][sS]|-[sS])
            [[ -z "${2}" ]] && local text="${FUNCNAME[0]}" || local text="${2}"
            echo -e "\033[0;32msuccess\033[0m: ${text}."
        ;;
        [wW][aA][rR][nN]|--[wW][aA][rR][nN]|-[wW])
            [[ -z "${2}" ]] && local text="${FUNCNAME[0]}" || local text="${2}"
            echo -e "\033[0;33mwarning\033[0m: ${text}!"
        ;;
        [iI][nN][fF][oO]|--[iI][nN][fF][oO]|-[iI])
            [[ -z "${2}" ]] && local text="${FUNCNAME[0]}" || local text="${2}"
            echo -e "\033[0;34minfo\033[0m:    ${text}."
        ;;
    esac
}



alternatives:filename() {
    command -v "seq" &> /dev/null || return 1
    command -v "awk" &> /dev/null || return 1
    command -v "tr" &> /dev/null || return 1

    if [[ "${#}" -gt 0 ]] ; then
        if ! command -v filename &> /dev/null ; then
            for y in $(seq 1 ${#}) ; do
                echo ${@:y:1} | tr "/" " " | awk '{print $NF}'
            done
        else
            filename ${@}
        fi
    else
        echo -e "Usage: enter parametres as file/directory path. Example:\n> alternatives:filename /tmp/test/test.sh\n< test.sh"
        return 1
    fi
}

alternatives:install() {
    command -v "chmod" &> /dev/null || return 1
    command -v "cp" &> /dev/null || return 1

    case "${1}" in
        [mM][oO][dD]|--[mM][oO][dD]|-[mM])
            if [[ "${#}" -lt 5 ]] ; then
                local set_mod="${2}"
                cp -r "${3}" "${4}"
                if [[ "$(alternatives:filename "$_")" = "$(alternatives:filename "${3}")" ]] ; then
                    chmod "${set_mod}" "$_"
                else
                    chmod "${set_mod}" "${4}"
                fi
            else
                echo "insufficient argument"
                return 1 # stderr
            fi
        ;;
        *)
            if [[ "${#}" -lt 3 ]] ; then
                cp -r "${1}" "${2}"
            else
                echo "insufficient argument"
                return 1 # stderr
            fi
        ;;
    esac
}

alternatives:mktemp() {
    command -v "mkdir" &> /dev/null || return 1
    command -v "touch" &> /dev/null || return 1
    command -v "head" &> /dev/null || return 1
    command -v "tr" &> /dev/null || return 1

    alternatives:mktemp:build:random:string() {
        < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c "${1}"
    }

    case "${1}" in
        [dD][iI][rR][eE][cC][tT][oO][rR][yY]|--[dD][iI][rR][eE][cC][tT][oO][rR][yY]|-[dD])
            if [[ -d "/tmp" ]] ; then
                while :; do
                    local digit="8"
                    local dir="/tmp/tmp.$(alternatives:mktemp:build:random:string "${digit}")"
                    if [[ ! -d "${dir}" ]] ; then
                        mkdir -p "${dir}" &> /dev/null
                        echo "${dir}"
                        break
                    fi
                done
            else
                return 1
            fi
        ;;
        *)
            if [[ -d "/tmp" ]] ; then
                while :; do
                    local digit="8"
                    local file="/tmp/tmp.$(alternatives:mktemp:build:random:string "${digit}")"
                    if [[ ! -e "${file}" ]] ; then
                        touch "${file}" &> /dev/null
                        echo "${file}"
                        break
                    fi
                done
            else
                return 1
            fi
        ;;
    esac
}



osutil:check() {
    case "${1}" in
        [rR][oO][oO][tT]|--[rR][oO][oO][tT]|-[rR])
            case "${2}" in
                [sS][iI][lL][eE][nN][tT]|--[sS][iI][lL][eE][nN][tT]|-[sS])
                    if [[ ${UID} != 0 ]] ; then
                        return 1
                    fi
                ;;
                *)
                    if [[ "${UID}" != 0 ]] ; then
                        echo -e "\033[0;31mplease run it as root privalages(!)\033[0m"
                        return 1
                    fi
                ;;
            esac
        ;;
        [fF][iI][lL][eE]|--[fF][iI][lL][eE]|-[fF])
            local x="true"
            for i in "${@:2}" ; do
                if ! [[ -f "${i}" ]] ; then
                    echo -e "file ${i} does not exist!"
                    local x="false"
                fi
            done

            if [[ "${x}" = "false" ]] ; then
                return 1
            fi
        ;;
        [tT][rR][iI][gG][gG][eE][rR]|--[tT][rR][iI][gG][gG][eE][rR]|-[tT])
            local x="true"
            for i in "${@:2}" ; do
                if !  command -v "${i}" &> /dev/null ; then
                    echo -e "trigger ${i} not found!"
                    local x="false"
                fi
            done

            if [[ "${x}" = "false" ]] ; then
                return 1
            fi
       
        ;;
        [dD][iI][rR][eE][cC][tT][oO][rR][yY]|--[dD][iI][rR][eE][cC][tT][oO][rR][yY]|-[dD][iI][rR])
            local x="true"
            for i in "${@:2}" ; do
                if ! [[ -d "${i}" ]] ; then
                    echo -e "directory ${i} does not exist!"
                    local x="false"
                fi
            done

            if [[ "${x}" = "false" ]] ; then
                return 1
            fi
        ;;
    esac
}

osutil:define() {
    case "${1}" in
        [bB][aA][sS][eE]|--[bB][aA][sS][eE]|-[bB])
            case "${2}" in
                [sS][iI][lL][eE][nN][tT]|--[sS][iI][lL][eE][nN][tT]|-[sS])
                    if [[ -e /etc/debian_version ]] ; then
                        sysbase="debian"
                    elif [[ -e /etc/arch-release ]] ; then
                        sysbase="arch"
                    elif [[ -e /etc/artix-release ]] ; then
                        sysbase="arch"
                    elif [[ -e /etc/fedora-release ]] ; then
                        sysbase="fedora"
                    elif [[ -e /etc/pisi-release ]] ; then
                        sysbase="pisi"
                    elif [[ -e /etc/zypp/zypper.conf ]] ; then
                        sysbase="opensuse"
                    else
                        sysbase="unknow"
                    fi
                ;;
                *)
                    if [[ -e /etc/debian_version ]] ; then
                        echo "debian"
                    elif [[ -e /etc/arch-release ]] ; then
                        echo "arch"
                    elif [[ -e /etc/artix-release ]] ; then
                        echo "arch"
                    elif [[ -e /etc/fedora-release ]] ; then
                        echo "fedora"
                    elif [[ -e /etc/pisi-release ]] ; then
                        echo "pisi"
                    elif [[ -e /etc/zypp/zypper.conf ]] ; then
                        echo "opensuse"
                    else
                        echo "unknow"
                    fi
                ;;
            esac
        ;;
        [iI][sS]-[aA][rR][cC][hH]|--[iI][sS]-[aA][rR][cC][hH]|-[iI][aA])
            case "${2}" in
                [xX]86)
                    if [[ $(uname -i) = "x86" ]] ; then
                        return 0
                    else
                        return 1
                    fi
                ;;
                [xX]64|[xX]86_[xX]64)
                    if [[ $(uname -i) = "x86_64" ]] ; then
                        return 0
                    else
                        return 1
                    fi
                ;;
                [aA][aA][rR][cC][hH]64)
                    if [[ $(uname -i) = "aarch64" ]] ; then
                        return 0
                    else
                        return 1
                    fi
                ;;
            esac            
        ;;
    esac
}

osutil:update() {
    # just run this function ostutil:update
    osutil:check --root || exit 1
    case "$(osutil:define --base)" in
        debian)
            apt update
        ;;
        arch)
            pacman -Syy
        ;;
        fedora)
            dnf check-update
        ;;
        pisi)
            pisi ur
        ;;
        opensuse)
            zypper refresh
        ;;
        unknow)
            echo "unknow base so there is nothing to do"
            return 1
        ;;
    esac   
}

osutil:install() {
    # osutil:install <package as base> <package as base>..
    osutil:check --root || exit 1
    case "$(osutil:define --base)" in
        debian)
            apt install -y ${1}
        ;;
        arch)
            pacman -Sy --noconfirm ${1}
        ;;
        fedora)
            dnf install -y ${1}
        ;;
        pisi)
            pisi it -y ${1}
        ;;
        opensuse)
            zypper remove --no-confirm ${1}
        ;;
    esac
    
}

osutil:uninstall() {
    # osutil:uninstall <package as base> <package as base>..
    osutil:check --root || exit 1
    case "$(osutil:define --base)" in
        debian)
            apt remove -y ${1}
        ;;
        arch)
            pacman -R --noconfirm ${1}
        ;;
        fedora)
            dnf remove -y ${1}
        ;;
        pisi)
            pisirmt -y ${1}
        ;;
        opensuse)
            zypper remove --no-confirm ${1}
        ;;
    esac
}



