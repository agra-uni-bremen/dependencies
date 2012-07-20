#!/bin/sh


if [ -z "$build" ] ; then
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then
  echo '$build is undefined'
  exit 1
fi


package=boost
version=1_48_0
source=${package}_$version.tar.bz2
build_dir=$build/${package}_$version
url=http://osdn.dl.sourceforge.net/project/boost/boost/${version//_/.}/$source

addon_package=boost-log
addon_version=1.1
addon_source=${addon_package}-${addon_version}.zip
addon_dir=${addon_package}-${addon_version}
addon_url="http://downloads.sourceforge.net/project/boost-log/boost-log-1.1.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fboost-log%2F&ts=1327405540&use_mirror=dfn"

download_unpack() {
  cd $build &&
  download_http $source $url &&
  download_http $addon_source $addon_url &&
  message "unpacking $package" &&
  tar -xf $source &&
  message "finished unpacking $package" &&
  message "unpacking $addon_package" &&
  unzip -o $addon_source &&
  message "finished unpacking $addon_package"
}

pre_build() {
  cp $build/$addon_dir/boost $build_dir -R &&
  cp $build/$addon_dir/libs $build_dir -R
}

build_install() {
  if [ -z "$target" ] ; then
    echo '$target is undefined'
    exit 1
  fi
  COMMON_OPTS="
    --prefix=$target
    --layout=system
    variant=release
    link=shared
    toolset=gcc
  "
  LIBRARIES="
    --with-date_time
    --with-filesystem
    --with-graph
    --with-iostreams
    --with-math
    --with-program_options
    --with-python
    --with-random
    --with-regex
    --with-serialization
    --with-signals
    --with-system
    --with-thread
    --with-log
  "
  cd $build_dir &&
  mkdir -p build &&
  test -x bjam || ./bootstrap.sh &&
  ./bjam -q $COMMON_OPTS $LIBRARIES install
}

# vim: ts=2 sw=2 et
