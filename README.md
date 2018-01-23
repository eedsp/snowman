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
```shell

Setting the environment variable for package to be installed:

```shell
    % export APP_PREFIX=${HOME}/_local
    % export PKG_PREFIX=${HOME}/_pkg
```shell

## how to build a package with snowman

- download a file to build & install: cmake-3.10.2

```shell
    % cd ${PKG_BUILD_SOURCE_PATH}
    % wget "https://cmake.org/files/v3.10/cmake-3.10.2.tar.gz"

    % tar xvfz cmake-3.10.2.tar.gz
    % cd cmake-3.10.2
    % cp ${PKG_BUILD_PATH}/packages/cmake-3.10.2.conf
    % ${PKG_BUILD_PATH}/script/pkg.build.sh -f cmake-3.10.2.conf

    % cd $${APP_PREFIX}/opt
    % ls -l cmake
```shell


## License
Licensed under an [Apache-2.0](https://github.com/dmlc/mxnet/blob/master/LICENSE) license.
