#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi

version=20140914
package=m4ri
source=$package-$version.tar.gz
build_dir=$build/$package-$version
url="http://m4ri.sagemath.org/downloads/m4ri/$source"

download() {  
  cd $cache &&
  if [ ! -f $source ]; then
    download_http $source $url
  fi
}

unpack() {
  echo $PWD &&
  mkdir -p $build_dir &&
  tar xfz $source -C $build_dir
}
  
build_install() {
  if [ -z "$target" ] ; then
    echo '$target is undefinded'
    exit 1
  fi
  cd "$build_dir" &&
  cd $package-$version
  ./configure --prefix="$target" &&
  make &&
  make install
}

