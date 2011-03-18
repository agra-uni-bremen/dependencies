#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi




package=SWORD
version=1.1

case "$ARCH" in
  i?86)   source="sword-${version}-32bit.tar.gz"; ;;
  x86_64) source="sword-${version}-64bit.tar.gz"; ;;
  *) error "$package not avaiable for architechture $ARCH"; ;;
esac

build_dir=$build/${source/.tar.gz}
url=http://www.informatik.uni-bremen.de/agra/doc/software/$source

download_unpack() {
  cd $build &&
  [ -f $source ] || wget -O $source $url &&
  tar -xf $source
}


pre_build() {
  cp $package_dir/SWORDConfig.cmake $build_dir
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
