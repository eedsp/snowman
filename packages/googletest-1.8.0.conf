pkg_info() {
	_xDESC="Description"

	_xFILE="googletest-release-1.8.0.tar.gz"
	_xFILE_PATH=googletest-release-1.8.0

	_xNAME=googletest/1.8.0
}

pkg_build() {
	if [ -e "./_build" ]; then
		log_msg "[CMD] $(pwd) - rm -rf ./_build"
		rm -rf ./_build
	fi
	(
		mkdir -p _build && cd _build && cmake ..  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
			-DCMAKE_BUILD_TYPE=Release \
		&& make -j 6 && make install
	)
}
