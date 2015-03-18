#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi

version=4.3.1
package=Z3
source=z3-$version.zip
build_dir=$build/$package-$version
url='http://download-codeplex.sec.s-msft.com/Download/SourceControlFileDownload.ashx?ProjectName=z3&changeSetId=89c1785b73225a1b363c0e485f854613121b70a7' 

download() {  
  cd $cache &&
  if [ ! -f $source ]; then
    download_http $source $url
  fi
}

unpack() {
  mkdir -p $build_dir &&
  unzip -o $source -d $build_dir
}
  
pre_build() {
  true
}
 
build_install() {
  if [ -z "$target" ] ; then
    echo "$target is undefinded"
    exit 1
  fi
  cd "$build_dir" &&
  autoconf &&
  ./configure --prefix="$target" &&
  python scripts/mk_make.py &&
  cd build &&
  sed -i '/site-packages/d' Makefile && 
  make &&
  make install &&
  cp "$package_dir/Z3Config.cmake" "$target"
}

