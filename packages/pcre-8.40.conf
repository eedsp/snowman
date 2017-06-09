pkg_info() {
	_xDESC="PCRE"

	_xFILE="pcre-8.40.tar.gz"
	_xFILE_PATH=pcre-8.40

	_xNAME=pcre/8.40
}

pkg_build() {
	./configure --prefix=${PREFIX} \
		--enable-utf --enable-unicode-properties \
		--enable-cpp --enable-pcre16 --enable-pcre32 \
		--disable-stack-for-recursion --enable-newline-is-any \
	&& make -j 6 && make install
}
