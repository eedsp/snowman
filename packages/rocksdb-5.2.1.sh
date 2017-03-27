pkg_info() {
	_xDESC="Embeddable, persistent key-value store for fast storage"

	_xURL="https://github.com/facebook/rocksdb/archive/rocksdb-5.2.1.tar.gz"
	_xFILE="rocksdb-5.2.1.tar.gz"
	_xFILE_PATH=rocksdb-rocksdb-5.2.1

	_xNAME=rocksdb/5.2.1
}

pkg_build() {
	for tPKG_NAME in jemalloc snappy gflags
	do
		for PKGCONFIG_prefix in "/usr/local/opt" "${PKG_INSTALL_PATH}"
		do
			tmpPATH="${PKGCONFIG_prefix}/${tPKG_NAME}/lib/pkgconfig"
			if [ -e "${PKGCONFIG_prefix}" ]; then
				PKG_CONFIG_PATH=${tmpPATH}:${PKG_CONFIG_PATH}
				break
			fi
		done
	done

	jemalloc_CFLAGS=$(pkg-config --cflags jemalloc)
	jemalloc_LIBS=$(pkg-config --libs jemalloc)

	snappy_CFLAGS=$(pkg-config --cflags snappy)
	snappy_LIBS=$(pkg-config --libs snappy)

    gflags_CFLAGS=$(pkg-config --cflags gflags)
    gflags_LIBS=$(pkg-config --libs gflags)

	CFLAGS="-I/usr/local/include ${jemalloc_CFLAGS} ${snappy_CFLAGS} ${gflags_CFLAGS}"
	LDFLAGS="-L/usr/local/lib ${jemalloc_LIBS} ${snappy_LIBS} ${gflags_LIBS}"

	make INSTALL_PATH=${PREFIX} PORTABLE=1 DEBUG_LEVEL=0 -j 6 shared_lib
	make INSTALL_PATH=${PREFIX} PORTABLE=1 DEBUG_LEVEL=0 -j 6 static_lib
	make INSTALL_PATH=${PREFIX} PORTABLE=1 DEBUG_LEVEL=0 install
}
