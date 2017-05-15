pkg_info() {
	_xDESC="gflag: Library for processing command-line flags"

	_xFILE="gflags-2.2.0.tar.gz"
	_xFILE_PATH=gflags-2.2.0

	_xNAME=gflags/2.2.0
}

pkg_build() {

	log_msg "[INFO] ${_OS_NAME}"

	# for cmake
	if [ -e "./_build" ]; then
		log_msg "[CMD] $(pwd) - rm -rf ./_build"
		rm -rf ./_build
	fi
	(
		mkdir -p _build && cd _build && cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX} \
			-DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=ON \
			-DCMAKE_BUILD_TYPE=Release \
		&& make -j 6 && make install
	)
}
