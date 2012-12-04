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
source=$package-$version-$extra_ver.tar.gz
build_dir=$build/$package-$version-$extra_ver
url=http://fmv.jku.at/$package/$source

unpack() {
  cd $cache &&
  tar -xf $source &&
  rm -rf $build_dir &&
  mv -f $cache/$package-$version-$extra_ver $build_dir &&
  cd $build_dir &&
  patch -p1 < $patches_dir/minisat_include_path.patch &&
  patch -p1 < $patches_dir/0003*.patch &&
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

# vim: t2=2 sw=2 et
