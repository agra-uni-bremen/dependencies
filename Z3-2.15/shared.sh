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
case "$ARCH" in
  i?86)   
    source=z3-$version.tar.gz
    src_dest=$src_dir/z3-$version
    ;;
  x86_64)
    source=z3-x64-$version.tar.gz
    src_dest=$src_dir/z3-x64-$version
    ;;
  *) error "$package not avaiable for architechture $ARCH"; ;;
esac
url=http://research.microsoft.com/projects/z3/$source

download() {
  cd $src_dir &&
  download_http $source "$url"
  cd -
}

unpack() {
  cd $src_dir &&
  tar -xf $source &&
  rm -rf $src_dest &&
  mv -f z3 $src_dest
}

download_unpack() {
  download &&
  unpack
}

pre_build() {
  cp $cmake_config_file $src_dest
  sed -i "1s/.*$/set(Z3_VERSION $version)\n&/g" $src_dest/Z3Config.cmake
}

build_install() {
  if [ -z "$target" ] ; then 
    echo '$target is undefined'
    exit 1
  fi
  mkdir -p $target &&
  cp -r $src_dest/* $target &&
  rm -rf $src_dest
}
