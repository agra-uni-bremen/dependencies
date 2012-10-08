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
version=1.5.116
extra_ver=eeaf10b-121004
source=$package-$version-$extra_ver.tar.gz
build_dir=$build/$package-$version-$extra_ver
url=http://fmv.jku.at/$package/$source

dependencies="minisat-git"

download_unpack() {
  if [ "$duplicate" = "remove" ]; then
    rm -rf $build_dir
  fi
  mkdir -p $(dirname $build_dir) &&
  cd $(dirname $build_dir) &&
  wget -c -O $source $url &&
  tar -xf $source &&
  cd $build_dir &&
  patch -p1 < $package_dir/minisat_include_path.patch &&
  patch -p1 < $package_dir/0003*.patch
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
  cmake_build_install
}
