pkg_info() {
	_xDESC="Aid design and implementation of concurrent systems"

	_xFILE="ck-0.6.0.tar.gz"
	_xFILE_PATH="ck-0.6.0"

	_xNAME=ck/0.6.0
}

pkg_build() {
	./configure --prefix=${PREFIX} \
	&& make -j 6 && make install
}
