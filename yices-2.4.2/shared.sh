#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$package_dir is undefined'
  exit 1
fi

package=yices
source=$package-$version-src.tar.gz
build_dir=$build/$package-$version
url="http://yices.csl.sri.com/cgi-bin/yices2-newnewdownload.cgi?file=$source&accept=I+Agree"

unpack(){
  cd $cache &&
  tar -xf $source &&
  cd 
  rm -rf $build_dir &&
  mv -f $cache/$package-$version $build_dir
}

pre_build() {
  cd $build_dir
}

build_install() {
  if [ -z "$target" ] ; then 
    echo '$target is undefined'
    exit 1
  fi
  cd $build_dir &&
  ./configure --prefix="$target" &&
  make &&
  make install &&
  cp $config_files_dir/yices2-config.cmake "$target"
}

# vim: ts=2 sw=2 et
