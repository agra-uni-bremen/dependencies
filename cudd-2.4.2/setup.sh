#!/bin/sh


if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi


package=cudd
version=2.4.2
source=$package-$version.tar.gz
build_dir=$build/$package-$version
url=ftp://vlsi.colorado.edu/pub/$source

download_unpack() {
  mkdir -p $(dirname $build_dir) &&
  cd $(dirname $build_dir) &&
  [ -f $source ] || wget -O $source $url &&
  tar -xf $source
}


pre_build() {
  cd $build_dir &&
  find $package_dir -name CMakeLists.txt| while read f
  do
    ln -sf $f ${f/$package_dir\//}
  done
}

build_install() {
  cd $build_dir &&
  mkdir -p build &&
  cd build &&
  cmake .. -DCMAKE_INSTALL_PREFIX=$build_dir/root &&
  make install
}
