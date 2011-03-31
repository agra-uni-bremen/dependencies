#!/bin/sh


if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi


package=swig
version=2.0.2
source=${package}-$version.tar.gz
build_dir=$build/${package}-$version
url=http://ovh.dl.sourceforge.net/project/${package}/${package}/${package}-${version}/$source

download_unpack() {
  cd $build &&
  wget -c -O $source $url &&
  tar -xf $source &&
  cd $build_dir &&
  wget -c ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.12.tar.gz
}


pre_build() {
  true
}

build_install() {
  if [ -z "$target" ] ; then 
    echo '$target is undefined'
    exit 1
  fi
  COMMON_OPTS="
    --prefix=$target
  "
  cd $build_dir &&
  ./Tools/pcre-build.sh &&
  ./configure $COMMON_OPTS &&
  make &&
  make install
}

# vim: ts=2 sw=2 et
