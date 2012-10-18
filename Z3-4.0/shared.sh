#!/bin/sh

source "$base_dir/Z3-2.15/shared.sh"

unset -f unpack
unpack() {
  cd $cache &&
  tar -xf $source &&
  cd z3/include &&
  patch -p1 < $patch_file &&
  cd ../.. &&
  rm -rf $build_dir &&
  mv -f z3 $build_dir
}

# vim: ts=2 sw=2 et
