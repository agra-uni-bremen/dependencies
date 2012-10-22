#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi

package=cudd
source=$package-$version.tar.gz
build_dir=$build/$package-$version
url=ftp://vlsi.colorado.edu/pub/$source

unpack(){
  cd $cache &&
  tar -xf $source &&
  rm -rf $build_dir &&
  mv -f $cache/$package-$version $build_dir
}

pre_build() {
  cd $build_dir &&
  install_cmake_files $cmake_files_dir
}

build_install() {
  if [ -z "$target" ] ; then 
    echo '$target is undefined'
    exit 1
  fi
  cd $build_dir &&
  mkdir -p build &&
  cd build &&
  cmake .. -DCMAKE_INSTALL_PREFIX=$target &&
  make -j$num_threads install
}

# vim: ts=2 sw=2 et
