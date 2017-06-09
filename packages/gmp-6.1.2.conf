pkg_info() {
	_xDESC="GNU multiple precision arithmetic library"

	_xFILE="gmp-6.1.2.tar.bz2"
	_xFILE_PATH=gmp-6.1.2

	_xNAME=gmp/6.1.2
}

pkg_build() {
	./configure --prefix=${PREFIX} && make -j 6 && make check && make install
}
