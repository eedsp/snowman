#!/bin/bash

_OS_NAME=`uname -s`

if [ ${_OS_NAME} = "Darwin" ]; then
    if [ -z "${PKG_PATH}" ]; then
        PKG_PATH=/opt/local/pkg
    fi
elif [ ${_OS_NAME} = "Linux" ]; then
    if [ -z "${PKG_PATH}" ]; then
        PKG_PATH=/data/app/pkg
    fi
fi

#_SYS_PATH_=.pkg
#_SYS_PATH_="$(uname -m).pkg"

_APP_FRAMEWORK_PATH_="Frameworks/app.Framework"

if [ -n "${PKG_PATH}" ]; then
    _PKGX_PATH_=${PKG_PATH}/.pkg
fi

export PATH=/usr/bin:/bin:${PATH}

# #############################################################################

_BUILD_SCRIPT_PATH_=${PKG_BUILD_HOME}/packages
_BUILD_PATH_=${PKG_BUILD_HOME}/var/tmp
_SOURCE_PATH_=${PKG_BUILD_HOME}/var/src

if [ -n "${PKG_SOURCE_PATH}" ]; then
    _SOURCE_PATH_=${PKG_SOURCE_PATH}
fi

_BUILD_OPT=0
_BUILD_OPT_LINK=0

# #############################################################################

_vDATE=$(date +'%Y%m')
_LOG_HDR_FMT="%.23s[%3d] %s"
_LOG_MSG_FMT="${_LOG_HDR_FMT}%s\n"

_LOG_HDR_FMT_I="%.23s[%3d] [INFO] %s"
_LOG_MSG_FMT_I="${_LOG_HDR_FMT_I}%s\n"

log_msg() {
    #printf "$_LOG_MSG_FMT" $(date +%F.%T) ${BASH_SOURCE[1]##*/} ${BASH_LINENO[0]} "${@}"
    printf "${_LOG_MSG_FMT}" $(date +%F.%T) ${BASH_LINENO[0]} "${@}"
}

log_info() {
    printf "${_LOG_MSG_FMT_I}" $(date +%F.%T) ${BASH_LINENO[0]} "${@}"
}

# #############################################################################

func_mkdir() {
    local pDIR=${1}

    if [ -z "${pDIR}" ]; then
        log_msg "[ERROR] ${pDIR}: No such file or directory"
        exit
    fi

    if [ ! -e "${pDIR}" ]; then
        log_msg "[CMD] mkdir -p ${pDIR}"
        mkdir -p "${pDIR}"
    fi

    if [ ! -e "${pDIR}" ]; then
        log_msg "[ERROR] ${pDIR}: No such file or directory"
        exit
    fi
}

func_prepare_file() {
    local vFILE=${1}
    local vEXDIR=${2}
    local vRET=0
    local vEXT=${vFILE##*.} 

# FILE="example.tar.gz"
# echo "${FILE%%.*}"
# example
# echo "${FILE%.*}"
# example.tar
# echo "${FILE#*.}"
# tar.gz
# echo "${FILE##*.}"
# gz

# .gz, .tgz : tar xvfz
# .bz2      : tar xvfj
# .xz       : tar xvfJ
# zip       : unzip

    if [ -e "${vEXDIR}" ]; then
        if [ "${vEXT}" = "zip" ]; then
            log_msg "[CMD] unzip ${vFILE} -d ${vEXDIR}"
            unzip "${vFILE}" -d "${vEXDIR}"
        elif [ "${vEXT}" = "gz" ]; then
            log_msg "[CMD] tar xvfz ${vFILE} -C ${vEXDIR}"
            tar xvfz "${vFILE}" -C "${vEXDIR}"
        elif [ "${vEXT}" = "tgz" ]; then
            log_msg "[CMD] tar xvfz ${vFILE} -C ${vEXDIR}"
            tar xvfz "${vFILE}" -C "${vEXDIR}"
        elif [ "${vEXT}" = "bz2" ]; then
            log_msg "[CMD] tar xvfj ${vFILE} -C ${vEXDIR}"
            tar xvfj "${vFILE}" -C "${vEXDIR}"
        elif [ "${vEXT}" = "xz" ]; then
            log_msg "[CMD] tar xvfJ ${vFILE} -C ${vEXDIR}"
            tar xvfJ "${vFILE}" -C "${vEXDIR}"
        else
            log_msg "[ERROR] ${vFILE}: unknown format"
            vRET=1
        fi
    else
        log_msg "[ERR] ${vEXDIR}: No such file or directory"
        vRET=1
    fi

    return ${vRET}
}

func_check_build_path() {
    if [ -n "${_SOURCE_PATH_}" ]; then
        func_mkdir "${_SOURCE_PATH_}"
    else
        log_msg "[ERROR] \${_SOURCE_PATH_}: ${_SOURCE_PATH_}: No such file or directory"
        exit
    fi

    if [ -n "${_BUILD_PATH_}" ]; then
        func_mkdir "${_BUILD_PATH_}"
    else
        log_msg "[ERROR] \${_BUILD_PATH_}: ${_BUILD_PATH_}: No such file or directory"
        exit
    fi
}

func_check_install_path() {
    if [ -n "${_PKG_INSTALL_PREFIX_}" ]; then
        func_mkdir "${_PKG_INSTALL_PREFIX_}"
    else
        log_msg "[ERROR] \${_PKG_INSTALL_PREFIX_} : ${_PKG_INSTALL_PREFIX_}: No such file or directory"
        exit
    fi

    if [ -n "${_PKG_OPT_PATH_}" ]; then
        func_mkdir "${_PKG_OPT_PATH_}"
    else
        log_msg "[ERROR] \${_PKG_OPT_PATH_} : ${_PKG_OPT_PATH_}: No such file or directory"
    fi
}

# #############################################################################

func_pkgconfig()
{
    local _pPKG_LIST=${@}
    local _pPATH_LIST=(
        "/usr/local/opt"
        "${_PKG_OPT_PATH_}"
    )

    local _PKG_CONFIG_PATH_

    for PKG_CONFIG_prefix in ${_pPATH_LIST[@]}
    do
        for vPKG_NAME in  ${_pPKG_LIST[@]}
        do
            local _NEW_PATH="${PKG_CONFIG_prefix}/${vPKG_NAME}/lib/pkgconfig"
            if [ -e "${_NEW_PATH}" ]; then
                if [ -z "${_PKG_CONFIG_PATH_}" ]; then
                    _PKG_CONFIG_PATH_=${_NEW_PATH}
                    break
                else
                    _PKG_CONFIG_PATH_+=:${_NEW_PATH}
                    break
                fi
            fi
        done
    done

    if [ -n "${PKG_CONFIG_PATH}" ]; then
        _PKG_CONFIG_PATH_+=:${PKG_CONFIG_PATH}
    fi
    export PKG_CONFIG_PATH=${_PKG_CONFIG_PATH_}
}

# #############################################################################

func_link() {
    local _pNAME=${1}

    if [ ${_BUILD_OPT_LINK} -eq 0 ] && [ -n "${_pNAME}" ]; then
        local _PKG_NAME_=${_pNAME%%/*}

        if [ -n "${_xOPT_NAME}" ]; then
            _PKG_NAME_=${_xOPT_NAME}
        fi
        if [ -n  "${_PKG_NAME_}" ]; then
        (
            cd ${_PKG_OPT_PATH_} && (
            if [ -e "${_PKG_NAME_}" ]; then
                log_msg "[CMD] rm -rf ${_PKG_NAME_}"
                rm -rf "${_PKG_NAME_}"
            else
                log_msg "[WARN] ${_PKG_NAME_}: No such file or directory: SKIP"
            fi

            local xSRC="../${_APP_FRAMEWORK_PATH_}/${_pNAME}"

            if [ -e "${xSRC}" ] && [ ! -e "${_PKG_NAME_}" ]; then
                log_msg "[INFO] ln -s ${xSRC} ${_PKG_NAME_}"
                ln -s ../${_APP_FRAMEWORK_PATH_}/${_pNAME} ${_PKG_NAME_}
            else
                log_msg "[WARN] ${xSRC}: No such file or directory: SKIP"
            fi
            )
        )
        fi
    fi
}

func_build() {
    local _BUILD_OPT="${1}"
    local _PKG_FILE_="${2}"
    local _CONF_EXT="conf"

    if [ ${_BUILD_OPT} -eq 1 ]; then
        if [ -e "${_PKG_FILE_}" ]; then
            . ${_PKG_FILE_}
        else
            log_msg "[ERROR] ${_PKG_FILE_}: No such file or directory"
            exit
        fi
    else
        if [ -e "${_BUILD_SCRIPT_PATH_}/${_PKG_FILE_}" ]; then
            . ${_BUILD_SCRIPT_PATH_}/${_PKG_FILE_}
        elif [ -e "${_BUILD_SCRIPT_PATH_}/${_PKG_FILE_}.${_CONF_EXT}" ]; then
            . ${_BUILD_SCRIPT_PATH_}/${_PKG_FILE_}.${_CONF_EXT}
        else
            log_msg "[ERROR] ${_PKG_FILE_}: No such file or directory"
            exit
        fi
    fi

    pkg_info

    if [ $? -ne 0 ]; then
        log_msg "[INFO] ${_PKG_FILE_}::pkg_info() return ERROR"
        exit 1
    fi

    if [ -z "${_xFILE_PATH}" ]; then
        log_msg "[INFO] \${_xFILE_PATH}: string is null (an empty string)"
        exit
    fi
    if [ -z "${_xFILE}" ]; then
        log_msg "[INFO] \${_xFILE}: string is null (an empty string)"
        exit
    fi
    if [ -z "${_xNAME}" ]; then
        log_msg "[INFO] \${_xNAME}: string is null (an empty string)"
        exit
    fi

    if [ -z "${PREFIX}" ]; then
        PREFIX="${_PKG_INSTALL_PREFIX_}/${_xNAME}"
    else
        _BUILD_OPT_LINK=1
    fi

    log_msg "[INFO] _BUILD_PATH_ : ${_BUILD_PATH_}"
    log_msg "[INFO] _xDESC       : ${_xDESC}"
    log_msg "[INFO] _xFILE_PATH  : ${_xFILE_PATH}"
    log_msg "[INFO] _xFILE       : ${_xFILE}"
    log_msg "[INFO] APP_PATH     : ${APP_PATH}"
    log_msg "[INFO] PREFIX       : ${PREFIX}"

    #log_msg "[INFO] _BUILD_OPT   : ${_BUILD_OPT}"
    if [ ${_BUILD_OPT} -eq 0 ]; then

        log_msg "[INFO] find ${_SOURCE_PATH_} -name ${_xFILE} -print | head -n 1"
        local _xSRC_FILE=$(find ${_SOURCE_PATH_} -name ${_xFILE} -print | head -n 1)
        log_msg "[INFO] ${_xSRC_FILE}"
        if [ -n "${_xSRC_FILE}" ]; then
            func_prepare_file "${_xSRC_FILE}" "${_BUILD_PATH_}"

            if [ -e "${_BUILD_PATH_}/${_xFILE_PATH}" ]; then
            (
                cd "${_BUILD_PATH_}/${_xFILE_PATH}" && (
                    log_msg "[INFO] >>>> ${_xFILE_PATH}"
                    pkg_build
                    log_msg "[INFO] <<<< ${_xFILE_PATH}"
                )
            )
            else
                log_msg "[ERROR] ${_BUILD_PATH_}/${_xFILE_PATH}: No such file or directory"
                exit
            fi
        fi
    else
        log_msg "[INFO] >>>> ${_xFILE_PATH}"
        pkg_build
        log_msg "[INFO] <<<< ${_xFILE_PATH}"
    fi

    func_link ${_xNAME}
}

# #############################################################################

func_config() {
    if [ -z "${APP_PATH}" ]; then
        log_info "\${APP_PATH}: No such file or directory"
        exit
    fi

    _PKG_INSTALL_PREFIX_=${APP_PATH}/${_APP_FRAMEWORK_PATH_}
    _PKG_OPT_PATH_="${APP_PATH}/opt"

    func_check_build_path
    func_check_install_path
}

func_help() {
    log_msg "[HELP] ${0} -f <package-name>"
    log_msg "[HELP] ${0} package-names..."
}

# #############################################################################

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
opt_build_only=0
xPKG_LIST=()

if [ ${#@} -ne 0 ]; then
    while getopts "h?f:" opt; do
    case "${opt}" in
        h|\?)
            func_help
            exit 0
            ;;
        f)  xPKG_LIST+=( ${OPTARG} )
            opt_build_only=1
            ;;
        esac
    done

    shift $((OPTIND-1))

    [ "$1" = "--" ] && shift

    if [ $opt_build_only -eq 0 ]; then
        for x in ${@}
        do
            log_msg "[INFO] $x"
            xPKG_LIST+=( ${x} )
        done
    fi

    func_config
    log_msg "[INFO] \${_PKG_INSTALL_PREFIX_}: ${_PKG_INSTALL_PREFIX_}"

    for xPKG_NAME in ${xPKG_LIST[@]}
    do
        if [ -n "${xPKG_NAME}" ] && [ -n "${_BUILD_PATH_}" ]; then
            log_msg "[INFO] Package: ${xPKG_NAME}"
            func_build ${opt_build_only} ${xPKG_NAME}
        fi
    done
else
    func_help
fi


