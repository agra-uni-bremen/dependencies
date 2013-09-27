#!/bin/sh

if [ -z "$build" ] ; then
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then
  echo '$build is undefined'
  exit 1
fi

package=gcc
source="gcc-$version.tar.bz2"
build_dir=$build/$package-$version
url="http://ftp.gwdg.de/pub/misc/gcc/releases/$package-$version/$source"

dependencies="gmp-$version_gmp mpfr-$version_mpfr mpc-$version_mpc"

unpack() {
  cd $cache &&
  tar -xf $source &&
  rm -rf $build_dir &&
  mv -f $package-$version $build_dir
}

pre_build() {
  true
}

build_install() {
  if [ -z "$target" ] ; then
    echo '$target is undefined'
  exit 1
  fi
  cd "$build_dir" &&
  GCCMACHINE=`gcc -dumpmachine`
  GCCVERSION=`gcc -dumpversion`
  export CFLAGS="-O2 -I/usr/include/$GCCMACHINE"
  export LDFLAGS="-O2 -B/usr/lib/$GCCMACHINE -L/usr/lib/$GCCMACHINE"
  export LIBRARY_PATH=/usr/lib/$GCCMACHINE
  #make distclean
  local OPTS="
    --prefix=$target
    --with-gmp=$root/gmp-$version_gmp
    --with-mpfr=$root/mpfr-$version_mpfr
    --with-mpc=$root/mpc-$version_mpc
    --disable-multilib
    --enable-languages=c,c++
  "
  echo ./configure $OPTS  &&
  ./configure $OPTS  &&
  make -j5$num_threads &&
  make install
}

