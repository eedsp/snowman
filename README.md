# snowman
Do You Want to Build a Snowman?

simple package build script for macOS/Linux.
It was inspired by [Homebrew](https://homebrew.sh).

## Setting the environment variable

Setting the 'snowman' environment variable

```shell
% git clone https://github.com/eedsp/snowman.git

% export PKG_BUILD_PATH=${HOME}/snowman
% export PKG_BUILD_SOURCE_PATH=${HOME}/download
```

Setting the environment variable for package to be installed:

```shell
% export APP_PREFIX=${HOME}/_local
% export PKG_PREFIX=${HOME}/_pkg
```

## how to build a package with snowman

- download a file to build & install: cmake-3.10.2

```shell
% cd ${PKG_BUILD_SOURCE_PATH}
% wget "https://cmake.org/files/v3.10/cmake-3.10.2.tar.gz"

% ${PKG_BUILD_PATH}/script/pkg.build.sh cmake-3.10.2.conf

% cd $${APP_PREFIX}/opt
% ls -l cmake
```

or

```shell
% cd ${HOME}/download
% wget "https://cmake.org/files/v3.10/cmake-3.10.2.tar.gz"

% tar xvfz cmake-3.10.2.tar.gz
% cd cmake-3.10.2
% cp ${PKG_BUILD_PATH}/packages/cmake-3.10.2.conf
% ${PKG_BUILD_PATH}/script/pkg.build.sh -f cmake-3.10.2.conf

% cd $${APP_PREFIX}/opt
% ls -l cmake
```

```shell
% cd ${PKG_BUILD_PATH}/script

% vi pkg.list.conf         # edit for package version

% ./pkg.admin.sh reset      # clean up ${APP_PREFIX}/{bin, lib, include}
% ./pkg.admin.sh opt        # create symbolic link for ${APP_PREFIX}/opt
% ./pkg.admin.sh pkg        # create symbolic link for ${APP_PREFIX}/{bin, lib, include}
```

- check ${APP_PREFIX} PATH

```shell
% ls -l ${APP_PREFIX}

% ls -l ${APP_PREFIX}/opt

% ls -l ${APP_PREFIX}/bin
% ls -l ${APP_PREFIX}/lib
% ls -l ${APP_PREFIX}/include
```
- add ${APP_PREFIX}/bin to the `PATH` environment variable

```shell
% export PATH=${PATH}:${APP_PREFIX}/bin
```

- add ${APP_PREFIX}/lib to the `LD_LIBRARY_PATH` environment variable
```shell
% export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${APP_PREFIX}/lib
```

## License
Licensed under an [Apache-2.0](https://github.com/dmlc/mxnet/blob/master/LICENSE) license.
