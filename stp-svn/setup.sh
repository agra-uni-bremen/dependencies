#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi

package=stp
version=svn
source=nosourcefile
build_dir=$build/$package-$version
url=https://stp-fast-prover.svn.sourceforge.net/svnroot/stp-fast-prover/trunk/stp

download_unpack() {
  mkdir -p $build_dir &&
  cd $build_dir &&
  if [ -d .svn ]; then
    svn update
  else
    svn co $url .
  fi
  patch -p0 < $package_dir/added-pic-flags.patch
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
  ./clean-install.sh --with-prefix="$target" &&
  cp "$package_dir/STPConfig.cmake" "$target"
}
