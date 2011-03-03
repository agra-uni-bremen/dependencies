#!/bin/sh


if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi


package=aiger
version=20071012
source=$package-$version.zip
build_dir=$build/$package-$version
url=http://fmv.jku.at/aiger/$source

download_unpack() {
  cd $build &&
  [ -f $source ] || wget -O $source $url &&
  unzip -o $source
}


pre_build() {
  cd $build_dir &&
  find $package_dir -name CMakeLists.txt| while read f
  do
    ln -sf $f $(echo "$f" |sed "s@^$package_dir/@@")
  done
}

build_install() {
  if [ -z "$target" ] ; then 
    echo '$target is undefined'
    exit 1
  fi
  cd $build_dir &&
  mkdir -p build &&
  cd build &&
  cmake .. -DCMAKE_INSTALL_PREFIX=$target &&
  make install
}
