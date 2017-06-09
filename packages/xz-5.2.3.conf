pkg_info() {
	_xDESC="General-purpose data compression with high compression ratio"

	_xFILE="xz-5.2.3.tar.gz"
	_xFILE_PATH=xz-5.2.3

	_xNAME=xz/5.2.3
}

pkg_build() {
	./configure --prefix=${PREFIX} --enable-small && make -j 6 && make install
}
