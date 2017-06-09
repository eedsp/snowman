pkg_info() {
	_xDESC="Multi-platform support library with a focus on asynchronous I/O"

	_xFILE="libuv-1.11.0.tar.gz"
	_xFILE_PATH=libuv-1.11.0

	_xNAME=libuv/1.11.0
}

pkg_build() {
	autogen.sh && \
	./configure --prefix=${PREFIX} && make -j 6 && make install
}
