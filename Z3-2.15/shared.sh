#!/bin/sh

if [ -z "$build" ] ; then 
  error '$build is undefined'
fi

package=Z3
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
url=http://research.microsoft.com/projects/z3/$source

unpack() {
  cd $cache &&
  tar -xf $source &&
  rm -rf $build_dir &&
  mv -f z3 $build_dir
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