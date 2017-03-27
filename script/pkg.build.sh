#!/bin/bash

vOS=`uname -s`

if [ ${vOS} = "Darwin" ]; then
	#PKG_LIBTOOL=on
	if [ -z "${PKG_PATH}" ]; then
		PKG_PATH=/opt/local/pkg
	fi
	#_SYS_PATH_=.pkg
	_SYS_PATH_="$(uname -m).pkg"
elif [ ${vOS} = "Linux" ]; then
	if [ -z "${PKG_PATH}" ]; then
		PKG_PATH=/data/app/pkg
	fi
	#_SYS_PATH_=.pkg
	_SYS_PATH_="$(uname -m).pkg"
fi

_APP_FRAMEWORK_PATH_="Frameworks/app.Framework"

export PATH=/usr/bin:/bin:${PATH}

if [ -z "${PKG_CONFIG_PATH}" ]; then
	export PKG_CONFIG_PATH=/opt/local/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib/pkgconfig
fi

# #############################################################################

_BUILD_PKG_SCRIPT_PATH_=${PKGM}/packages
_BUILD_TEMP_PATH_=${PKGM}/var/tmp
_BUILD_OPT=0

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

proc_prepare_file() {
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

# .gz, .tgz	: tar xvfz
# .bz2		: tar xvfj
# .xz		: tar xvfJ
# zip		: unzip

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

proc_check_build_path() {
	if [ -z "${_BUILD_TEMP_PATH_}" ]; then
		log_msg "[INFO] ${_BUILD_TEMP_PATH_}: No such file or directory"
		exit
	fi
	if [ ! -e "${_BUILD_TEMP_PATH_}" ]; then
		log_msg "[INFO] ${_BUILD_TEMP_PATH_}: No such file or directory"
		log_msg "[CMD] mkdir -p ${_BUILD_TEMP_PATH_}"
		mkdir -p "${_BUILD_TEMP_PATH_}"
	else
		log_msg "[INFO] \${_BUILD_TEMP_PATH_} - ${_BUILD_TEMP_PATH_}: File exists"
	fi

	#_BUILD_PATH_=${_BUILD_TEMP_PATH_}/${_vDATE}
	_BUILD_PATH_=${_BUILD_TEMP_PATH_}

	if [ -z "${_BUILD_PATH_}" ]; then
		log_msg "[INFO] ${_BUILD_PATH_}: No such file or directory"
		exit
	fi

	if [ ! -e "${_BUILD_PATH_}" ]; then
		log_msg "[CMD] mkdir -p ${_BUILD_PATH_}"
		mkdir -p "${_BUILD_PATH_}"
	else
		log_msg "[INFO] \${_BUILD_PATH_} - ${_BUILD_PATH_}: File exists"
	fi
}

proc_check_install_path() {
	if [ -z "${APP_PATH}" ]; then
		log_info "${APP_PATH}: No such file or directory"
		exit
	fi
	if [ ! -e "${PKG_INSTALL_PREFIX}" ]; then
		log_info "${PKG_INSTALL_PREFIX}: No such file or directory"
		exit
	fi
	if [ ! -e "${PKG_INSTALL_PATH}" ]; then
		log_msg "[CMD] mkdir -p ${PKG_INSTALL_PATH}"
		mkdir -p "${PKG_INSTALL_PATH}"
	fi

	if [ ! -e "${PKG_INSTALL_PATH}" ]; then
		log_info "${PKG_INSTALL_PATH}: No such file or directory"
		exit
	fi
}

# #############################################################################

proc_link() {
	local _PKG_TOP_PATH=${_xNAME%%/*}


	if [ -n  "${_PKG_TOP_PATH}" ]; then
	(
		cd ${PKG_INSTALL_PATH}
		if [ -e "${_PKG_TOP_PATH}" ]; then
			log_msg "[CMD] rm -rf ${_PKG_TOP_PATH}"
			rm -rf "${_PKG_TOP_PATH}"
		fi
		if [ -e "../${_APP_FRAMEWORK_PATH_}/${_xNAME}" ]; then
			log_info "[INFO] ln -s ../${_APP_FRAMEWORK_PATH_}/${_xNAME} ${_PKG_TOP_PATH}"
			ln -s ../${_APP_FRAMEWORK_PATH_}/${_xNAME} ${_PKG_TOP_PATH}
		else
			log_info " ../${_APP_FRAMEWORK_PATH_}/${_xNAME}: No such file or directory"
			exit
		fi
	)
	fi
}

proc_build() {
	local _BUILD_OPT="${1}"
	local _PKG_FILE_="${2}"

	if [ ${_BUILD_OPT} -eq 1 ]; then
		if [ -e "${_PKG_FILE_}" ]; then
			. ${_PKG_FILE_}
		else
			log_msg "[ERROR] ${_PKG_FILE_}: No such file or directory"
			exit
		fi
	else
		if [ -e "${_BUILD_PKG_SCRIPT_PATH_}/${_PKG_FILE_}" ]; then
			. ${_BUILD_PKG_SCRIPT_PATH_}/${_PKG_FILE_}
		elif [ -e "${_BUILD_PKG_SCRIPT_PATH_}/${_PKG_FILE_}.sh" ]; then
			. ${_BUILD_PKG_SCRIPT_PATH_}/${_PKG_FILE_}.sh
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

	PREFIX="${PKG_INSTALL_PREFIX}/${_xNAME}"

	log_msg "[INFO] _BUILD_PATH_ : ${_BUILD_PATH_}"
	log_msg "[INFO] _xDESC       : ${_xDESC}"
	log_msg "[INFO] _xFILE_PATH  : ${_xFILE_PATH}"
	log_msg "[INFO] _xFILE       : ${_xFILE}"
	log_msg "[INFO] APP_PATH     : ${APP_PATH}"
	log_msg "[INFO] PREFIX       : ${PREFIX}"

	log_msg "[INFO] \$_BUILD_OPT : $_BUILD_OPT"
	if [ ${_BUILD_OPT} -eq 0 ]; then

		log_msg "[INFO] find ${PKGM_SRC_PATH} -name ${_xFILE} -print"
		local _xSRC_FILE=$(find ${PKGM_SRC_PATH} -name ${_xFILE} -print)
		log_msg "[INFO] ${_xSRC_FILE}"
		if [ -n "${_xSRC_FILE}" ]; then
			proc_prepare_file "${_xSRC_FILE}" "${_BUILD_PATH_}"

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

	proc_link
}

# #############################################################################

proc_config() {
	PKG_INSTALL_PREFIX=${APP_PATH}/${_APP_FRAMEWORK_PATH_}
	PKG_INSTALL_PATH="${APP_PATH}/opt"

	proc_check_build_path
	proc_check_install_path
}

proc_help() {
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
			proc_help
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

	proc_config
	log_msg "[INFO] \${PKG_INSTALL_PREFIX}: ${PKG_INSTALL_PREFIX}"

	for xPKG_NAME in ${xPKG_LIST[@]}
	do
		if [ -n "${xPKG_NAME}" ] && [ -n "${_BUILD_PATH_}" ]; then
			log_msg "[INFO] Package: ${xPKG_NAME}"
			proc_build ${opt_build_only} ${xPKG_NAME}
		fi
	done
else
	proc_help
fi


