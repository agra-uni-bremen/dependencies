#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$package_dir is undefined'
  exit 1
fi

package=boolector
version=2.0.6-with-lingeling-azd
source=$package-$version.tar.bz2
build_dir=$build/$package-$version
url=http://fmv.jku.at/$package/$source

boolector_package=boolector-2.0.6-1dd339d-150306
boolector_prefix=boolector-src

unpack(){
  cd $cache &&
  tar -xf $source &&
  rm -rf $build_dir &&
  tar -xf $package-$version/archives/$boolector_package.tar.gz -C $package-$version/ && 
  cd $package-$version &&
  ln -sf $boolector_package ${boolector_prefix}  && 
  mv -f $cache/$package-$version $build_dir &&
  cd $build_dir/${boolector_prefix} &&
  patch -p1 < $patches_dir/lingeling_include_path.patch
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
