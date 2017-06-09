pkg_info() {
	_xDESC="high-performance and widely portable implementation of the Message Passing Interface (MPI) standard (MPI-1, MPI-2 and MPI-3)"

	_xFILE="mpich-3.2.tar.gz"
	_xFILE_PATH=mpich-3.2

	_xNAME=mpich/3.2
}

pkg_build() {
	./configure --prefix=${PREFIX} --disable-fortran --disable-f77 && make -j 6 && make install

	#--with-pm=hydra \
	#--enable-alloca \
	#--disable-fc \
	#--enable-smpcoll \
	#--enable-romio \
	#--enable-mpe \
	#--with-file-system=nfs+ufs \
	#--enable-cxx \
	#--enable-threads=multiple \
	#--enable-versioning \
	#--enable-thread-cs=global \
	#--enable-async-progress \
	#--enable-dependencie"
	#--enable-threads \
	#--with-thread-package=posix \
}
