#!/bin/sh

if [ -z "$build" ] ; then
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then
  echo '$build is undefined'
  exit 1
fi

package=ninja
version=release
source=nosourcefile
build_dir=$build/$package-$version
url=git://github.com/martine/ninja.git

download_unpack() {
  mkdir -p $build_dir &&
  cd $build_dir &&
  if [ -d .git ]; then
    git pull
  else
    git clone $url . -b $version
  fi
}

pre_build() {
  true
}

build_install() {
  if [ -z "$target" ] ; then
    echo '$target is undefined'
  exit 1
  fi
  cd "$build_dir" &&
  python bootstrap.py &&
  mkdir -p "$target/bin"
  cp "ninja" "$target/bin"
}
