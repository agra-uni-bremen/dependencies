#!/bin/sh


if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi

package=cmake
version=2.8.8
source=${package}-$version.tar.gz
build_dir=$build/${package}-$version
url="http://www.cmake.org/files/v${version:0:3}/$source"

download_unpack() {
  cd $build &&
  [ -f $source ] || download_http $source $url &&
  tar -xf $source
}


pre_build() {
  true
}

build_install() {
  if [ -z "$target" ] ; then 
    echo '$target is undefined'
    exit 1
  fi
  cd $build_dir &&
  ./configure --prefix=$target &&
  make &&
  make install
}

# vim: ts=2 sw=2 et
