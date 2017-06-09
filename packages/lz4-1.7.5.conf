pkg_info() {
	_xDESC="lz4 Extremely Fast Compression algorithm"

	_xURL="https://github.com/lz4/lz4/archive/v1.7.5.tar.gz"
	_xFILE="lz4-1.7.5.tar.gz"
	_xFILE_PATH=lz4-1.7.5

	_xNAME=lz4/1.7.5
}

pkg_build() {
	make PREFIX=${PREFIX} -j 6 && make PREFIX=${PREFIX} install
}
