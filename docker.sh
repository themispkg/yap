#!/bin/bash

# Dockerfile builder for yap (only for test).

# Exit status:
# exit status 0: all good and next time you can just type 'sudo docker run --rm -it yap:<tag>'
# exit status 1: not found!
# exit status 2: not permited!
# exit status 3: unknow option!

command -v docker &> /dev/null || exit 1

case "${1}" in
    [dD][eE][bB][iI][aA][nN]|--[dD][eE][bB][iI][aA][nN]|-[dD])
        [[ "${UID}" != 0 ]] && { echo "Please run it with root privalages"; exit 1; }
        docker pull debian
        cat - > Dockerfile <<DEBIAN
FROM debian

COPY . /app/yap
WORKDIR /app/yap
RUN apt update && apt install -y make git gcc tar findutils
RUN make install
WORKDIR ~
ENTRYPOINT /bin/bash
DEBIAN
        docker build --tag yap:debian .
        docker run --rm -it yap:debian
        exit 0
    ;;
    [uU][bB][uU][nN][tT][uU]|--[uU][bB][uU][nN][tT][uU]|-[uU])
        [[ "${UID}" != 0 ]] && { echo "Please run it with root privalages"; exit 1; }
        docker pull ubuntu
        cat - > Dockerfile <<UBUNTU
FROM ubuntu
RUN apt update && apt install -y make git gcc tar findutils
COPY . /app/yap
WORKDIR /app/yap

RUN make install
WORKDIR ~
ENTRYPOINT /bin/bash
UBUNTU
        docker build --tag yap:ubuntu .
        docker run --rm -it yap:ubuntu
        exit 0
    ;;
    [aA][rR][cC][hH]|--[aA][rR][cC][hH]|-[aA])
        [[ "${UID}" != 0 ]] && { echo "Please run it with root privalages"; exit 1; }
        docker pull archlinux
        cat - > Dockerfile <<ARCH
FROM archlinux

COPY . /app/yap
WORKDIR /app/yap
RUN pacman -Syy --noconfirm git make gcc tar findutils
RUN make install
WORKDIR ~
ENTRYPOINT /bin/bash
ARCH
        docker build --tag yap:arch .
        docker run --rm -it yap:arch
        exit 0
    ;;
    [oO][pP][eE][nN][sS][uU][sS][eE]|--[oO][pP][eE][nN][sS][uU][sS][eE]|-[oO])
        [[ "${UID}" != 0 ]] && { echo "Please run it with root privalages"; exit 1; }
        docker pull opensuse/tumbleweed
        cat - > Dockerfile <<OPENSUSE
FROM opensuse/tumbleweed

COPY . /app/yap
WORKDIR /app/yap
RUN zypper ref && zypper --non-interactive install git make gcc tar findutils
RUN make install
WORKDIR ~
ENTRYPOINT /bin/bash
OPENSUSE
        docker build --tag yap:opensusetw .
        docker run --rm -it yap:opensusetw
        exit 0
    ;;
    *)
        echo "Invalid usage! there are 4 options: --debian, --ubuntu, --arch, --opensuse"
        exit 3
    ;;
esac