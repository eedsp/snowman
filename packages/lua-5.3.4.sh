pkg_info() {
	_xDESC="Lua is a powerful, efficient, lightweight, embeddable scripting language"

	_xFILE="lua-5.3.4.tar.gz"
	_xFILE_PATH=lua-5.3.4

	_xNAME=lua/5.3.4
}

pkg_build() {
	if [ ${_OS_NAME} = "Darwin" ]; then
		BUILD_OPTION=macosx
	elif [ ${_OS_NAME} = "Linux" ]; then
		BUILD_OPTION=linux
	fi
	make ${BUILD_OPTION} && make INSTALL_TOP=${PREFIX} && make INSTALL_TOP=${PREFIX} install
}
