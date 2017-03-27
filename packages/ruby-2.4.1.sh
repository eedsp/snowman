pkg_info() {
	_xDESC="Ruby: powerful, clean, object-oriented scripting language"

	_xFILE="ruby-2.4.1.tar.gz"
	_xFILE_PATH=ruby-2.4.1

	_xNAME=ruby/2.4.1
}

pkg_build() {

	if [ -e "/usr/local/opt/jemalloc/lib/pkgconfig" ]; then
		PKG_CONFIG_PATH=/usr/local/opt/jemalloc/lib/pkgconfig:${PKG_CONFIG_PATH}
	elif [ -e "${PKG_INSTALL_PATH}/jemalloc/lib/pkgconfig" ]; then
		PKG_CONFIG_PATH=${PKG_INSTALL_PATH}/jemalloc/lib/pkgconfig:${PKG_CONFIG_PATH}
	fi
	if [ -e "/usr/local/opt/openssl/lib/pkgconfig" ]; then
		PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig:${PKG_CONFIG_PATH}
	elif [ -e "${PKG_INSTALL_PATH}/openssl/lib/pkgconfig" ]; then
		PKG_CONFIG_PATH=${PKG_INSTALL_PATH}/openssl/lib/pkgconfig:${PKG_CONFIG_PATH}
	fi
    jemalloc_CFLAGS=$(pkg-config --cflags jemalloc)
    jemalloc_LIBS=$(pkg-config --libs jemalloc)

    openssl_CFLAGS=$(pkg-config --cflags openssl)
    openssl_LIBS=$(pkg-config --libs openssl)

	if [ -e "/usr/local/opt/gmp" ]; then
		WITH_GMP="--with-gmp=/usr/local/opt/gmp"
	elif [ -e "${PKG_INSTALL_PATH}/gmp" ]; then
		WITH_GMP="--with-gmp=${PKG_INSTALL_PATH}/gmp"
	fi

	CFLAGS="-I/usr/local/include ${jemalloc_CFLAGS} ${openssl_CFLAGS}"
	LDFLAGS="-L/usr/local/lib ${jemalloc_LIBS} ${openssl_LIBS}"

	./configure --prefix=${PREFIX} \
		--enable-shared --enable-pthread \
		--with-jemalloc ${WITH_GMP}
	 make -j 6 && make install
}
