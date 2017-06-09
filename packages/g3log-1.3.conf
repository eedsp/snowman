pkg_info() {
	_xDESC="asynchronous, "crash safe", logger that is easy to use."

	_xFILE="g3log-1.3.tar.gz"
	_xFILE_PATH=g3log-1.3

	_xNAME=g3log/1.3
}

pkg_build() {

	# for cmake
	if [ -e "./_build" ]; then
		log_msg "[CMD] $(pwd) - rm -rf ./_build"
		rm -rf ./_build
	fi
	(
		mkdir -p _build && cd _build && cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX} \
			-DCMAKE_BUILD_TYPE=Release \
		&& make -j 6 && make install
	)
}
