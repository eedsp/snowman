pkg_info() {
	_xDESC="C++11 Lightweight Redis client: async, thread-safe, no dependency, pipelining, multi-platform."

	_xFILE="cpp_redis-3.2.0.tar.gz"
	_xFILE_PATH=cpp_redis-3.2.0

	_xNAME=cpp_redis/3.2.0
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
