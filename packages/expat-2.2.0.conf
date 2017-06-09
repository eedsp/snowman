pkg_info() {
	_xDESC="XML 1.0 parser"

	_xFILE="expat-2.2.0.tar.bz2"
	_xFILE_PATH="expat-2.2.0"

	_xNAME=expat/2.2.0
}

pkg_build() {
	./configure --prefix=${PREFIX} && make -j 6 && make install
}
