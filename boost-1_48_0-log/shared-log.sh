#!/bin/sh

addon_package=boost-log
addon_version=1.1
addon_source=${addon_package}-${addon_version}.zip
addon_dir=${addon_package}-${addon_version}
addon_url="http://downloads.sourceforge.net/project/boost-log/boost-log-1.1.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fboost-log%2F&ts=1327405540&use_mirror=dfn"

source "$base_dir/boost-1_46_0/shared.sh"

unset -f download
download() {
  cd $cache &&
  download_http $source "$url" &&
  download_http $addon_source "$addon_url"
}

unset -f unpack
unpack() {
  cd $cache &&
  message "unpacking $package" &&
  tar -xf $source &&
  message "finished unpacking $package" &&
  message "unpacking $addon_package" &&
  unzip -o $addon_source &&
  message "finished unpacking $addon_package"
}

unset -f pre_build
pre_build() {
  cd $cache &&
  rm -rf $build_dir &&
  mv -f ${package}_$version $build_dir &&
  cp -R $cache/$addon_dir/boost $build_dir &&
  cp -R $cache/$addon_dir/libs $build_dir &&
  rm -rf $cache/$addon_dir

}

# vim: ts=2 sw=2 et
