pkg_info() {
	_xDESC="an unsupervised text tokenizer and detokenizer mainly for Neural Network-based text generation systems"

    _xURL="https://github.com/google/sentencepiece.git"
	_xFILE="sentencepiece-0.1.0.tar.gz"
	_xFILE_PATH=sentencepiece-0.1.0

	_xNAME=sentencepiece/0.1.0
}

pkg_build() {

    func_pkgconfig "icu" "protobuf"

	log_msg "[INFO] ${_OS_NAME}"

    for _vPATH_ in "/usr/local" "${APP}"
    do
        if [ -e "${_vPATH_}" ]; then
            export PROTOBUF=${_vPATH_}
            export PROTOC=${PROTOBUF}/bin/protoc
            export PROTOBUF_LIBS="-L${PROTOBUF}/lib -lprotobuf -D_THREAD_SAFE"
            export PROTOBUF_CFLAGS="-I${PROTOBUF}/include -D_THREAD_SAFE"
            break
        fi
    done

	# for make
	(
        if [ -e "./autogen.sh" ]; then
            ./autogen.sh
        fi
        if [ -e "./configure" ]; then
            ./configure --prefix=${PREFIX} && make -j 6 && make install
        fi
	)
}
