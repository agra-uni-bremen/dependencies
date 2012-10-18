#!/bin/sh

if [ -z "$build" ] ; then
  error '$build is undefined'
fi

package=boost
source=${package}_$version.tar.bz2
build_dir=$build/${package}_$version
url=http://osdn.dl.sourceforge.net/project/boost/boost/${version//_/.}/$source

unpack() {
  cd $cache &&
  message "unpacking $package" &&
  tar -xf $source &&
  message "finished unpacking $package"
}

pre_build() {
  rm -rf $build_dir &&
  mv -f $cache/${package}_$version $build_dir
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
  test -x bjam || ./bootstrap.sh &&
  ./bjam -q $COMMON_OPTS $LIBRARIES -j$num_threads install || {
    local needed="false"
    if [ ! -f /usr/include/zlib.h ] ; then
      echo 'zlib.h was not found.'
      needed="true"
    fi
    if [ ! -f /usr/include/bzlib.h ] ; then
      echo 'bzlib.h was not found'
      needed="true"
    fi
    local PYTHON_NEEDED=`ls /usr/include/python*/Python.h &>/dev/null && echo false || echo true`
    if [ "$PYTHON_NEEDED" = "true" ] ; then
      echo 'Python.h was not found'
      needed="true"
    fi
    if [ "$needed" = "true" ] ; then
      echo "Install the packages containing the above header files to compile boost properly."
    fi
    exit 1
  }
}

# vim: ts=2 sw=2 et
