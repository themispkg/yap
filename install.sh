#!/bin/bash

# Install script for yap created manually.
# Pre-Reqs: gawk, GNUcore-utils, findutils, git, gcc, tar
#
# Builded structures:
#			directories:
#					/usr/local/lib/bash/5.17/yap
#			specific files:
#					/usr/bin/yap

# Ey peygamber! Eşlerine şöyle de: “Dünya hayatını ve güzelliklerini istiyorsanız gelin size bir şeyler vereyim sonra da güzellikle sizi serbest bırakayım.
# Yok eğer Allah’ı, resulünü ve âhiret yurdunu istiyorsanız şunu bilin ki Allah, içinizden güzel davrananlara büyük bir ödül hazırlamıştır.” --ahzab 28-29

export cwd="${PWD}"

[[ "${UID}" != 0 ]] && { echo "Run this with root privalages!" ; exit 1 ;}

die() {
	echo "${1}"
	exit "${2}"
}

check() {
	echo -n "checking for '${1}'.. "
	command -v "${1}" &> /dev/null && echo "ok" || die "no" "$?"
}

# it does not cover the dependencies of dependencies
check git
check tar
check gcc
check install
check awk
check mktemp
check xargs
check chmod
check chown
check cp
check ln
check ls
check mkdir
check mv
check rm
check rmdir
check touch
check basename
check cat
check comm
check cut
check dirname
check echo
check expand
check false
check true
check head
check seq
check sort
check tail
check tee
check tr
check uniq
check wc
check env
check date

# if you can't pass this stage then try to install 'Pre-Reqs'.

echo -n "checking for 'bash-utils'.. "
if ! ls /usr/local/lib/bash/5.17/{alternatives,colorsh,osutils,tuiutils}.sh &> /dev/null ; then
        echo "no"
        git clone "https://github.com/themispkg/bash-utils"
        cd "bash-utils"
        make install || die "could not getting 'bash-utils'" "$?"
        cd "${cwd}"
else
        echo "ok"
fi

echo -n "creating directories.. "
mkdir -p /usr/local/lib/bash/5.17/yap
echo "ok"

echo -n "installing libraries and triggers.. "
install -m 755 ./src/*.sh /usr/local/lib/bash/5.17/yap
install -m 777 ./yap.sh /usr/bin/yap
echo "ok"