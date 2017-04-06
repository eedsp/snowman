pkg_info() {
	_xDESC="Cross-platform make"

	_xFILE="cmake-3.7.2.tar.gz"
	_xFILE_PATH=cmake-3.7.2

	_xNAME=cmake/3.7.2
}

pkg_build() {

	log_msg "[INFO] ${vOS}"

	# for make
	if [ ${vOS} = "Darwin" ]; then
		./configure --prefix=${PREFIX} \
			--system-curl --system-expat --system-zlib --system-bzip2 
	elif [ ${vOS} = "Linux" ]; then
		./configure --prefix=${PREFIX} \
			--system-zlib --system-bzip2 
	fi
	make -j 6 && make install

}
