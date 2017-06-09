pkg_info() {
	_xDESC="jemalloc memory allocator"

	_xFILE="jemalloc-4.5.0.tar.bz2"
	_xFILE_PATH=jemalloc-4.5.0

	_xNAME=jemalloc/4.5.0
}

pkg_build() {
	./configure --prefix=${PREFIX} && make -j 6 && make install
}
