pkg_info() {
	_xDESC="Asynchronous event library"

	_xFILE="libev-4.24.tar.gz"
	_xFILE_PATH=libev-4.24

	_xNAME=libev/4.24
}

pkg_build() {
	./configure --prefix=${PREFIX} && make -j 6 && make install
}
