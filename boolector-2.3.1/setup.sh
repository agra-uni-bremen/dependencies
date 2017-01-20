#!/bin/sh

version=2.3.1

dependencies="lingeling-bbc-9230380-161217 minisat-git"

patches_dir=$base_dir/boolector-$version
cmake_files_dir=$base_dir/boolector-$version

source $base_dir/boolector-$version/shared.sh
