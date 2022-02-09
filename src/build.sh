#!/bin/bash

yap:build:main() {
    tmpd="$(mktemp -d)"
    yap:core:chkyapfile
    yap:core:fsplit "${yapfile}"
    yap:core:chkimport
    case "${1}" in
        [gG][eE][nN][eE][rR][aA][tT][eE]-[fF][uU][lL][lL]|--[gG][eE][nN][eE][rR][aA][tT][eE]-[fF][uU][lL][lL]|-[gG][fF])
            :
        ;;
        *)
            cat - > ./"yap-build.sh" <<BUILDYAP
#!/bin/bash

# Yap Build File Created Automatically by yap ${yap_version}

. "${yap_lib}/colorsh.sh"
. "${yap_lib}/tuiutils.sh"
. "${yap_lib}/alternatives.sh"
. "${yap_lib}/osutils.sh"
. "${yap_lib}/yap/base-utils.sh"
BUILDYAP
            if [[ -f "${tmpd}/source" ]] ; then
                local i=""
                local IFS=$" "
                for i in $(cat ${tmpd}/source) ; do
                    echo ". \"${yap_lib}/yap/${i}.sh\"" >> ./"yap-build.sh"
                done
            fi
            echo "" >> ./"yap-build.sh"
            cat ./"yap-build.sh"
            cat 
        ;;
    esac
    yap:core:die "0"
}

# TODO:
# Generate full argümanı source kaynaklarını da kapsayarak yeni bir dosya oluşturur adı da 
# 'install.sh' olur ileriki zamanlarda uninstall'ı da çıkartılabilir
#
# Normal kullanımı ise 'yap-build.sh' dosyası hazırlanarak çalıştırılır.