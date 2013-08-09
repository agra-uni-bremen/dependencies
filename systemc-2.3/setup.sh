#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi

version=2.3
branch=master
package=systemc
source=nosourcefile
build_dir=$build/$package-$version
url=https://github.com/systemc/systemc-2.3

download() {
  mkdir -p $cache/$package-$version &&
  cd $cache/$package-$version &&
  if [ -d .git ]; then
    git pull
  else
    git clone $url .
    git checkout $branch
  fi
}

unpack() {
  cp -Ru $cache/$package-$version $build_dir
}
  
pre_build() {
   mkdir -p "$target"
}
 
build_install() {
  if [ -z "$target" ] ; then
    echo '$target is undefinde'
    exit 1
  fi
  cd "$build_dir" &&
  mkdir objdir -p &&
  cd objdir &&
 ../configure --prefix="$target" &&
  make -j$num_threads &&
  make -j$num_threads install &&
  cp "$package_dir/SystemCConfig.cmake" "$target" &&
  arch=$(grep "TARGET_ARCH" Makefile | awk '{print $NF}') &&
  sed -i "s/ARCH/$arch/g" "$target/SystemCConfig.cmake"
}
