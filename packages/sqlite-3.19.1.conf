pkg_info() {
	_xDESC="in-process library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine"

	_xFILE="sqlite-src-3190100.zip"
	_xFILE_PATH=sqlite-src-3190100

	_xNAME=sqlite/3.19.1
}

pkg_build() {

	./configure --prefix=${PREFIX} \
		--enable-threadsafe --disable-tcl \
	&& make -j 6 && make install
}
