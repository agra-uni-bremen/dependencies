#!/bin/sh

if [ -z "$build" ] ; then
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then
  echo '$build is undefined'
  exit 1
fi

package=puma
version="2.23"
source="$package-$version.tar.gz"
build_dir=$build/$package-$version
url="http://www.informatik.uni-bremen.de/revkit/files/$source"

download_unpack() {
  cd $build &&
  wget -O $source $url &&
  message "unpacking $package" &&
  tar xvfz $source &&
  mv $package $package-$version &&
  message "finished unpacking $package" &&
  cd ..
}

pre_build() {
  true
}

build_install() {
  if [ -z "$target" ] ; then
    echo '$target is undefined'
  exit 1
  fi

  # target directories
  mkdir -p $target/{include,lib}

  # build
  cd "$build_dir/bin" &&
  make puma &&
  cd .. &&
  cp include/*.h $target/include &&
  cp lib/lib_puma.a $target/lib &&
  cd ..
}

