pkg_info() {
	_xDESC="Embeddable, persistent key-value store for fast storage"

	_xFILE="v5.1.4.tar.gz"
	_xFILE_PATH=rocksdb-5.1.4

	_xNAME=rocksdb/5.1.4
}

pkg_build() {
	#PKG_CONFIG_PATH=${PKG_INSTALL_PATH}/jemalloc/lib/pkgconfig:${PKG_CONFIG_PATH}
	#PKG_CONFIG_PATH=${PKG_INSTALL_PATH}/snappy/lib/pkgconfig:${PKG_CONFIG_PATH}

	#jemalloc_CFLAGS=$(pkg-config --cflags jemalloc)
	#jemalloc_LIBS=$(pkg-config --libs jemalloc)

	#snappy_CFLAGS=$(pkg-config --cflags snappy)
	#snappy_LIBS=$(pkg-config --libs snappy)

	#CFLAGS="-I/usr/local/include ${jemalloc_CFLAGS} ${snappy_CFLAGS}"
	#LDFLAGS="-L/usr/local/lib ${jemalloc_LIBS} ${snappy_LIBS}"

	make INSTALL_PATH=${PREFIX} PORTABLE=1 DEBUG_LEVEL=0 -j 6 shared_lib
	make INSTALL_PATH=${PREFIX} PORTABLE=1 DEBUG_LEVEL=0 -j 6 static_lib
	make INSTALL_PATH=${PREFIX} PORTABLE=1 DEBUG_LEVEL=0 install
}
