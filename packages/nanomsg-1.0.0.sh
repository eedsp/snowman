pkg_info() {
	_xDESC="Socket library in C"

	_xFILE="nanomsg-1.0.0.tar.gz"
	_xFILE_PATH=nanomsg-1.0.0

	_xNAME=nanomsg/1.0.0
}

pkg_build() {
	if [ -e "./_build" ]; then
		log_msg "[CMD] $(pwd) - rm -rf ./_build"
		rm -rf ./_build
	fi
	(
		mkdir -p ./_build && cd ./_build && cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX} \
			-DCMAKE_BUILD_TYPE=Release \
		&& make -j 6 && make install
	)
}
