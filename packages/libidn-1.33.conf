pkg_info() {
	_xDESC="International domain name library"

	_xFILE="libidn-1.33.tar.gz"
	_xFILE_PATH=libidn-1.33

	_xNAME=libidn/1.33
}

pkg_build() {
	./configure --prefix=${PREFIX} && make -j 6 && make install
}
