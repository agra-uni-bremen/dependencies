#!/bin/sh


if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$package_dir is undefined'
  exit 1
fi


package=boolector
version=1.4.1
extra_ver=376e6b0-110304
source=$package-$version-$extra_ver.tar.gz
build_dir=$build/$package-$version-$extra_ver
url=http://fmv.jku.at/$package/$source

dependencies="picosat-936"

download_unpack() {
  mkdir -p $(dirname $build_dir) &&
  cd $(dirname $build_dir) &&
  wget -c -O $source $url &&
  tar -xf $source &&
  cd $build_dir &&
  patch -p1 < $package_dir/picosat_include_path.patch &&
  patch -p1 < $package_dir/0001*.patch &&
  patch -p1 < $package_dir/0003*.patch &&
  patch -p1 < $package_dir/0004*.patch &&
  patch -p1 < $package_dir/0014*.patch
}


pre_build() {
  cd $build_dir &&
  install_cmake_files
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
  make install
}
