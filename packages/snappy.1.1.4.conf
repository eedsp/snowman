pkg_info() {
	_xDESC="Compression/decompression library aiming for high speed"

	_xURL="https://github.com/google/snappy/releases/download/1.1.4/snappy-1.1.4.tar.gz"
	_xFILE="snappy-1.1.4.tar.gz"
	_xFILE_PATH=snappy-1.1.4

	_xNAME=snappy/1.1.4
}

pkg_build() {
	if [ -e "/usr/local/opt/gflags/lib/pkgconfig" ]; then
		PKG_CONFIG_PATH=/usr/local/opt/gflags/lib/pkgconfig:${PKG_CONFIG_PATH}
	elif [ -e "${PKG_INSTALL_PATH}/gflags/lib/pkgconfig" ]; then
		PKG_CONFIG_PATH=${PKG_INSTALL_PATH}/gflags/lib/pkgconfig:${PKG_CONFIG_PATH}
	fi

    gflags_CFLAGS=$(pkg-config --cflags gflags)
    gflags_LIBS=$(pkg-config --libs gflags)

	./configure --prefix=${PREFIX} --disable-dependency-tracking && make -j 6 && make install
}
