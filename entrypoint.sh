previous_dir=$(pwd)
cd $CUSTOM_SCRIPTS_DIR
for script in $(ls -A $CUSTOM_SCRIPTS_DIR); do
  case "$script" in
    *.sh)  echo "$0: running $script"; . "$script";;
       *)  echo "$0: ignoring $script";;
  esac
done
cd $previous_dir

exec $@
byobu
