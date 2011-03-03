skip=${skip:-y}
delete=${delete:-n}

error() {
  echo "ERROR: $@" >&2
  echo "TERMINATING" >&2
  exit 1
}

run_scripts() {
  cd $base_dir
  package_dir=$base_dir/$p
  source $p/setup.sh
  for s in $@; do
    $s
  done
}
