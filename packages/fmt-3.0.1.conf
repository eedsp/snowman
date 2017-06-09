pkg_info() {
	_xDESC="fmt (formerly cppformat) is an open-source formatting library"

	_xFILE="fmt-3.0.1.tar.gz"
	_xFILE_PATH=fmt-3.0.1

	_xNAME=fmt/3.0.1
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
