pkg_info() {
	_xDESC="lz4 Extremely Fast Compression algorithm"

	_xURL="https://github.com/lz4/lz4/archive/v1.7.5.tar.gz"
	_xFILE="snappy-1.1.4.tar.gz"
	_xFILE_PATH=snappy-1.1.4

	_xNAME=snappy/1.1.4
}

pkg_build() {
	PKG_CONFIG_PATH=${PKG_INSTALL_PATH}/gflags/lib/pkgconfig:${PKG_CONFIG_PATH}

    gflags_CFLAGS=$(pkg-config --cflags gflags)
    gflags_LIBS=$(pkg-config --libs gflags)

	./configure --prefix=${PREFIX} --disable-dependency-tracking && make -j 6 && make install
}
