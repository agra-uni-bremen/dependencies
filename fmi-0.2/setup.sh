#!/bin/sh

if [ -z "$build" ] ; then
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then
  echo '$build is undefined'
  exit 1
fi

package=fmi
version="0.2"
source="$package-$version.tar.gz"
build_dir=$build/$package-$version
url="http://www.informatik.uni-bremen.de/revkit/files/$source"

download_unpack() {
  cd $build &&
  wget -O $source $url &&
  message "unpacking $package" &&
  tar xvfz $source &&
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

  # build
  cd "$build_dir/fmi" &&
  cmake -DCMAKE_INSTALL_PREFIX=$target
  make install
}

