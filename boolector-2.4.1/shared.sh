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
version=2.4.1-with-lingeling-bbc
source=$package-$version.tar.bz2
build_dir=$build/$package-$version
url=http://fmv.jku.at/$package/$source

boolector_package=boolector-2.4.1-a5b1ac3-170308
boolector_prefix=boolector-src

unpack(){
  cd $cache &&
  tar -xf $source &&
  rm -rf $build_dir &&
  tar -xf $package-$version/archives/$boolector_package.tar.gz -C $package-$version/ && 
  cd $package-$version &&
  ln -sf $boolector_package ${boolector_prefix}  && 
  mv -f $cache/$package-$version $build_dir
  cd $build_dir/${boolector_prefix} &&
  cd src &&
  patch -p1 -i $patches_dir/minisat_include.patch &&
  patch -p1 -i  $patches_dir/lingeling_include_path.patch &&
  patch -p1 < $patches_dir/0014*.patch
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
