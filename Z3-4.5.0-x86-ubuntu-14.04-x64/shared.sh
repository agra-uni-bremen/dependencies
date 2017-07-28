#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$package_dir is undefined'
  exit 1
fi
package=z3
source=$package-$version.zip
build_dir=$build/$package-$version
url=https://github.com/Z3Prover/z3/releases/download/$package-$version2/$source

unpack(){
  cd $cache &&
  message "unpacking $package" &&
  unzip $source &&
  message "finished unpacking $package" &&
  rm -rf $build_dir &&
  mv -f $cache/$package-$version $build_dir
}

pre_build() {
  cp $cmake_config_file $build_dir
  sed -i "1s/.*$/set(Z3_VERSION $version)\n&/g" $build_dir/Z3Config.cmake
}

build_install() {
  if [ -z "$target" ] ; then 
    echo '$target is undefined'
    exit 1
  fi
  mkdir -p $target &&
  cp -r $build_dir/* $target
}

# vim: ts=2 sw=2 et
