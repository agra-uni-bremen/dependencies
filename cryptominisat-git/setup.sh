#!/bin/sh

if [ -z "$build" ] ; then
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then
  echo '$build is undefined'
  exit 1
fi

version=git
package=cryptominisat
source=$package-$version.tar.bz2
build_dir=$build/${package}-${version}
url="https://github.com/msoos/cryptominisat.git"

dependencies="m4ri-20140914 boost-1_55_0"

download() {
  download_git "$build_dir" "$url" "master"
}

unpack() {
  true
}

pre_build() {
  cd "$build_dir" &&
  git apply $package_dir/*.patch
}

build_install() {
  if [ -z "$target" ] ; then
    echo '$target is undefinded'
    exit 1
  fi
  # Note that the directory is packaged with an additional '4' in the name
  cd "$build_dir" &&
  export CMAKE_PREFIX_PATH="$root/m4ri-20140914:$root/boost-1_55_0" &&
  cmake_build_install .. \
	-DCMAKE_DISABLE_FIND_PACKAGE_PythonInterp=true \
	-DCMAKE_DISABLE_FIND_PACKAGE_PythonLibs=true
}
