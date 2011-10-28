#!/bin/sh


if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi


package=minisat
version=2.2.0
source=$package-$version.tar.gz
build_dir=$build/$package-$version
url=http://minisat.se/downloads/$source
download_unpack() {
  mkdir -p $build_dir &&
  cd $build_dir &&
  download_http $source $url &&
  tar -xzf $source --strip=1 -C $build_dir
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
