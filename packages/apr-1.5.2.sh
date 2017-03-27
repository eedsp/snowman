pkg_info() {
	_xDESC="Apache Runtime Library"

	_xFILE="apr-1.5.2.tar.gz"
	_xFILE_PATH="apr-1.5.2"

	_xNAME=apr/1.5.2
}

pkg_build() {

	log_msg "[INFO] ${vOS}"

	make clean && make distclean
	./configure --prefix=${PREFIX} \
		--enable-threads --enable-posix-shm && make -j 6 && make install
}

