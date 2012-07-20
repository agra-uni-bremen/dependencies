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
version=1_46_1
source=${package}_$version.tar.bz2
build_dir=$build/${package}_$version
url=http://osdn.dl.sourceforge.net/project/boost/boost/${version//_/.}/$source

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
    --with-python
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
  ./bjam -q $COMMON_OPTS $LIBRARIES install
}

# vim: ts=2 sw=2 et
