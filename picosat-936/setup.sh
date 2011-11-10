#!/bin/sh


if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$package_dir is undefined'
  exit 1
fi


package=picosat
version=936
source=$package-$version.tar.gz
build_dir=$build/$package-$version
url=http://fmv.jku.at/$package/$source

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
