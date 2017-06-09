pkg_info() {
	_xDESC="High-performance, asynchronous messaging library"

	_xURL="https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz"
	_xFILE="zeromq-4.2.2.tar.gz"
	_xFILE_PATH=zeromq-4.2.2

	_xNAME=zeromq/4.2.2
}

pkg_build() {

	PKG_CONFIG_PATH=${PKG_INSTALL_PATH}/libsodium/lib/pkgconfig:${PKG_CONFIG_PATH}

    libsodium_CFLAGS=$(pkg-config --cflags libsodium)
    libsodium_LIBS=$(pkg-config --libs libsodium)

    CFLAGS="${libsodium_CFLAGS}"
    LDFLAGS="${libsodium_LIBS}"

	./configure --prefix=${PREFIX} \
		--enable-static --enable-shared \
		--with-libsodium \
	&& make -j 6 && make install
}
