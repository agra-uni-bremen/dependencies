#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi

package=Z3
version=2.19
case "$ARCH" in
  i?86)   
    source=z3-$version.tar.gz
    build_dir=$build/z3-$version
    ;;
  x86_64)
    source=z3-x64-$version.tar.gz
    build_dir=$build/z3-x64-$version
    ;;
  *) error "$package not avaiable for architechture $ARCH"; ;;
esac
build_dir=$build/z3-x64-$version
url=http://research.microsoft.com/projects/z3/$source

download_unpack() {
  cd $build &&
  download_http $source "$url" && 
  tar -xf $source &&
  rm -rf $build_dir &&
  mv -f z3 $build_dir
}


pre_build() {
  cp $package_dir/Z3Config.cmake $build_dir
}

build_install() {
  if [ -z "$target" ] ; then 
    echo '$target is undefined'
    exit 1
  fi
  mkdir -p $target &&
  cp -r $build_dir/* $target 
}
