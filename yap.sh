#!/bin/bash

#    Alternative System Build Tool - Yet Another Program/System Builder 1.0.0
#    Copyright (C) 2022  lazypwny751
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

. /usr/local/lib/bash/5.17/yap/init.sh || { echo -e "\033[0;31mFatal:\033[0m could not initalizing in this time." ; exit 1 ; }

case "${1}" in
    [bB][uU][iI][lL][dD]|--[bB][uU][iI][lL][dD]|-[bB])
        case "${1}" in
            [rR][eE][vV][eE][rR][sS][eE]|--[rR][eE][vV][eE][rR][sS][eE]|-[rR])
                :
            ;;
            *)
                yap:core:getlib "yap/build"
                yap:build:main -gf
            ;;
        esac
    ;;
    [rR][eE][vV][eE][rR][sS][eE]|--[rR][eE][vV][eE][rR][sS][eE]|-[rR])
        :
    ;;
    [vV][eE][rR][sS][iI][oO][nN]|--[vV][eE][rR][sS][iI][oO][nN]|-[vV])
        :
    ;;
    [hH][eE][lL][pP]|--[hH][eE][lL][pP]|-[hH])
        :
    ;;
    *)
        yap:core:getlib "yap/build"
        yap:build:main
    ;;
esac