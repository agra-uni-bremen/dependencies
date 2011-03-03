#!/bin/sh


if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi


package=boost
version=1_46_0
source=${package}_$version.tar.bz2
build_dir=$build/${package}_$version
url=http://ovh.dl.sourceforge.net/project/boost/boost/${version//_/.}/$source

download_unpack() {
  cd $build &&
  [ -f $source ] || wget -O $source $url &&
  tar -xf $source
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
    --layout=system
    variant=release
    link=shared
    toolset=gcc
  "
  LIBRARIES=" 
    --with-date_time
    --with-filesystem
    --with-graph
    --with-iostreams
    --with-math
    --with-program_options
    --with-random
    --with-regex
    --with-serialization
    --with-signals
    --with-system
    --with-thread
  "
  cd $build_dir &&
  mkdir -p build &&
  test -x bjam || ./bootstrap.sh &&
  ./bjam $COMMON_OPTS $LIBRARIES install
}

# vim: ts=2 sw=2 et
