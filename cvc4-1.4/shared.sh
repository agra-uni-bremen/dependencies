#!/bin/sh

if [ -z "$build" ] ; then
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then
  echo '$package_dir is undefined'
  exit 1
fi

package=cvc4
source="$package-$version.tar.gz"
build_dir=$build/$package-$version
url="http://cvc4.cs.nyu.edu/builds/src/$source"

dependencies="libantlr3c-3.4 boost-1_55_0"

unpack() {
  cd $cache &&
  tar -xf $source &&
  mv -f $package-$version $build_dir
  cd $build_dir &&
  patch -p1 < $package_dir/0001-*.patch
}

build_install() {
  if [ -z "$target" ] ; then
    echo '$target is undefined'
  exit 1
  fi

  cd "$build_dir" &&
  # build CVC4 with --bsd to allow usage under the terms of
  # the modified BSD license.
  ./configure --prefix="$target" --bsd --with-antlr-dir=$root/libantlr3c-3.4 --with-boost=$root/boost-1_55_0 &&
  make -j $num_threads &&
  make install &&
  cp -f "$package_dir/CVC4Config.cmake" "$target/CVC4Config.cmake"
}

