#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi

version=git
branch=master
package=Z3
source=nosourcefile
build_dir=$build/$package-$version
url='https://github.com/Z3Prover/z3.git'

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
  cp -R $cache/$package-$version $build_dir
}
  
pre_build() {
  true
}
 
build_install() {
  if [ -z "$target" ] ; then
    echo '$target is undefinde'
    exit 1
  fi
  cd "$build_dir" &&
  python scripts/mk_make.py --staticlib --prefix="$target" &&
  cd build &&
  make -j $num_threads &&
  make install &&
  cp "$package_dir/Z3Config.cmake" "$target"
}
