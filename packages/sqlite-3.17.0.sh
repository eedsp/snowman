pkg_info() {
	_xDESC="in-process library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine"

	_xFILE="sqlite-src-3170000.zip"
	_xFILE_PATH=sqlite-src-3170000

	_xNAME=sqlite/3.17.0
}

pkg_build() {
	./configure --prefix=${PREFIX} \
		--enable-threadsafe --disable-tcl \
	&& make -j 6 && make install
}
