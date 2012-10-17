#!/bin/sh

version=4.1

cmake_config_file="$base_dir/Z3-2.19/Z3Config.cmake"
patch_file="$base_dir/Z3-4.0/Z3-4.x.inline.patch"
source "$base_dir/Z3-4.0/shared.sh"

# vim: ts=2 sw=2 et