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
version=git
source=nosourcefile
build_dir=$build/$package-$version
url=https://github.com/niklasso/minisat.git

download_unpack() {
  mkdir -p $build_dir &&
  cd $build_dir &&
  if [ -d .git ]; then
  	git pull
  else
  	git clone $url .
  fi
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
