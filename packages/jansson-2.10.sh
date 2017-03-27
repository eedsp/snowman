pkg_info() {
	_xDESC="C library for encoding, decoding and manipulating JSON data"

	_xFILE="jansson-2.10.tar.gz"
	_xFILE_PATH=jansson-2.10

	_xNAME=jansson/2.10
}

pkg_build() {
	./configure --prefix=${PREFIX} && make -j 6 && make install
}
