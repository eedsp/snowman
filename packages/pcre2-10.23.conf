pkg_info() {
	_xDESC="PCRE2"

	_xFILE="pcre2-10.23.tar.gz"
	_xFILE_PATH=pcre2-10.23

	_xNAME=pcre2/10.23
}

pkg_build() {
	./configure --prefix=${PREFIX} \
		--enable-pcre2-16 --enable-pcre2-32  --enable-jit \
		--enable-newline-is-anycrlf --enable-newline-is-any \
		--disable-stack-for-recursion  \
		--enable-shared \
		--enable-static \
		--with-link-size=4 \
		--enable-pcre2grep-libz --enable-pcre2grep-libbz2 --enable-pcre2test-libreadline \
	&& make -j 6 && make install
}
