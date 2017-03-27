pkg_info() {
	_xDESC="Ruby: powerful, clean, object-oriented scripting language"

	_xFILE="ruby-2.4.1.tar.gz"
	_xFILE_PATH=ruby-2.4.1

	_xNAME=ruby/2.4.1
}

pkg_build() {
	# --with-gmp=${PKG_INSTALL_PREFIX}/gmp/6.1.2 \
	# --with-gmp=${PKG_INSTALL_PATH}/gmp \

	export CFLAGS="-I/usr/local/include -I/usr/local/opt/openssl/include -I/usr/local/opt/libffi/include"
	export LDFLAGS="-L/usr/local/lib -L/usr/local/opt/openssl/lib -L/usr/local/opt/libffi/lib"

	./configure --prefix=${PREFIX} \
		--enable-shared --enable-pthread \
		--with-jemalloc \
		--with-gmp=/usr/local/opt/gmp \
	&& make -j 6 && make install
}
