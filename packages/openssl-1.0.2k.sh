pkg_info() {
    _xDESC="Lua is a powerful, efficient, lightweight, embeddable scripting language"

    _xFILE="openssl-1.0.2k.tar.gz"
    _xFILE_PATH=openssl-1.0.2k

    _xNAME=openssl/1.0.2k
}

pkg_build() {
    if [ ${vOS} = "Darwin" ]; then
        BUILD_OPTION="shared darwin64-x86_64-cc"
    elif [ ${vOS} = "Linux" ]; then
        BUILD_OPTION="shared linux-x86_64"
    fi
    ./Configure --prefix=${PREFIX} ${BUILD_OPTION} && make -j 6 && make install
}
