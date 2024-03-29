#!/bin/bash

_OS_NAME=`uname -s`

_APP_FRAMEWORK_PATH_="Framework"
_PKG_LIST_FILE=pkg.list.conf

export PATH=/usr/bin:/bin:${PATH}

# #############################################################################

_vDATE=$(date +'%Y%m')
_LOG_HDR_FMT="%.23s[%3d] %s"
_LOG_MSG_FMT="${_LOG_HDR_FMT}%s\n"

log_msg() {
  #printf "$_LOG_MSG_FMT" $(date +%F.%T) ${BASH_SOURCE[1]##*/} ${BASH_LINENO[0]} "${@}"
  printf "$_LOG_MSG_FMT" $(date +%F.%T) ${BASH_LINENO[0]} "${@}"
}

# #############################################################################

_FOLDER_LIST=(
    "bin"
    "sbin"
    "lib"
    "lib64"
    "include"
    "man"
    "share"
    "cmake"
    "etc"
    "examples"
    "python"
)

_SKIP_LIST=(
    "build-1"
    "doc"
    "docs"
    "man"
    "ssl"
    "var"
    "libexec"
    "Library"
)

# FILE="example.tar.gz"
# echo "${FILE%%.*}"
# example
# echo "${FILE%.*}"
# example.tar
# echo "${FILE#*.}"
# tar.gz
# echo "${FILE##*.}"
# gz

proc_config() {
    _APP_INSTALL_PREFIX_=${APP_PREFIX}/${_APP_FRAMEWORK_PATH_}
    _APP_OPT_PATH_="${APP_PREFIX}/opt"
}

proc_symlink() {
    for vFILES in $(/bin/ls -c1 ${_APP_OPT_PATH_})
    do
        local vFILE="${_APP_OPT_PATH_}/${vFILES}"
        if [ -n "${vFILE}" ] && [ -L "${vFILE}" ] ; then
            if [ ! -e "${vFILE}" ] ; then
                log_msg "[ERROR] ${vFILE} exists and is not a symlink"
                log_msg "[CMD] DELETE ${vFILE}"
                rm -rf "${vFILE}"
            fi
        fi
    done
}

func_pkg_name() {
   #echo ${1} | sed -e 's|@|/|g'
   echo ${1}
}

proc_opt() {
    local xPKG_NAME="${1}"
    local _xPKG_NAME=$(func_pkg_name ${xPKG_NAME})

    local vPKG_NAME=${_xPKG_NAME%/*}

    log_msg "[INFO] ${xPKG_NAME}"

    if [ -n "${_xPKG_NAME}" ] && [ -n "${vPKG_NAME}" ] && [ -e "${_APP_OPT_PATH_}" ]; then
        cd ${_APP_OPT_PATH_} && (
            if [ -n "${vPKG_NAME}" ] && [ -e "./${vPKG_NAME}" ]; then
                log_msg "[CMD] rm -rf ./${vPKG_NAME}"
                rm -rf "./${vPKG_NAME}"
            else
                log_msg "[INFO] ./${vPKG_NAME}: No such file or directory; Create a new symbolic link"
            fi

            if [ -e "../${_APP_FRAMEWORK_PATH_}/${_xPKG_NAME}" ] && [ ! -e "./${vPKG_NAME}" ]; then
                log_msg "[CMD] ln -s ../${_APP_FRAMEWORK_PATH_}/${_xPKG_NAME} ${vPKG_NAME}"
                ln -s ../${_APP_FRAMEWORK_PATH_}/${_xPKG_NAME} ${vPKG_NAME}
            else
                log_msg "[WARN] ../${_APP_FRAMEWORK_PATH_}/${_xPKG_NAME}: No such file or directory: SKIP"
            fi
        )
    fi
}

proc_link() {
    local xPKG_OPT="${1}"
    local xPKG_CMD="${2}"
    local xPKG_NAME="${3}"
    local _xPKG_NAME=$(func_pkg_name ${xPKG_NAME})
    local _PREFIX_="${_APP_INSTALL_PREFIX_}/${_xPKG_NAME}"

    log_msg "[INFO] ${xPKG_NAME} "

    if [ -n "${_xPKG_NAME}" ] && [ -e "${_APP_INSTALL_PREFIX_}" ] && 
       [ -n "${APP_PREFIX}" ] && [ -e "${APP_PREFIX}" ] && 
       [ -n "${_PREFIX_}" ] && [ -e "${_PREFIX_}" ]; then

        local _xFOLDER_LIST=()
        local _xFILE_LIST=()

        #log_msg "[INFO] PATH: $(pwd)"

        # directory
        for vPATH in `(cd "${_PREFIX_}" && (find . -type d | sed  -e 's|^\.$||g' -e 's|^\.\/||g'))`
        do
            #log_msg "[INFO] - ${vPATH}"

            local vLAST_PATH=${vPATH##*/}
            local vFIRST_PATH=${vPATH%%/*}
            local vFLAG=0

            #log_msg "[DEBUG] $vPATH [$vFIRST_PATH] [$vLAST_PATH]"

            for vTMP in ${_SKIP_LIST[@]}
            do
                if [ "${vTMP}" == "${vLAST_PATH}" ] || [ "${vTMP}" == "${vFIRST_PATH}" ]; then
                    ((vFLAG++))
                    break
                fi
            done
            if [ "${vFLAG}" -eq 0 ]; then
                _xFOLDER_LIST+=( "${vPATH}" )
            fi
        done

        # files
        for vFILE in `cd "${_PREFIX_}" && ((find . -type f; find . -type l) | sed  -e 's|^\.$||g' -e 's|^\.\/||g')`
        do
            local vPATH=${vFILE//\.\//}
            local vLAST_PATH=${vPATH%%/*}
            local vFLAG=0
            
            for vTMP in ${_SKIP_LIST[@]}
            do
                if [ "${vTMP}" == "${vLAST_PATH}" ]; then
                    ((vFLAG++))
                    break
                fi
            done
            if [ "${vFLAG}" -eq 0 ]; then
                _xFILE_LIST+=( "${vFILE}" )
            fi
        done

        cd "${APP_PREFIX}" && (
        if ([ "${xPKG_CMD}" = "install" ] || [ "${xPKG_CMD}" = "pkg" ]) && [ ! -e "${vFILE}" ]; then
            local vIDX=0
            while [ ${vIDX} -lt ${#_xFOLDER_LIST[@]} ]; do
                local vTMP_PATH=${_xFOLDER_LIST[${vIDX}]}
                local vDST_PATH="${APP_PREFIX}/${vTMP_PATH}"

                #log_msg "[INFO] ${vDST_PATH}"

                if [ -n "${vTMP_PATH}" ] && [ ! -e "${vTMP_PATH}" ]; then
                    #log_msg "[CMD] mkdir -p ${vTMP_PATH}"
                    mkdir -p "${vTMP_PATH}"
                    # else
                    #   log_msg "[INFO] ${APP_PREFIX} / ${vTMP_PATH}:File exists"
                fi
                ((vIDX++))
            done
        fi

        vIDX=0
        while [ ${vIDX} -lt ${#_xFILE_LIST[@]} ]; do
            local vTMP_FILE=${_xFILE_LIST[${vIDX}]}
            local vPATH=${vTMP_FILE%/*}
            local vFILE=${vTMP_FILE##*/}

            #local vSRC_FILE="${APP_PREFIX}/${_APP_FRAMEWORK_PATH_}/${_xPKG_NAME}/${vTMP_FILE}"
            local vSRC_FILE="${_APP_INSTALL_PREFIX_}/${_xPKG_NAME}/${vTMP_FILE}"

            if [ -n "${vPATH}" ] && [ -e "${vPATH}" ] && [ -e "${APP_PREFIX}/${vPATH}" ]; then
            (
                cd "${APP_PREFIX}/${vPATH}" &&
                if [ ${xPKG_OPT} -eq 0 ]; then
                    if [  -e "${vFILE}" ]; then
                        #log_msg "[CMD] $(pwd) rm -rf ${vFILE}"
                        rm -rf ${vFILE}
                    fi
                    if ([ "${xPKG_CMD}" = "install" ] || [ "${xPKG_CMD}" = "pkg" ]) && [ ! -e "${vFILE}" ]; then
                        # log_msg "[CMD] $(pwd) ln -s ${vSRC_FILE} ${vFILE}"
                        # log_msg "[TEST] ln -s ${vSRC_FILE} ${vFILE}"
                            ln -s ${vSRC_FILE} ${vFILE}
                        # else
                        #   log_msg "[INFO] ln - s ${vSRC_FILE} $vFILE - SKIP"
                    fi
                    if [ ${#_xFILE_LIST[@]} -gt 50 ]; then
                        if [ ${vIDX} -gt 1 ] && [ $((${vIDX} % 100)) == 0 ]; then
                            local vRATE=$(( (${vIDX} * 100 ) / ${#_xFILE_LIST[@]} ))
                            printf "%5d/%d %4.1f%%\r" ${vIDX} ${#_xFILE_LIST[@]} ${vRATE}
                        fi
                    fi
                else
                    log_msg "[TEST] $(pwd) - ln -s ${vSRC_FILE} ${vFILE}"
                fi
            )
            fi
            ((vIDX++))
        done
        printf "\r"

        if [ "${xPKG_CMD}" = "uninstall" ]; then
            # delete empty directory
            local vFILDER_IDX=$((${#_xFOLDER_LIST[@]} - 1))
            local vIDX=0
            while [ ${vIDX} -lt ${#_xFOLDER_LIST[@]} ]; do
                local vTMP_PATH=${_xFOLDER_LIST[${vFILDER_IDX}]}
                local vDST_PATH="${APP_PREFIX}/${vTMP_PATH}"

                #find ${vTMP_PATH} -depth -type d -empty -exec rmdir {} ;
                #find ${vTMP_PATH} -depth -type d -empty -print

                #log_msg "[INFO] Directory: ${vTMP_PATH}"
                if [ -n "${vTMP_PATH}" ] && [ -e "${vTMP_PATH}" ]; then
                    # check empty directory
                    if [ -z "$(ls -A ${vTMP_PATH})" ]; then
                        log_msg "[INFO] rmdir ${vDST_PATH}"
                        #log_msg "[CMD] rmdir ${vTMP_PATH} [${vDST_PATH}]"
                        rmdir "${vTMP_PATH}"
                        #else
                        #log_msg "[INFO] Take action ${vTMP_PATH} is not Empty"
                    fi
                fi
                ((vFILDER_IDX--))
                ((vIDX++))
            done
        fi
        )
    fi
    #find . -depth -type d -empty -exec rmdir {} ;
}

proc_bin() {
    local xPKG_CMD="${1}"
    local xPKG_NAME="${2}"
    local _xPKG_NAME=$(func_pkg_name ${xPKG_NAME})
    local _PREFIX_="${_APP_INSTALL_PREFIX_}/${_xPKG_NAME}"

    log_msg "[INFO] ${xPKG_NAME}"

    if [ -n "${_xPKG_NAME}" ] && [ -e "${_APP_INSTALL_PREFIX_}" ] && 
       [ -n "${APP_PREFIX}" ] && [ -e "${APP_PREFIX}" ] && 
       [ -n "${_PREFIX_}" ] && [ -e "${_PREFIX_}" ]; then

        _xFOLDER_LIST=("bin" "sbin")
        _xFILE_LIST=()

        #log_msg "[INFO] PATH: $(pwd)"

        for vFILE in `cd "${_PREFIX_}" && ((find . -type f; find . -type l) | sed  -e 's|^\.$||g' -e 's|^\.\/||g')`
        do
            local vPATH=${vFILE//\.\//}
            local vLAST_PATH=${vPATH%%/*}
            local vFLAG=0
            
            for vTMP in ${_xFOLDER_LIST[@]}
            do
                if [ "${vTMP}" == "${vLAST_PATH}" ]; then
                    ((vFLAG++))
                    break
                fi
            done
            if [ "${vFLAG}" -eq 1 ]; then
                _xFILE_LIST+=( "${vFILE}" )
            fi
        done

        #log_msg "[CMD] cd ${APP_PREFIX}"
        cd "${APP_PREFIX}" && (
        #log_msg "[INFO] >>> $(pwd)"

        vIDX=0
        while [ ${vIDX} -lt ${#_xFOLDER_LIST[@]} ]; do
            local vTMP_PATH=${_xFOLDER_LIST[${vIDX}]}

            if [ -n "${vTMP_PATH}" ] && [ ! -e "${vTMP_PATH}" ]; then
                #log_msg "[CMD] mkdir -p ${vTMP_PATH}"
                mkdir -p "${vTMP_PATH}"
                # else
                #   log_msg "[INFO] ${APP_PREFIX} / ${vTMP_PATH}:File exists"
            fi
            ((vIDX++))
        done

        vIDX=0
        while [ ${vIDX} -lt ${#_xFILE_LIST[@]} ]; do
            local vTMP_FILE=${_xFILE_LIST[${vIDX}]}
            local vPATH=${vTMP_FILE%/*}
            local vFILE=${vTMP_FILE##*/}

            #local vSRC_FILE="${APP_PREFIX}/${_APP_FRAMEWORK_PATH_}/${_xPKG_NAME}/${vTMP_FILE}"
            local vSRC_FILE="${_APP_INSTALL_PREFIX_}/${_xPKG_NAME}/${vTMP_FILE}"

            if [ -n "${vPATH}" ] && [ -e "${vPATH}" ]; then
            (
                cd "${APP_PREFIX}/${vPATH}"
                if [  -e "${vFILE}" ]; then
                    # log_msg "[CMD] $(pwd) rm -rf ${vFILE}"
                    rm -rf ${vFILE}
                fi
                if [ "${xPKG_CMD}" = "bin" ] && [ ! -e "${vFILE}" ]; then
                    # log_msg "[CMD] $(pwd) ln -s ${vSRC_FILE} ${vFILE}"
                    # log_msg "[CMD] ln -s ${vSRC_FILE} ${vFILE}"
                    ln -s ${vSRC_FILE} ${vFILE}
                    # else
                    #   log_msg "[INFO] ln - s ${vSRC_FILE} $vFILE - SKIP"
                fi
            )
            fi
            ((vIDX++))
        done

        #log_msg "[INFO] <<< $(pwd)"
        )
    fi
    #find . -depth -type d -empty -exec rmdir {} ;
}

proc_help() {
    log_msg "[HELP] ${0} -t reset|pkg|bin"
    log_msg "[HELP] ${0} -t install <package-names...>"
}


# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
opt_debug=0
xPKG_LIST=()

if [ ${#@} -ne 0 ]; then
    while getopts "h?t" opt; do
    case "${opt}" in
        h|\?)
            proc_help
            exit 0
            ;;
        t)  opt_debug=1
            ;;
        esac
    done

    shift $((OPTIND-1))

    [ "$1" = "--" ] && shift

    vIDX=0
    for x in ${@}
    do
        if [ $vIDX -eq 0 ]; then
            xPKG_CMD=${x}
        else
            xPKG_LIST+=( ${x} )
        fi
        ((vIDX++))
    done

    if [ -n "${xPKG_CMD}" ]; then
        proc_config
        proc_symlink

        if [ "${xPKG_CMD}" = "reset" ]; then
            if [ -e "${APP_PREFIX}" ]; then
            (
                cd ${APP_PREFIX}
                for vPATH in ${_FOLDER_LIST[@]}
                do
                    if [ -e "${vPATH}" ]; then
                        log_msg "[CMD] $(pwd): rm -rf ./${vPATH}/*"
                        rm -rf ./${vPATH}/*
                        log_msg "[CMD] $(pwd): rmdir ./${vPATH}"
                        rmdir ./${vPATH}
                    fi
                done
            )
            fi
#       elif [ "${xPKG_CMD}" = "clean_link" ]; then
#           log_msg "[CMD] >>>> ${0} ${xPKG_CMD}"
#
#           . ./${_PKG_LIST_FILE}
#
#           vIDX=0
#           while [ ${vIDX} -lt ${#_PKG_BIN_LIST_[@]} ]; do
#               proc_bin "${xPKG_CMD}" "${_PKG_BIN_LIST_[${vIDX}]}"
#               ((vIDX++))
#           done
#
#           vIDX=0
#           while [ ${vIDX} -lt ${#_PKG_LIST_[@]} ]; do
#               proc_link "${opt_debug}" "${xPKG_CMD}" "${_PKG_LIST_[${vIDX}]}"
#               ((vIDX++))
#           done
#           log_msg "[CMD] <<<< ${0} ${xPKG_CMD}"
        elif [ "${xPKG_CMD}" = "opt" ]; then
            log_msg "[CMD] >>>> ${0} ${xPKG_CMD}"

            . ./${_PKG_LIST_FILE}

            vIDX=0
            while [ ${vIDX} -lt ${#_PKG_OPT_LIST_[@]} ]; do
                proc_opt "${_PKG_OPT_LIST_[${vIDX}]}"
                ((vIDX++))
            done

            log_msg "[CMD] <<<< ${0} ${xPKG_CMD}"
        elif [ "${xPKG_CMD}" = "pkg" ]; then
            log_msg "[CMD] >>>> ${0} ${xPKG_CMD}"

            . ./${_PKG_LIST_FILE}

            vIDX=0
            while [ ${vIDX} -lt ${#_PKG_LIST_[@]} ]; do
                proc_link "${opt_debug}" "install" "${_PKG_LIST_[${vIDX}]}"
                ((vIDX++))
            done
            log_msg "[CMD] <<<< ${0} ${xPKG_CMD}"
        elif [ "${xPKG_CMD}" = "install" ] || [ "${xPKG_CMD}" = "uninstall" ]; then
            log_msg "[CMD] >>>> ${0} ${xPKG_CMD}"
            for xPKG_NAME in ${xPKG_LIST[@]}
            do
                proc_link "${opt_debug}" "${xPKG_CMD}" "${xPKG_NAME}"
            done
            log_msg "[CMD] <<<< ${0} ${xPKG_CMD}"
        elif [ "${xPKG_CMD}" = "bin" ]; then
            log_msg "[CMD] >>>> ${0} ${xPKG_CMD}"

            . ./${_PKG_LIST_FILE}

            vIDX=0
            while [ ${vIDX} -lt ${#_PKG_BIN_LIST_[@]} ]; do
                proc_bin "${xPKG_CMD}" "${_PKG_BIN_LIST_[${vIDX}]}"
                ((vIDX++))
            done
            log_msg "[CMD] <<<< ${0} ${xPKG_CMD}"
        else
            log_msg "[ERROR] ${0} <command> [package-name]"
        fi
    fi
else
    proc_help
fi
