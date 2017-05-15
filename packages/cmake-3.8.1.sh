pkg_info() {
	_xDESC="Cross-platform make"

	_xFILE="cmake-3.8.1.tar.gz"
	_xFILE_PATH=cmake-3.8.1

	_xNAME=cmake/3.8.1
}

pkg_build() {

	log_msg "[INFO] ${_OS_NAME}"

	# for make
	if [ ${_OS_NAME} = "Darwin" ]; then
		./configure --prefix=${PREFIX} \
			--system-curl --system-expat --system-zlib --system-bzip2 
	elif [ ${_OS_NAME} = "Linux" ]; then
		./configure --prefix=${PREFIX} \
			--system-zlib --system-bzip2 
	fi
	make -j 6 && make install

}
