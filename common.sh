
run_scripts() {
  cd $base_dir
  package_dir=$base_dir/$p
  source $p/setup.sh
  for s in $@; do
    $s
  done
}
