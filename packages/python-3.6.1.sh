pkg_info() {
	_xDESC="Interpreted, interactive, object-oriented programming language"

	_xFILE="Python-3.6.1.tgz"
	_xFILE_PATH=Python-3.6.1

	_xNAME=python/3.6.1
}

pkg_build() {

	if [ -e "/usr/local/opt/openssl/lib/pkgconfig" ]; then
		PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig:${PKG_CONFIG_PATH}
	elif [ -e "${PKG_INSTALL_PATH}/openssl/lib/pkgconfig" ]; then
		PKG_CONFIG_PATH=${PKG_INSTALL_PATH}/openssl/lib/pkgconfig:${PKG_CONFIG_PATH}
	fi
	if [ -e "/usr/local/opt/libffi/lib/pkgconfig" ]; then
		PKG_CONFIG_PATH=/usr/local/opt/libffi/lib/pkgconfig:${PKG_CONFIG_PATH}
	elif [ -e "${PKG_INSTALL_PATH}/libffi/lib/pkgconfig" ]; then
		PKG_CONFIG_PATH=${PKG_INSTALL_PATH}/libffi/lib/pkgconfig:${PKG_CONFIG_PATH}
	fi

    openssl_CFLAGS=$(pkg-config --cflags openssl)
    openssl_LIBS=$(pkg-config --libs openssl)

    libffi_CFLAGS=$(pkg-config --cflags libffi)
    libffi_LIBS=$(pkg-config --libs libffi)

	export CFLAGS="-I/usr/local/include ${openssl_CFLAGS} ${libffi_CFLAGS}"
	export LDFLAGS="-L/usr/local/lib ${openssl_LIBS} ${libffi_LIBS}"

	if [ ${vOS} = "Darwin" ]; then
		MACOSX_DEPLOYMENT_TARGET=10.12
	fi
	./configure --prefix=${PREFIX} \
		--enable-ipv6 \
		--enable-shared \
		--with-threads \
		--without-gcc \
		--without-ensurepip \
		--enable-optimizations \
	&& make -j 6 && make install \
	&& (
		cd ${PREFIX}/bin && if [ ! -e "python" ]; then
			ln -s python3.6 python
		fi
	)
}
