pkg_info() {
	_xDESC="A portable foreign-function interface library. "

    _xURL="https://github.com/libffi/libffi/archive/v3.2.1.tar.gz"
	_xFILE="libffi-3.2.1.tar.gz"
	_xFILE_PATH=libffi-3.2.1

	_xNAME=libffi/3.2.1
}

pkg_build() {

	log_msg "[INFO] ${_OS_NAME}"

	# for make
	(
    if [ -e "./autogen.sh" ]; then
        ./autogen.sh
    fi
	./configure --prefix=${PREFIX} --disable-debug && make -j 6 && make install
	)
}
