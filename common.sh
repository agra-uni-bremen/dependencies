
error() {
  echo "ERROR: $@" >&2
  echo "TERMINATING" >&2
  exit 1
}

message() {
  echo "$@"
}

run_scripts() {
  cd $base_dir
  package_dir=$base_dir/$p
  source $p/setup.sh
  for s in $@; do
    echo "calling $s for $p"
    $s
  done
}

with_deps() {
  build="-"
  local i
  local dependencies
  for i in $@; do
    package_dir=$i
    source $package_dir/setup.sh
    with_deps $dependencies
    echo $i
  done
}


#
# install all CMakeLists.txt files from the package to the current folder.
# includes subfolders and keeps hierarchy
#
# currently all files ar symlinked.
#
install_cmake_files() {
  find $package_dir -name CMakeLists.txt -o -name "*.cmake"| while read f
  do
    ln -sf $f $(echo "$f" |sed "s@^$package_dir/*@@")
  done
}

setup_environment() {
  ARCH=${ARCH:-$(uname -m)}
  duplicate=${duplicate:-skip}
}

setup_environment


# vim: ts=2 sw=2 et
