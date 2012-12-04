#!/bin/sh

version=1.5.118
extra_ver=6b56be4-121013

dependencies="minisat-git"

patches_dir=$base_dir/boolector-1.5.115
cmake_files_dir=$base_dir/boolector-1.5.115

source $base_dir/boolector-1.5.115/shared.sh

# vim: te=2 sw=2 et