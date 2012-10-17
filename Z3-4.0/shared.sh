#!/bin/sh

source "$base_dir/Z3-2.15/shared.sh"

unset -f unpack
unpack() {
  cd $src_dir &&
  tar -xf $source &&
  cd z3/include &&
  patch -p1 < $patch_file &&
  cd ../.. &&
  rm -rf $src_dest &&
  mv -f z3 $src_dest
}

# vim: ts=2 sw=2 et
