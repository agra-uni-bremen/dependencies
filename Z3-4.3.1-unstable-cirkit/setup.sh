#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi

version=4.3.1-unstable
package=Z3
source=z3-$version.tar.gz
build_dir=$build/$package-$version
url='http://www.informatik.uni-bremen.de/revkit/files/z3-4.3.1-unstable.tar.gz' 

download() {  
  cd $cache &&
  if [ ! -f $source ]; then
    download_http $source $url
  fi
}

unpack() {
  mkdir -p $build_dir &&
  tar xfzv $source -C $build_dir
}
  
pre_build() {
  true
}
 
build_install() {
  if [ -z "$target" ] ; then
    echo '$target is undefinde'
    exit 1
  fi
  cd "$build_dir/z3-4.3.1" &&
  python scripts/mk_make.py --prefix="$target" &&
  cd build &&
  sed -i '/site-packages/d' Makefile && 
  make &&
  make install &&
  cp "$package_dir/Z3Config.cmake" "$target"
}

