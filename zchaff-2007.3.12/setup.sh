#!/bin/sh


if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi


package=zchaff
version=2007.3.12
case "$ARCH" in
  i?86)   
    source="${package}.${version}.zip"
    export CFLAGS=-m32
    export CXXFLAGS=-m32
    ;;
  x86_64) 
    source="${package}.64bit.${version}.zip"; ;;
  *) error "$package not avaiable for architechture $ARCH"; ;;
esac
build_dir=$build/$package-$version
url=http://www.princeton.edu/~chaff/zchaff/$source

download_unpack() {
  cd $build &&
  download_http $source $url &&
  rm -rf $build_dir &&
  mkdir -p $build_dir &&
  cd $build_dir &&
  unzip $build/$source &&
  mv */* . &&
  patch -p1 < $package_dir/missing_includes.patch
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
