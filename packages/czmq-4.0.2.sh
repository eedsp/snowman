pkg_info() {
	_xDESC="High-level C binding for ZeroMQ"

	_xURL="https://github.com/zeromq/czmq/releases/download/v4.0.2/czmq-4.0.2.tar.gz"
	_xFILE="czmq-4.0.2.tar.gz"
	_xFILE_PATH=czmq-4.0.2

	_xNAME=czmq/4.0.2
}

pkg_build() {
	PKG_CONFIG_PATH=${PKG_INSTALL_PATH}/zeromq/lib/pkgconfig:${PKG_CONFIG_PATH}

	libzmq_CFLAGS=$(pkg-config --cflags libzmq)
	libzmq_LIBS=$(pkg-config --libs libzmq)

	./configure --prefix=${PREFIX} && make -j 6 && make install
}
