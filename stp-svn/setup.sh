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
url=https://svn.code.sf.net/p/stp-fast-prover/code/trunk/stp

download() {
  mkdir -p $cache/$package-$version &&
  cd $cache/$package-$version &&
  if [ -d .svn ]; then
    svn update
  else
    svn co $url .
  fi
  svn revert -R .
}

unpack() {
  cd $cache/$package-$version &&
  patch -p0 < $package_dir/added-pic-flags.patch &&
  echo grep1 &&
  grep -lr '\<namespace Minisat\>' src --exclude="*.svn*" | xargs -r sed -i 's/\<namespace Minisat\>/namespace MinisatSTP/g' &&
  echo grep2 &&
  grep -lr '\<Minisat::' src --exclude="*.svn*" | xargs -r sed -i 's/\<Minisat::/MinisatSTP::/g' &&
  echo done &&
  cd .. &&
  cp -R $cache/$package-$version $build_dir
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
