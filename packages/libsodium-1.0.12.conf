pkg_info() {
	_xDESC="A modern and easy-to-use crypto library"

	_xFILE="libsodium-1.0.12.tar.gz"
	_xFILE_PATH=libsodium-1.0.12

	_xNAME=libsodium/1.0.12
}

pkg_build() {
	./configure --prefix=${PREFIX} --enable-shared --enable-static && make -j 6 && make install
}
