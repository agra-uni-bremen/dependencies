#!/bin/sh

version=git

source $base_dir/minisat-2.2.0/shared.sh

url=https://github.com/niklasso/minisat.git

unset -f download
download() {
  mkdir -p $build_dir &&
  cd $build_dir &&
  if [ -d .git ]; then
  	env GIT_SSL_NO_VERIFY=true git pull
  else
  	env GIT_SSL_NO_VERIFY=true git clone $url .
  fi
}

unset -f unpack
unpack() {
  true
}

# vim: ts=2 sw=2 et
