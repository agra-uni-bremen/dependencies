#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$package_dir is undefined'
  exit 1
fi
boolector_package=boolector
boolector_version=2.3.1-with-lingeling-bbc
boolector_source=$boolector_package-$boolector_version.tar.bz2
boolector_build_dir=$build/$boolector_package-$boolector_version

package=lingeling
version=bbc-9230380-161217
source=$package-$version.tar.gz
build_dir=$build/$package-$version
url=http://fmv.jku.at/$boolector_package/$boolector_source

unpack(){
  cd $cache &&
  tar -xf $source &&
  rm -rf $build_dir &&
  mkdir -p $package-$version &&
  tar -xf $boolector_package-$boolector_version/archives/$package-$version.tar.gz && 
  mv -f $cache/$package-$version $build_dir
}

pre_build() {
  cd $build_dir &&
  install_cmake_files $cmake_files_dir
}

build_install() {
  if [ -z "$target" ] ; then 
    echo '$target is undefined'
    exit 1
  fi
  cd $build_dir &&
  cmake_build_install
}

# vim: ts=2 sw=2 et
