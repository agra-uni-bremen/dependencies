#!/bin/sh

version=svn

if [ -z "$build" ] ; then
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then
  echo '$build is undefined'
  exit 1
fi

package=glog
source=nosourcefile
build_dir=$build/$package-$version
url=http://google-glog.googlecode.com/svn/trunk/

download() {
  mkdir -p $build_dir &&
  cd $build_dir &&
  if [ -d .svn ]; then
    svn update
  else
    svn checkout $url .
  fi
}

unpack() {
  true
}

build_install() {
  if [ -z "$target" ] ; then
    error '$target is undefined'
  fi
  cd "$build_dir" &&

  ./configure --prefix="$target" &&
  make -j && make install
}

# vim: ts=2 sw=2 et
