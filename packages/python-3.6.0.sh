pkg_info() {
	_xDESC="Interpreted, interactive, object-oriented programming language"

	_xFILE="Python-3.6.0.tgz"
	_xFILE_PATH=Python-3.6.0

	_xNAME=python/3.6.0
}

pkg_build() {
	export CFLAGS="-I/usr/local/include -I/usr/local/opt/openssl/include -I/usr/local/opt/libffi/include"
	export LDFLAGS="-L/usr/local/lib -L/usr/local/opt/openssl/lib -L/usr/local/opt/libffi/lib"
	if [ ${vOS} = "Darwin" ]; then
		MACOSX_DEPLOYMENT_TARGET=10.12
	fi
	./configure --prefix=${PREFIX} \
		--enable-ipv6 \
		--enable-shared \
		--with-dtrace \
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
