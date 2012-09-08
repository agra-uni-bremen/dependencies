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
version=1_50_0
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
  ./bjam -q $COMMON_OPTS $LIBRARIES install || {
    if [ ! -f /usr/include/zlib.h ] ; then
      echo 'zlib.h was not found.'
    fi
    if [ ! -f /usr/include/bzlib.h ] ; then
      echo 'bzlib.h was not found'
    fi
    PYTHON_NEEDED=`ls /usr/include/python*/Python.h &>/dev/null && echo false || echo true`
    if [ "$PYTHON_NEEDED" = "true" ] ; then
      echo 'Python.h was not found'
    fi
    echo "Install the packages containing the above header files to compile boost properly."
    exit 1
  }
}

# vim: ts=2 sw=2 et
