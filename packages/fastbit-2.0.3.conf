pkg_info() {
	_xDESC="Open-source data processing library in NoSQL spirit"

	_xFILE="fastbit-2.0.3.tar.gz"
	_xFILE_PATH=fastbit-2.0.3

	_xNAME=fastbit/2.0.3
}

pkg_build() {
	./configure --prefix=${PREFIX} && make -j 6 && make install
}
