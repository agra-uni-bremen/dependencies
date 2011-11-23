#!/bin/sh


if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi

package=lingeling
version=587-9c0f11d-110302
source=$package-$version.tar.gz
build_dir=$build/$package-$version
url=http://www.informatik.uni-bremen.de/~sfrehse/$source 
echo "Download lingeling from $url"

download_unpack() {
  if [ "$duplicate" = "remove" ]; then
    rm -rf $build_dir
  fi
  mkdir -p $(dirname $build_dir) &&
  cd $(dirname $build_dir) &&
  [ -f $source ] || wget -O $source $url &&
  tar -xf $source
}


pre_build() {
  cd $build_dir &&
  install_cmake_files
}

build_install() {
  if [ -z "$target" ] ; then 
    echo '$target is undefined'
    exit 1
  fi
  cd $build_dir &&
  cmake_build_install
}
