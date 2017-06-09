pkg_info() {
	_xDESC="C++11 Lightweight Redis client: async, thread-safe, no dependency, pipelining, multi-platfor"

	_xFILE="cpp_redis-3.4.0.tar.gz"
	_xFILE_PATH=cpp_redis-3.4.0

	_xNAME=cpp_redis/3.4.0
}

pkg_build() {

	git submodule init
	git submodule update
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
