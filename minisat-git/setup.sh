#!/bin/sh


if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi


package=minisat
version=git
source=nosourcefile
build_dir=$build/$package-$version
url=https://github.com/niklasso/minisat.git

download_unpack() {
  mkdir -p $build_dir &&
  cd $build_dir &&
  if [ -d .git ]; then
  	env GIT_SSL_NO_VERIFY=true git pull
  else
  	env GIT_SSL_NO_VERIFY=true git clone $url .
  fi
}


pre_build() {
  cd $build_dir &&
  install_cmake_files
}

build_install() {
  if [ -z "$target" ] ; then 
    echo '$target is undefined'
    exit 1
  fi
  cd $build_dir &&
  cmake_build_install
}
