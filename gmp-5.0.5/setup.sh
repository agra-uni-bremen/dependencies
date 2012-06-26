#!/bin/sh

if [ -z "$build" ] ; then
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then
  echo '$build is undefined'
  exit 1
fi

package=gmp
version="5.0.5"
source="$package-$version.tar.bz2"
build_dir=$build/$package-$version
url="ftp://ftp.gmplib.org/pub/$package-$version/$source"

download_unpack() {
  cd $build &&
  download_http $source $url &&
  message "unpacking $package" &&
  tar -xf $source &&
  message "finished unpacking $package"
}

pre_build() {
  true
}

build_install() {
  if [ -z "$target" ] ; then
    echo '$target is undefined'
  exit 1
  fi

  # build mpfr
  cd "$build_dir" &&
  ./configure --prefix=$target &&
  make &&
  make install
}

