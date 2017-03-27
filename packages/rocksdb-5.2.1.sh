pkg_info() {
	_xDESC="Embeddable, persistent key-value store for fast storage"

	_xURL="https://github.com/facebook/rocksdb/archive/rocksdb-5.2.1.tar.gz"
	_xFILE="rocksdb-5.2.1.tar.gz"
	_xFILE_PATH=rocksdb-rocksdb-5.2.1

	_xNAME=rocksdb/5.2.1
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

	# for cmake
	#if [ -e "./_build" ]; then
	#	log_msg "[CMD] $(pwd) - rm -rf ./_build"
	#	rm -rf ./_build
	#fi
	#(
	#	mkdir -p ./_build && cd ./_build && cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX} \
	#		-DWITH_JEMALLOC=ON -DWITH_SNAPPY=ON \
	#		-DCMAKE_BUILD_TYPE=Release \
	#	&& make -j 6 && make install
	#)
}
